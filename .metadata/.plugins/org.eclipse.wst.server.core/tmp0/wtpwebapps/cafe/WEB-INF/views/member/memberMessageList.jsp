<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />    
	<style type="text/css">
		@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
		.message_list_wrap{
			width: 920px;
			margin: 20px auto 0;
		}
		.message_list_wrap div.tab{
		    margin: 30px 0 30px;
		    font-family: 'Poor Story', cursive !important;
	        font-size: 20px;
		   	font-weight: bold;
		}
		.message_list_wrap div.tab a{
		    border: 1px solid #ef962d;
		   	display: inline-block;
	  	    padding: 0px 35px;
	  	    background: antiquewhite;
		}
		.message_list_wrap div.tab a.selected:hover{
		    color: white;
	    	text-decoration: none;
	    	transform: scale(1.1);
		}
		.message_list_wrap div.tab a:hover{
		    color: #ef962d;
	    	text-decoration: none;
	    	transform: scale(1.1);
		}
		.message_list_wrap div.tab a.selected{
			background: #ef962d !important;
		}
		.message_list_wrap div.tab a:nth-child(2), .my_page_main_tab a:nth-child(3){
		    margin-left: -5px;
		}
		.message_list_wrap h2{
			font-size:30px;
		    font-weight: bold;
			margin: 0;
			font-family: 'Poor Story', cursive !important;
		}
		.message_list_wrap input[type=submit]{
			font-family: 'Poor Story', cursive !important;
			border:1px solid #ef962d;
			background: #ef962d;
			font-weight:bold;
		}
		.message_list_wrap select{
			font-family: 'Poor Story', cursive !important;
			height: 26px;
			text-align: center;
    		text-align-last: center;
		}
		.search_div {
	   		display:inline-block;
	   		height:20px;
	   		padding-bottom:40px;
	   		float:right;
   		    margin: 20px 3px;
	    }
	    input[name=searchInput]{
	       	width: 203px;
	       	font-family: 'Poor Story', cursive !important;
	    }
	    input[name=searchSubmit]{
	       	background: #ef962d;
	   		border: 1px solid #ef962d;
	    	font-weight: bold;
	    	height:25px;
	    }
		.message_list_wrap input[name=searchInput]{
			line-height: 20px;
    		vertical-align: bottom;
		 }
		.buttons_table{
			height:20px;
		    margin-bottom: 10px;
		    font-family: 'Poor Story', cursive !important;
		 }
		.buttons_table input[type=submit]{
	       	padding: 3px 10px;
	       	background: #ef962d;
	       	border: 1px solid #ef962d;
	       	font-weight: 900;
	       	height: 25px;
	    }
	    select[name=sortNum]{
			width:70px;
		}
		.message_list_table {
			width: 100%;
	    	text-align: center;
	    	border-collapse: collapse;
	    	margin-top: 10px;
	    	font-size: 16px;
	    	font-family: 'Poor Story', cursive !important;
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
	    }
	    .warning_div{
	    	margin-top: 20px;
	    }
	    .warning_div p{
	    	color:red;
	    	font-weight:bold;
	    	font-family: 'Poor Story', cursive !important;
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
		<div class="tab">
	        <c:if test="${tabNum == 1 }">
	          <c:set var="tab" value="${tabNum }" />   
	        <a href="${contextPath }/member/memberMessageList.do?tabNum=1" class="tablinks selected">받은 쪽지</a>
	        <a href="${contextPath }/member/memberMessageList.do?tabNum=2" class="tablinks">보낸 쪽지</a>
	      </c:if>
	      <c:if test="${tabNum == 2 }">
	        <c:set var="tab" value="${tabNum }" />
	        <a href="${contextPath }/member/memberMessageList.do?tabNum=1" class="tablinks">받은 쪽지</a>
	        <a href="${contextPath }/member/memberMessageList.do?tabNum=2" class="tablinks selected">보낸 쪽지</a>
	      </c:if>
	   </div>
	   <c:if test="${tabNum == 1 }">
			<h2>받은 쪽지</h2>
		</c:if>
		<c:if test="${tabNum == 2 }">
			<h2>보낸 쪽지</h2>
		</c:if>
		<form id="messageList_form" name="messageList_form" class="messagelist_form" method="post">
			<div id="search" class="search_div">
				<select name="searchCondition">
	               <option value="select">선택하세요</option>
	               <c:if test="${tabNum == 1}">
	               		<option value="senderNickName" <c:out value="${searchCondition == 'senderNickName'? 'selected':'' }"/>>닉네임</option>
	               </c:if>
	               <c:if test="${tabNum == 2}">
	               		<option value="nickName" <c:out value="${searchCondition == 'nickName'? 'selected':'' }"/>>닉네임</option>
	               </c:if>
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
	                  <select name="sortNum" id="sortNum" style="margin-left: 705px;">
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
						<c:if test="${tabNum == 1 }">
							<th style="width:110px;">보낸사람</th>
						</c:if>
						<c:if test="${tabNum == 2 }">
							<th style="width:110px;">받는사람</th>
						</c:if>
						<th style="width:100px;">제목</th>
						<th style="width:400px;">내용</th>
						<c:if test="${tabNum == 1 }">
							<th>받은 날짜</th>
						</c:if>
						<c:if test="${tabNum == 2 }">
							<th>보낸 날짜</th>
						</c:if>
						<th>읽은 날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${tabNum == 1 }">
					<c:forEach var="msg" items="${message }" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status">
						<tr class="table_row">
							<td><input type="checkbox" name="chBox" class="chBox" data-messageNo="${msg.messageNo }"></td>
							<c:if test="${!msg.senderNickName.equals('관리자') }">
								<td><a href='javascript:void(0);' onclick="window.open('${contextPath}/member/otherMyPage.do?nickName=${msg.senderNickName}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=700,left=0, top=0, scrollbars=yes');return false">
								${msg.senderNickName }</a></td>
							</c:if>
							<c:if test="${msg.senderNickName.equals('관리자') }">
								<td>${msg.senderNickName }</td>
							</c:if>
							<td><a href="" onclick="window.open('${contextPath }/member/messageDetail.do?messageNo='+${msg.messageNo} , 'newWindow', 'width=400, height=300, scrollbar=no');return false">
							${msg.messageTitle }</a></td>
							<td><a href="" onclick="window.open('${contextPath }/member/messageDetail.do?messageNo='+${msg.messageNo} , 'newWindow', 'width=400, height=300, scrollbar=no');return false">
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
						</tr>
					</c:forEach>
					</c:if>
					<c:if test="${tabNum == 2 }">
					<c:forEach var="msg" items="${message }" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status">
						<tr class="table_row">
							<td><input type="checkbox" name="chBox" class="chBox" data-messageNo="${msg.messageNo }"></td>
							<td><a href='javascript:void(0);' onclick="window.open('${contextPath}/member/otherMyPage.do?nickName=${msg.nickName}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=700,left=0, top=0, scrollbars=yes');return false">
							${msg.nickName }</a></td>
							<td><a href="" onclick="window.open('${contextPath }/member/messageDetail.do?messageNo='+${msg.messageNo} , 'newWindow', 'width=400, height=300, scrollbar=no');return false">${msg.messageTitle }</a></td>
							<td><a href="" onclick="window.open('${contextPath }/member/messageDetail.do?messageNo='+${msg.messageNo} , 'newWindow', 'width=400, height=300, scrollbar=no');return false">
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
						</tr>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			<div class="warning_div">
				<p>
					읽은 쪽지는 15일 후에 자동삭제됩니다.<br>
					안 읽은 쪽지는 30일 후에 자동삭제됩니다.
				</p>
			</div>
		</form>
		<c:if test="${not empty message }">
		<div class="page_navigation_wrap">
         <ul class="page_nav_ul">
          <c:choose>
          	<c:when test="${searchInput != null }">
	          	<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="memberMessageList.do?tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="memberMessageList.do?tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin }">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="memberMessageList.do?tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${end }"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           	</c:when>
           	<c:otherwise>
           		<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="memberMessageList.do?tabNum=${tabNum }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="memberMessageList.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${begin}">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="memberMessageList.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${end}"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           	</c:otherwise>
           </c:choose>
         </ul>
       </div>
       </c:if>
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
	             url : "${contextPath }/member/deleteMessage.do?tabNum=${tabNum}",
	             type : "post",
	             data : { chbox : checkArr },
	             success : function(result){
	                if(result == '1') {
	                   alert("쪽지를 삭제했습니다.");
	                   location.href = "${contextPath }/member/memberMessageList.do?tabNum=${tabNum}";
	                } else if(result == '2'){
                		alert("회원이 확인한 쪽지는 삭제할 수 없습니다.");
	                } else if(result =='3'){
	                	alert("관리자가 보낸 쪽지는 확인 후 삭제 가능합니다.");
	                } else {
	                   alert("쪽지삭제에 실패했습니다.");
	                }
	             }
	          });
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
  			document.location.href="${contextPath}/member/memberMessageList.do?"+params.toString();
  			}else{
  				if (sortNum == 30 || sortNum ==45){
  					params.append("sortNum", sortNum);
  				}
  				params.delete("pageNum");
  				document.location.href="${contextPath}/member/memberMessageList.do?"+params.toString();
  			}
  			console.log(sortNum);
       });
		
		//검색
		$("input[name=searchSubmit]").click(function(e){
			e.preventDefault();
		 	
			var searchCondition = $("select[name=searchCondition]").val();
			var searchInput = document.getElementById("searchInput").value;
			if($("select[name=searchCondition]").val() == "select"){
				alert("검색범위를 선택해주세요!");
				$("input[name=searchInput]").val("");
				return false;
			}
			if($("input[name=searchInput]").val()){
				if(searchCondition === "noRead"){
					$("#searchInput").attr('disabled',true);
				} 
			}else if(searchInput == ""){
				alert("검색어를 입력해주세요!");
				$("input[name=searchInput]").focus();
				return false;
			}
			var url = location.search;
			var params = new URLSearchParams(url);
			var link = document.location.href;
			var para = document.location.href.split("&");
			if (params.has("searchInput")){
				console.log(params.has("searchInput"))
				params.set("searchInput",searchInput);
				params.set("searchCondition", $("select[name=searchCondition]").val());
				params.delete("pageNum");
				document.location.href="${contextPath}/member/memberMessageList.do?"+params.toString();
			}else{
				params.append("searchInput", searchInput);
				params.append("searchCondition", $("select[name=searchCondition]").val());
				params.delete("pageNum");
				document.location.href="${contextPath}/member/memberMessageList.do?"+params.toString();
			}
		});
	</script>
