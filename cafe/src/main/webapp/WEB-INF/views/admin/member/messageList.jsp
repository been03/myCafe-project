<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />    
<style>
   @import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
   .message_list_wrap{
      width: 920px;
      margin: 50px auto 0;
   }
   .message_list_wrap input[type=submit]{
      	font-family: 'Poor Story', cursive !important;
      	border:1px solid #ef962d;
      	background: #ef962d;
    	font-weight: bold;
   }
   .message_list_wrap h2 {
   		font-size:30px;
   		margin-bottom:20px
   }
   .search_div {
   		float:right;
   		display:inline-block;
   		height:20px;
       	margin: -15px 10px 50px 0;
   }
   select[name=selectStandard]{
       width: 80px;
       text-align: center;
       text-align-last: center;
       margin-top: 10px;
   }
   select[name=sortNum]{
      	width:50px;
      	text-align: center;
       	text-align-last: center;
       	margin-top: 10px;
   }
   select{
   		text-align: center;
        text-align-last: center;
   }
   input[name=searchInput]{
       	height: 19px !important;
       	width: 203px;
   }
   input[name=searchSubmit]{
       	background: #ef962d;
   		border: 1px solid #ef962d;
    	font-weight: bold;
    	height:25px;
   }
   .buttons_table{
       	margin-bottom: 10px;
   }
   .buttons_table input[type=submit]{
       	padding: 3px 10px;
       	background: #ef962d;
       	border: 1px solid #ef962d;
       	font-weight: 900;
   }
   .message_list_wrap select{
		font-family: 'Poor Story', cursive !important;
		height: 25px;
		text-align: center;
   		text-align-last: center;
	}
	select[name=sortNum]{
      	width:70px;
   }
	select[name=selectStandard]{
		margin-bottom: 10px;
	} 
	.message_list_wrap input[name=searchInput]{
		line-height: 20px;
	}
   .message_list_table {
      	width: 100%;
       	text-align: center;
       	border-collapse: collapse;
       	margin-top: 10px;
       	font-size: 16px;
   }
   .message_list_table thead{
       	border-top: 3px solid #ef962d;
       	border-bottom: 2px solid #ef962d;
   }
   .message_list_table thead tr{
       	line-height: 40px;
   }
   .message_list_table thead th:first-child{
      	width: 20px;
   }
   .message_list_table tbody tr.table_row {
       	line-height: 12px;
       	border-bottom: 1px solid #ef962d45;
       	font-size: 15px;
       	height: 30px;
       	word-break: break-word;
    }
    .message_list_table input[type=submit]{
       	background: #ef962d;
       	border: 1px solid #ef962d;
       	font-weight: bold;
       	font-size: 17px;
    }
    .warning_div{
       	margin-top: 20px;
    }
    .warning_div p{
       	color:red;
       	font-weight:bold;
    }
    .page_navigation_wrap{
        width: 920px;
          height: 30px;
          margin-top:30px;
    }
    .page_nav_ul{
        list-style: none;
       margin: 0;
       padding: 0;
       height: 100%;
       text-align: center;
    }
    .page_nav_li{
        text-align: center;
       width: 30px;
       display: inline-block;
       height: 30px;
       line-height: 30px;
       font-weight: bold;
    }
    .page_nav_li:first-child{
       margin-right: 5px;
    }
</style>
   <div class="message_list_wrap">
      <h2>쪽지관리</h2>
      <form id="messageList_form" name="messageList_form" class="messagelist_form" method="post">
      	 <div id="search" class="search_div">
	         <select name="selectStandard" id="selectStandard">
	            <option value="all" selected <c:out value="${selectStandard  == 'all'? 'selected':'' }"/>>전체회원</option>
	            <c:forEach var="lv" items="${level }" varStatus="status">
	               <c:if test="${lv.levelNo >=2 }">
	                  <c:set value="level${lv.levelNo }" var="levelname"/>
	                  <option value="level${lv.levelNo }" <c:out value="${selectStandard  == levelname ? 'selected':'' }"/>>${lv.levelName }</option>      
	               </c:if>         
	            </c:forEach>      
	         </select>
	         <select name="searchCondition">
	               <option value="select">선택하세요</option>
	               <option value="nickName" <c:out value="${searchCondition == 'nickName'? 'selected':'' }"/>>닉네임</option>
	               <option value="title" <c:out value="${searchCondition == 'title' ? 'selected' : '' }"/>>제목</option>
	               <option value="content" <c:out value="${searchCondition == 'content' ? 'selected' : '' }"/>>내용</option>
	               <option value="noReadTitle" <c:out value="${searchCondition == 'noReadTitle'? 'selected':'' }"/>>안읽은쪽지+제목</option>
	         </select>
	         <input type="text" name="searchInput" id="searchInput" value="${searchInput}"/>
	         <input type="submit" name="searchSubmit" value="검색">
         </div>
         <table id="buttons" class="buttons_table">
            <tr>
               <th><input type="checkbox" name="allCheck" id="allCheck" /></th>
               <th>선택한 쪽지</th>
               <th>
                  <input type="submit" value="삭제" name="deleteAll" data-messageNo="${msg.messageNo }">
               <th>
               <th>
                  <select name="sortNum" id="sortNum" style="margin-left: 690px;">
					 <option value="15" <c:out value="${sortNum == 15? 'selected':'' }"/>>15개씩</option>
					 <option value="30" <c:out value="${sortNum == 30? 'selected':'' }"/>>30개씩</option>
					 <option value="45" <c:out value="${sortNum == 45? 'selected':'' }"/>>45개씩</option>
				  </select>
               </th>
            </tr>
         </table>
         <table class="message_list_table">
            <thead>
               <tr>
                  <th></th>
                  <th style="width:110px;">받는사람</th>
                  <th style="width:100px;">제목</th>
                  <th style="width:400px;">내용</th>
                  <th>보낸 날짜</th>
                  <th>읽은 날짜</th>
                  <th>삭제</th>
               </tr>
            </thead>
            <tbody>
               <c:forEach var="msg" items="${message }" varStatus="status">
                  <tr class="table_row">
                     <td><input type="checkbox" name="chBox" class="chBox" data-messageNo="${msg.messageNo }"></td>
                     <td><a href='' onclick="window.open('memberView.do?memberId=${msg.memberId}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=400,height=300,left=0, top=0, scrollbars=yes');return false">${msg.nickName }(${msg.memberId })</a></td>
                     <td><a href="" onclick="window.open('${contextPath }/admin/messageDetail.do?messageNo='+${msg.messageNo} , 'newWindow', 'width=400, height=300, scrollbar=no');return false">${msg.messageTitle }</a></td>
                     <td><a href="" onclick="window.open('${contextPath }/admin/messageDetail.do?messageNo='+${msg.messageNo} , 'newWindow', 'width=400, height=300, scrollbar=no');return false">
                     ${msg.messageContent }</a></td>
                     <c:if test="${not empty msg.sendDate }">
                        <td>${msg.sendDate }</td>
                     </c:if>
                     <c:if test="${empty msg.readDate }">
                        <td>X</td>
                     </c:if>
                     <c:if test="${not empty msg.readDate }">
                        <td>${msg.readDate }</td>
                     </c:if>
                     <td><input type="submit" value="삭제" name="deleteMessage" data-messageNo="${msg.messageNo }"></td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
         <div class="warning_div">
            <p>
           		읽은 쪽지는 15일 후에 자동삭제됩니다.<br>
               	안 읽은 쪽지는 30일 후에 자동삭제됩니다.
            </p>
         </div>
      </form>
      <div class="page_navigation_wrap">
         <ul class="page_nav_ul">
          <c:choose>
             <c:when test="${searchInput != null }">
                <c:if test="${begin-sortNum < 0 }">
                    <li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
                 </c:if>
                 <c:if test="${begin-sortNum >= 0 }">
                   <li class="page_nav_li"><a href="messageList.do?tabNum=${tabNum }&selectStandard=${selectStandard }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
                 </c:if>
                 <li class="page_nav_li"><a href="messageList.do?tabNum=${tabNum }&selectStandard=${selectStandard }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin }">${curPage+1 }</a></li>
                 <c:if test="${begin+sortNum >= totalNum }">
                    <li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
                 </c:if>
                 <c:if test="${begin+sortNum < totalNum }">
                    <li class="page_nav_li"><a href="messageList.do?tabNum=${tabNum }&selectStandard=${selectStandard }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${end }"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
                 </c:if>
              </c:when>
              <c:otherwise>
                 <c:if test="${begin-sortNum < 0 }">
                    <li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
                 </c:if>
                 <c:if test="${begin-sortNum >= 0 }">
                   <li class="page_nav_li"><a href="messageList.do?tabNum=${tabNum }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
                 </c:if>
                 <li class="page_nav_li"><a href="messageList.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${begin}">${curPage+1 }</a></li>
                 <c:if test="${begin+sortNum >= totalNum }">
                    <li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
                 </c:if>
                 <c:if test="${begin+sortNum < totalNum }">
                    <li class="page_nav_li"><a href="messageList.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${end}"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
                 </c:if>
              </c:otherwise>
           </c:choose>
         </ul>
       </div>
   </div>
   <script>
      // 모두 선택 체크박스 체크시 개별 체크박스들도 모두 체크
      $("#allCheck").click(function(){
         var chk = $("#allCheck").prop("checked");
         if(chk) {
            $(".chBox").prop("checked", true);
         } else {
            $(".chBox").prop("checked", false);
         }
      });
      
      // 개별 체크박스가 선택되거나 선택해제되면 모두 선택 체크박스가 해제
      $(".chBox").click(function(){
         $("#allCheck").prop("checked",false);
      });
      
      // 삭제
      $("input[name=deleteAll]").click(function(e){
         e.preventDefault();
         var check = $("input:checkbox[name=chBox]:checked").length;
         if(check < 1){
            alert("선택된 쪽지가 없습니다.");
         } else{
            var confirm_val = confirm("쪽지를 삭제하시겠습니까?");
         }     
         if(confirm_val) {
            var checkArr = new Array();
            $("input[class='chBox']:checked").each(function(){
               checkArr.push($(this).attr("data-messageNo"));
            });
            console.log(checkArr);
            $.ajax({
               url : "deleteMessage.do",
               type : "post",
               data : { chbox : checkArr },
               success : function(result){
                  if(result == '1') {
                     alert("쪽지를 삭제했습니다.");
                     location.href = "${contextPath }/admin/messageList.do";
                  } else if(result == '2'){
                     alert("회원이 확인한 쪽지는 삭제할 수 없습니다.");
                  } else {
                     alert("쪽지삭제에 실패했습니다.");
                  }
               }
            });
         } 
      });
      
      // 하나 삭제
      $("input[name=deleteMessage]").click(function(e){
         e.preventDefault();
         var confirm_val = confirm("쪽지를 삭제하시겠습니까?");
         if(confirm_val){
            var checkArr = new Array();
            checkArr.push($(this).attr("data-messageNo"));
            $.ajax({
               url :"deleteMessage.do",
               type : "post",
               data : { chbox : checkArr },
               success : function(result){
                  if(result == '1') {
                     alert("쪽지를 삭제했습니다.");
                       location.href = "${contextPath }/admin/messageList.do";
                   } else if(result == '2'){
                      alert("회원이 확인한 쪽지는 삭제할 수 없습니다.");
                   } else {
                      alert("쪽지삭제에 실패했습니다.");
                  }
               }
            });
         }
      });
      
      $("select[name=selectStandard]").change(function(){
          var selectStandard = $("select[name=selectStandard]").val();
             var url = location.search;
             var params = new URLSearchParams(url);
             if (params.has("selectStandard")){
             	params.set("selectStandard", selectStandard);
             	document.location.href="${contextPath}/admin/messageList.do?"+params.toString();
             }
       });
      
      $("select[name=sortNum]").change(function(){
      	var sortNum = $("select[name=sortNum]").val();
  			var url = location.search;
  			var params = new URLSearchParams(url);
  			if (params.has("sortNum")){
  			params.set("sortNum", sortNum);
  			if (params.has("pageNum")){
  				params.set("pageNum", "0");
  			}
  			params.delete("pageNum");
  			document.location.href="${contextPath}/admin/messageList.do?"+params.toString();
  			}else{
  				if (sortNum == 30 || sortNum ==45){
  					params.append("sortNum", sortNum);
  				}
  				params.delete("pageNum");
  				document.location.href="${contextPath}/admin/messageList.do?"+params.toString();
  			}
  			console.log(sortNum);
       });
      
      //검색
      $("input[name=searchSubmit]").click(function(e){
         e.preventDefault();
         var searchCondition = $("select[name=searchCondition]").val();
         if($("select[name=searchCondition]").val() == "select"){
             alert("검색범위를 선택해주세요!");
             $("input[name=searchInput]").val("");
             return false;
          }
         if($("input[name=searchInput]").val() == ""){
             alert("검색어를 입력해주세요!");
             $("input[name=searchInput]").focus();
             return false;
          }   
      
         var url = location.search;
         var params = new URLSearchParams(url);
         var link = document.location.href;
         var para = document.location.href.split("&");
         console.log(params);
         console.log("${contextPath}/admin/articleManage.do?"+params.toString());
         console.log(params.has("searchInput"))
         if (params.has("searchInput")){
				console.log(params.has("searchInput"))
				params.set("searchInput",searchInput);
				params.set("searchCondition", $("select[name=searchCondition]").val());
				document.location.href="${contextPath}/member/memberMessageList.do?"+params.toString();
				params.delete("pageNum");
				console.log("${contextPath}/member/memberMessageList.do?"+params.toString());
			}else{
				params.append("searchInput", searchInput);
				params.append("searchCondition", $("select[name=searchCondition]").val());
				document.location.href="${contextPath}/member/memberMessageList.do?"+params.toString();
		}
      });
      
   </script>