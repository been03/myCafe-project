<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />    

<style>
   @import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
   .member_manage_section{
      width: 920px;
      margin: 20px auto 0;
   }
   .member_manage_section a.selected{
      background-color: #ef962d;
   }
   .member_manage_section div.tab a{
       color: black;
       text-decoration: none;
       display: inline-block;
       width: 200px;
       text-align: center;
       border: 1px solid #ef962d;
       line-height: 30px;
       font-weight: 900;
   }
   .member_manage_section div.tab a:nth-child(2){
      margin-left:-6px;
   }
   .messageList_form {
   		padding-bottom:30px;
   }
   div.table_wrap{
       padding: 10px;
        min-height: 700px;
   }
   .memberlist_form{
      padding-top: 10px;
   }
   .table_wrap h2{
      font-size:30px;
      margin: 0 0 20px -10px
   }
   .search_div {
      float:right;
   }
   .memberlist_form{
      text-align: left;
   }
   .select_conditions_wrap{
      padding: 10px;
      margin-bottom:30px;
   }
   select[name=selectStandard]{
       width: 80px;
       text-align: center;
       text-align-last: center;
       margin-top: 10px;
   }
   select[name=sortNum]{
      	width:70px;
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
   }
   .mem_stats_wrap{
      font-weight:bold;
   }
   .buttons_table{
       margin-bottom: 10px;
   }
   .buttons_table input[type=submit]{
       padding: 3px 20px;
       background: #ef962d;
       border: 1px solid #ef962d;
       font-weight: 900;
   }
   .memberlist_form select, .memberlist_form input{
      font-family: 'Poor Story', cursive !important;
      height:25px;
   }
   .member_manage_table {
      width: 100%;
       text-align: center;
       border-collapse: collapse;
       margin-top: 10px;
       font-size: 16px;
   }
   .member_manage_table thead{
       border-top: 3px solid #ef962d;
       border-bottom: 2px solid #ef962d;
   }
   .member_manage_table thead tr{
       line-height: 40px;
   }
   .member_manage_table thead th:first-child{
      width: 20px;
   }
   .member_manage_table tbody tr.table_row {
       line-height: 30px;
       border-bottom: 1px solid #ef962d45;
          font-size: 15px;
    }
    .member_manage_table input[type=submit]{
       background: #ef962d;
       border: 1px solid #ef962d;
       font-weight: bold;
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
<section class="member_manage_section">
   <div class="tab">
        <c:if test="${tabNum == 1 }">
          <c:set var="tab" value="${tabNum }" />   
        <a href="${contextPath }/admin/memberManage.do?tabNum=1" class="tablinks selected">전체회원</a>
        <a href="${contextPath }/admin/memberManage.do?tabNum=2" class="tablinks">활동정지 회원</a>
      </c:if>
      <c:if test="${tabNum == 2 }">
        <c:set var="tab" value="${tabNum }" />
        <a href="${contextPath }/admin/memberManage.do?tabNum=1" class="tablinks">전체회원</a>
        <a href="${contextPath }/admin/memberManage.do?tabNum=2" class="tablinks selected">활동정지 회원</a>
      </c:if>
   </div>
   <form id="memberList_form" name="memberList_form" class="memberlist_form" method="post" onsubmit="return false;">   
      <div class="table_wrap">
         <div class="select_conditions_wrap">
         <div class="mem_stats_wrap">
            <c:if test="${tabNum == 1 }">
            	<h2>전체회원 관리</h2>
            </c:if>
            <c:if test="${tabNum == 2 }">
            	<h2>활동중지 회원 관리</h2>
            </c:if>
         </div>
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
               <option value="memberId" <c:out value="${searchCondition == 'memberId' ? 'selected' : '' }"/>>아이디</option>
               <option value="email" <c:out value="${searchCondition == 'email' ? 'selected' : '' }"/>>이메일</option>
               <option value="nickNameEmail" <c:out value="${searchCondition == 'nickNameEmail'? 'selected':'' }"/>>닉네임+이메일</option>
            </select>
            <input type="text" name="searchInput" id="searchInput" value="${searchInput}"/>
            <input type="submit" name="searchSubmit" value="검색">
         </div>
      	 </div>
      	 <div style="font-weight:bold; margin: 50px 0 0 5px;">
	      	 <c:if test="${tabNum == 1 }">
	           	회원 수 <span style="color:#ef962d;">${memberCnt }</span>
	         </c:if>
	         <c:if test="${tabNum == 2 }">
	           	활동중지 회원 수 <span style="color:#ef962d;">${memberCnt }</span>
	         </c:if>
         </div>
            <table id="buttons" class="buttons_table">
               <tr>
                  <th><input type="checkbox" name="allCheck" id="allCheck" /></th>
                  <th>선택한 회원</th>
                  <c:if test="${tabNum == 1 }">
                     <th>
                        <select name="level" id="level" fixedsize="140">
                           <c:forEach var="lv" items="${level }" varStatus="status">
                              <c:if test="${lv.levelNo >=2 }">
                                 <option value="${lv.levelNo }">${lv.levelName }</option>   
                              </c:if>            
                           </c:forEach>   
                        </select>
                     </th>
                     <td>(으)로</td>
                     <th>
                        <input type="submit" value="변경"  name="levelChange">
                     </th>
                     <th>
                        <input type="submit" value="활동정지" name="suspension">
                     </th>
                  </c:if>
                  <c:if test="${tabNum == 2 }">
                     <th>
                        <input type="submit" value="활동정지해제" name="release">
                     </th>
                  </c:if>
                  <th>
                     <input type="submit" value="강제탈퇴" name="forceDelete" >
                  </th>
                  <c:if test="${tabNum == 1 }">
                     <th>
                        <input type="submit" value="쪽지" name="message" onclick="openNewWindow()">
                     <th>
                  </c:if>
	                  <th>
	                  	 <c:if test="${tabNum == 1 }">
						 	<select name="sortNum" id="sortNum" style="margin-left: 294px;">
						 </c:if>
						 <c:if test="${tabNum == 2 }">
						 	<select name="sortNum" id="sortNum" style="margin-left: 522px;">
						 </c:if>
							 <option value="15" <c:out value="${sortNum == 15? 'selected':'' }"/>>15명씩</option>
							 <option value="30" <c:out value="${sortNum == 30? 'selected':'' }"/>>30명씩</option>
							 <option value="45" <c:out value="${sortNum == 45? 'selected':'' }"/>>45명씩</option>
						 </select>
	                  </th>
               </tr>
            </table>
            <table class="member_manage_table">
               <thead>
                  <tr>
                     <c:choose>
                        <c:when test="${tabNum == 1 }">
                           <th></th>
                           <th>닉네임(ID)</th>
                           <th>회원등급</th>
                           <th>마지막 접속일</th>
                           <th>가입일</th>
                           <th>방문 수</th>
                           <th>게시글 수</th>
                           <th>댓글 수</th>
                        </c:when>
                        <c:otherwise>
                           <th></th>
                           <th>닉네임(ID)</th>
                           <th>복구등급</th>
                           <th>처리일</th>
                           <th>활동정지</th>
                           <th>사유</th>
                        </c:otherwise>
                     </c:choose>   
                  </tr>
               </thead>
               <tbody>
                  <c:forEach var="member" items="${mem }" begin="${begin }" end="${end-1 }" varStatus="status">
                     <tr class="table_row" align="center">
                        <c:if test="${tabNum == 1}">
                           <td><input type="checkbox" name="chBox" class="chBox" data-userId="${member.memberId }" ></td>
                           <td><a href='javascript:void(0);' onclick="window.open('memberView.do?memberId=${member.memberId}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=400,height=300,left=0, top=0, scrollbars=yes');return false">
                           ${member.nickName }(${member.memberId })</a></td>
                           <td>${member.levelName }</td>
                           <td class="lastLogin">${member.loginTime }</td>
                           <td class="joinDate">${member.memberJoinDate }</td>
                           <td class="loginCnt">${member.loginCnt }</td>
                           <td class="articleCnt">${member.articleCnt }</td>
                           <td class="commentCnt">${member.commentCnt }</td>
                        </c:if>
                        <c:if test="${tabNum ==2 }">
                           <td><input type="checkbox" name="chBox" class="chBox" data-userId="${member.memberId }" ></td>
                           <td><a href='javascript:void(0);' onclick="window.open('memberView.do?memberId=${member.memberId}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=400,height=300,left=0, top=0, scrollbars=yes');return false">
                           ${member.nickName }(${member.memberId })</a></td>
                           <td>${lowLevelName }</td>
                           <td>${member.updateStatusDate }</td>
                           <td><input type="submit" value="해제" name="releaseMember" data-userId="${member.memberId }"></td>
                           <td>스팸 게시물 및 댓글 작성</td>
                        </c:if>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
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
                   <li class="page_nav_li"><a href="memberManage.do?tabNum=${tabNum }&selectStandard=${selectStandard }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
                 </c:if>
                 <li class="page_nav_li"><a href="memberManage.do?tabNum=${tabNum }&selectStandard=${selectStandard }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin }">${curPage+1 }</a></li>
                 <c:if test="${begin+sortNum >= totalNum }">
                    <li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
                 </c:if>
                 <c:if test="${begin+sortNum < totalNum }">
                    <li class="page_nav_li"><a href="memberManage.do?tabNum=${tabNum }&selectStandard=${selectStandard }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${end }"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
                 </c:if>
              </c:when>
              <c:otherwise>
                 <c:if test="${begin-sortNum < 0 }">
                    <li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
                 </c:if>
                 <c:if test="${begin-sortNum >= 0 }">
                   <li class="page_nav_li"><a href="memberManage.do?tabNum=${tabNum }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
                 </c:if>
                 <li class="page_nav_li"><a href="memberManage.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${begin}">${curPage+1 }</a></li>
                 <c:if test="${begin+sortNum >= totalNum }">
                    <li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
                 </c:if>
                 <c:if test="${begin+sortNum < totalNum }">
                    <li class="page_nav_li"><a href="memberManage.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${end}"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
                 </c:if>
              </c:otherwise>
           </c:choose>
         </ul>
       </div>
    </section>   
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
      
      // 개별 선택된 체크박스들을 배열 변수 checkArr에 저장한 뒤 컨트롤러로 전송 - 강제탈퇴
      $("input[name=forceDelete]").click(function(e){
         e.preventDefault();
         var check = $("input:checkbox[name=chBox]:checked").length;
         if(check < 1){
            alert("선택된 회원이 없습니다.");
         } else{
            var confirm_val = confirm("강제탈퇴 처리하시겠습니까?");
         }
         if(confirm_val) {
            var checkArr = new Array();
            $("input[class='chBox']:checked").each(function(){
               checkArr.push($(this).attr("data-userId"));
            });
            history.replaceState({}, null, location.pathname); 
            $.ajax({
               url : "updateStatusDrop.do",
               type : "post",
               data : { chbox : checkArr },
               success : function(result){
                  if(result == 1) {
                     history.replaceState({}, null, location.pathname);
                     alert("성공했습니다");
                     location.href = "memberManage.do?tabNum=1";
                  } else {
                     alert("삭제 실패");
                  }
               }
            });
         } 
      });
      
      // 등급변경 버튼
      $("input[name=levelChange]").click(function(e){
         e.preventDefault();
         var check = $("input:checkbox[name=chBox]:checked").length;
         if(check < 1){
            alert("선택된 회원이 없습니다.");
         } else{
            var confirm_val = confirm("회원등급을 변경하시겠습니까?");
         }
         if(confirm_val) {
            var checkArr = new Array();
            $("input[class='chBox']:checked").each(function(){
               checkArr.push($(this).attr("data-userId"));
            });
            var level = $("select[name=level]").val(); 
            $.ajax({
               url : "updateLevel.do",
               type : "post",
               data : { chbox : checkArr, level : level },
               success : function(result){
                  if(result == 1) {
                     location.href = "${contextPath}/admin/memberManage.do?tabNum=1";
                  } else {
                     alert("변경 실패");
                  }
               }
            });
         } 
      });
      
      // 활동정지
      $("input[name=suspension]").click(function(e){
         e.preventDefault();
         var check = $("input:checkbox[name=chBox]:checked").length;
         if(check < 1){
            alert("선택된 회원이 없습니다.");
         } else{
            var confirm_val = confirm("활동정지 처리하시겠습니까?");
         }
         if(confirm_val) {
            var checkArr = new Array();
            $("input[class='chBox']:checked").each(function(){
               checkArr.push($(this).attr("data-userId"));
            });
             history.replaceState({}, null, location.pathname);
             $.ajax({
               url : "updateStatusSuspension.do",
               type : "post",
               data : { chbox : checkArr },
                 success : function(result){
                  if(result == '1') {
                     history.replaceState({}, null, location.pathname);
                        window.location.href = "${contextPath}/admin/memberManage.do";
                        alert("활동정지 처리 성공");
                  } else if(result == '2') {
                     alert("이미 활동정지 상태인 회원이 있습니다.");
                  } 
                  else {
                      alert("활동정지 처리 실패");
                  }
               }
            });
         }
      }); 
      
      //활동정지해제 버튼
      $("input[name=release]").click(function(e){
         e.preventDefault();
         var check = $("input:checkbox[name=chBox]:checked").length;
         if(check < 1){
            alert("선택된 회원이 없습니다.");
         } else{
            var confirm_val = confirm("활동정지를 해제하시겠습니까?");
         }     
         if(confirm_val) {
            var checkArr = new Array();
            $("input[class='chBox']:checked").each(function(){
               checkArr.push($(this).attr("data-userId"));
            });
            $.ajax({
               url : "updateStatusRelease.do",
               type : "post",
                data : { chbox : checkArr },
                success : function(result){
                  if(result == '1') {
                     location.href = "memberManage.do?tabNum=2";
                       alert("활동정지 해제 성공");
                   } else {
                      alert("활동정지 해제 실패");
                  }
               }
            });
         }
      }); 
      
      // 개별 활동정지 해제 버튼
      $("input[name=releaseMember]").click(function(e){
         e.preventDefault();
         var confirm_val = confirm("활동정지를 해제하시겠습니까?");
         if(confirm_val){
            var checkArr = new Array();
            checkArr.push($(this).attr("data-userId"));
            $.ajax({
               url :"updateStatusRelease.do",
               type : "post",
               data : { chbox : checkArr },
               success : function(result){
                  if(result ==1){
                     location.href = "memberManage.do?tabNum=2";
                     alert("활동정지해체 성공")
                  } else {
                     alert("활동정지해제 실패")
                  }
               }
            });
         }
      });
      
      //쪽지
      var newWindow;
      function openNewWindow(){
         var check = $("input:checkbox[name=chBox]:checked").length;
         if(check < 1){
            alert("선택된 회원이 없습니다.");
         } else{
            var confirm_val = confirm("쪽지를 보내시겠습니까?");
         }     
         if(confirm_val) { 
            var checkArr = new Array();
            $("input[class='chBox']:checked").each(function(){
               checkArr.push($(this).attr("data-userId"));
            });
            window.open("messageForm.do?checkArr="+checkArr , "newWindow", "width=400, height=450, top=150, left=500, scrollbar=no");
         }
      }
      
      $("select[name=selectStandard]").change(function(){
          var selectStandard = $("select[name=selectStandard]").val();
             var url = location.search;
             var params = new URLSearchParams(url);
             if (params.has("selectStandard")){
             	params.set("selectStandard", selectStandard);
             	document.location.href="${contextPath}/admin/memberManage.do?"+params.toString();
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
            document.location.href="${contextPath}/admin/memberManage.do?"+params.toString();
            }else{
               if (sortNum == 30 || sortNum ==45){
                  params.append("sortNum", sortNum);
               }
               params.delete("pageNum");
               document.location.href="${contextPath}/admin/memberManage.do?"+params.toString();
            }
            console.log(sortNum);
        });
      
    //검색
      $("input[name=searchSubmit]").click(function(e){
         e.preventDefault();
       
         if($("input[name=searchInput]").val() == ""){
            alert("검색어를 입력해주세요!");
            $("input[name=searchInput]").focus();
            return false;
         }   
         if($("select[name=searchCondition]").val() == "select"){
            alert("검색범위를 선택해주세요!");
            $("input[name=searchInput]").val("");
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
            params.set("searchInput", $("input[name=searchInput]").val());
            params.set("searchCondition", $("select[name=searchCondition]").val());
            params.set("selectStandard", $("select[name=selectStandard]").val())
            document.location.href="${contextPath}/admin/memberManage.do?"+params.toString();
            params.delete("pageNum");
            console.log("${contextPath}/admin/articleManage.do?"+params.toString());
         }else{
            params.append("searchInput", $("input[name=searchInput]").val());
            params.append("searchCondition", $("select[name=searchCondition]").val());
            params.append("selectStandard", $("select[name=selectStandard]").val());
            document.location.href="${contextPath}/admin/memberManage.do?"+params.toString();
         }
      });

   </script>