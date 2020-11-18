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
	.select_conditions_wrap h2 {
		font-size:30px;
      	margin-top:0;
	}
	div.table_wrap{
	    padding: 10px;
        min-height: 700px;
	}
	.table_wrap h2{
		font-size:30px;
		margin: 0 0 20px 3px;
	}
	.search_div {
      float:right;
      margin: 0 3.5px 0 0;
   }
	.memberlist_form{
		text-align: left;
	}
	
	.select_conditions_wrap{
      	padding: 10px;
      	margin-bottom:30px;
   }
	select{
   		text-align: center;
        text-align-last: center;
   	}
	select[name=searchCondition]{
        width: 100px;
    	margin-top: 10px;
	}
	select[name=sortNum]{
		width:70px;
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
   .select_conditions_wrap{
      padding: 10px;
   }
	.mem_stats_wrap{
		font-weight:bold;
		margin-top: 20px;
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
		  <a href="${contextPath }/admin/memberDataAdmin.do?tabNum=1" class="tablinks selected">탈퇴회원 가입제한</a>
		  <a href="${contextPath }/admin/memberDataAdmin.do?tabNum=2" class="tablinks">가입대기자</a>
		</c:if>
		<c:if test="${tabNum == 2 }">
			<c:set var="tab" value="${tabNum }" />
		  <a href="${contextPath }/admin/memberDataAdmin.do?tabNum=1" class="tablinks">탈퇴회원 가입제한</a>
		  <a href="${contextPath }/admin/memberDataAdmin.do?tabNum=2" class="tablinks selected">가입대기자</a>
		</c:if>
	</div>
	<form id="memberList_form" name="memberList_form" class="memberlist_form" method="post" onsubmit="return false;">
		<div class="select_conditions_wrap">
			<div class="mem_stats_wrap">
				<c:if test="${tabNum == 1 }">
					<h2>탈퇴/가입제한 데이터 관리</h2>
				</c:if>
				<c:if test="${tabNum == 2 }">
					<h2>가입대기자 관리</h2>
				</c:if>
			</div>
			<div id="search" class="search_div">
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
		<div  style="font-weight:bold; margin: 40px 0 0 15px;">
			<c:if test="${tabNum == 1 }">
				탈퇴회원 수 <span style="color:#ef962d">${memberCnt }</span>
			</c:if>
			<c:if test="${tabNum == 2 }">
				가입대기자 수 <span style="color:#ef962d">${memberCnt }</span>
			</c:if>
		</div>
		<div class="table_wrap">
			<table id="buttons" class="buttons_table">
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>선택한 회원</th>
					<c:if test="${tabNum == 1 }">
						<th>
							<input type="submit" value="데이터 삭제" name="dataDelete" >
							<input type="submit" value="데이터 복구" name="dataRestore">
						</th>
					</c:if>
					<c:if test="${tabNum == 2 }">
						<th>
							<input type="submit" value="가입 수락" name="joinAccept">
						</th>
						<th>
							<input type="submit" value="가입 거절" name="joinRefuse" >
						</th>
					</c:if>
					<th>
						<c:if test="${tabNum == 1 }">
							<select name="sortNum" id="sortNum" style="margin-left: 520px;">
						</c:if>
						<c:if test="${tabNum == 2 }">
							<select name="sortNum" id="sortNum" style="margin-left: 543px;">
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
								<th>탈퇴 일</th>
								<th>데이터 삭제</th>
								<th>데이터 복구</th>
							</c:when>
							<c:otherwise>
								<th></th>
								<th>닉네임(ID)</th>
								<th>가입요청 일</th>
								<th>가입승인</th>
								<th>가입거절</th>
							</c:otherwise>
						</c:choose>	
					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${member }" varStatus="status">
						<tr class="table_row" align="center">
							<c:if test="${tabNum == 1}">
								<td><input type="checkbox" name="chBox" class="chBox" data-userId="${member.memberId }" ></td>
								<td id="memberId"><a href='javscript:void(0);' onclick="window.open('memberView.do?memberId=${member.memberId}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=400,height=300,left=0, top=0, scrollbars=yes');return false">
									${member.nickName }(${member.memberId })</a></td>
								<td>${member.levelName }</td>
								<td>${member.updateStatusDate }</td>
								<td><input type="submit" value="삭제" name="deleteOneData" data-userId="${member.memberId }"></td>
								<td><input type="submit" value="복구" name="restoreOneData" data-userId="${member.memberId }"></td>
							</c:if>
							<c:if test="${tabNum ==2 }">
								<td><input type="checkbox" name="chBox" class="chBox" data-userId="${member.memberId }" ></td>
								<td id="memberId"><a href='' onclick="window.open('memberView.do?memberId=${member.memberId}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=400,height=300,left=0, top=0, scrollbars=yes');return false">
									${member.nickName }(${member.memberId })</a></td>
								<td>${member.memberJoinDate }</td>
								<td><input type="submit" value="승인" name="joinAcceptOne" data-userId="${member.memberId }"></td>
								<td><input type="submit" value="거절" name="joinRefuseOne" data-userId="${member.memberId }"></td>
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
		       		<li class="page_nav_li"><a href="memberDataAdmin.do?tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="memberDataAdmin.do?tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin }">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="memberDataAdmin.do?tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${end }"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           	</c:when>
           	<c:otherwise>
           		<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="memberDataAdmin.do?tabNum=${tabNum }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="memberDataAdmin.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${begin}">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="memberDataAdmine.do?tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${end}"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
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
	
	// 탈퇴회원 데이터 삭제
	$("input[name=dataDelete]").click(function(e){
		e.preventDefault();
		var check = $("input:checkbox[name=chBox]:checked").length;
		if(check < 1){
			alert("선택된 회원이 없습니다.");
		} else{
			var confirm_val = confirm("데이터를 완전 삭제하시겠습니까?");
		}
		  
	    if(confirm_val) {
		   var checkArr = new Array();
		   $("input[class='chBox']:checked").each(function(){
		    checkArr.push($(this).attr("data-userId"));
		   });

		   history.replaceState({}, null, location.pathname); 
		   $.ajax({
		    url : "deleteDropDate.do",
		    type : "post",
		    data : { chbox : checkArr },
		    success : function(result){
		    	if(result == 1) {
		    		history.replaceState({}, null, location.pathname);
		    		alert("데이터 삭제를 성공했습니다");
			     	location.href = "memberDataAdmin.do?tabNum=1";
		    	} else {
		    		alert("삭제 실패했습니다.");
		    	}
		     }
		   });
		 } 
	});
	
	// 하나의 데이터만 삭제할 개별버튼
	$("input[name=deleteOneData]").click(function(e){
		e.preventDefault();
		var confirm_val = confirm("데이터를 삭제하시겠습니까?");
		
		if(confirm_val){
			var checkArr = new Array();
			checkArr.push($(this).attr("data-userId"));
			
			$.ajax({
				url :"deleteDropDate.do",
				type : "post",
				data : { chbox : checkArr },
				success : function(result){
					if(result ==1){
						location.href = "memberDataAdmin.do?tabNum=1";
						alert("데이터 삭제를 성공했습니다");
					} else {
						alert("삭제 실패했습니다.");
					}
				}
			});
		}
	});
	
	// 탈퇴회원 데이터 복구
	$("input[name=dataRestore]").click(function(e){
		e.preventDefault();
		var check = $("input:checkbox[name=chBox]:checked").length;
		if(check < 1){
			alert("선택된 회원이 없습니다.");
		} else{
			var confirm_val = confirm("데이터를 복구하시겠습니까?");
		}
		  
		if(confirm_val) {
		   var checkArr = new Array();
		   $("input[class='chBox']:checked").each(function(){
		   		checkArr.push($(this).attr("data-userId"));
		   });

		   history.replaceState({}, null, location.pathname); 
		   $.ajax({
		    url : "updateStatusRelease.do",
		    type : "post",
		    data : { chbox : checkArr },
		    success : function(result){
		    	if(result == 1) {
		    		history.replaceState({}, null, location.pathname);
		    		alert("회원의 데이터 복구를 성공했습니다");
			     	location.href = "memberDataAdmin.do?tabNum=1";
		    	} else {
		    		alert("데이터 복구에 실패했습니다.");
		    	}
		     }
		   });
		 } 
	});
	
	// 하나의 데이터만 복구할 개별버튼
	$("input[name=restoreOneData]").click(function(e){
		e.preventDefault();
		var confirm_val = confirm("데이터를 복구하시겠습니까?");
		
		if(confirm_val){
			var checkArr = new Array();
			checkArr.push($(this).attr("data-userId"));
			
			$.ajax({
				url :"updateStatusRelease.do",
				type : "post",
				data : { chbox : checkArr },
				success : function(result){
					if(result ==1){
						location.href = "memberDataAdmin.do?tabNum=1";
						alert("회원의 데이터 복구를 성공했습니다");
					} else {
						alert("데이터 복구에 실패했습니다.");
					}
				}
			});
		}
	});
	
	// 가입수락 
	$("input[name=joinAccept]").click(function(e){
		e.preventDefault();
		var check = $("input:checkbox[name=chBox]:checked").length;
		if(check < 1){
			alert("선택된 회원이 없습니다.");
		} else{
			var confirm_val = confirm("가입을 수락하시겠습니까?");
		}
		  
	    if(confirm_val) {
		   var checkArr = new Array();
		   
		   $("input[class='chBox']:checked").each(function(){
		    checkArr.push($(this).attr("data-userId"));
		   });

		   history.replaceState({}, null, location.pathname); 
		   $.ajax({
		    url : "joinAccept.do",
		    type : "post",
		    data : { chbox : checkArr },
		    success : function(result){
		    	if(result == 1) {
		    		history.replaceState({}, null, location.pathname);
		    		alert("가입을 수락했습니다.");
			     	location.href = "memberDataAdmin.do?tabNum=2";
		    	} else {
		    		alert("가입 수락에 실패했습니다.");
		    	}
		     }
		   });
		 } 
	});
	
	// 하나의 데이터만 가입승인할 개별버튼
	$("input[name=joinAcceptOne]").click(function(e){
		e.preventDefault();
		var confirm_val = confirm("가입을 수락하시겠습니까?");
		
		if(confirm_val){
			var checkArr = new Array();
			checkArr.push($(this).attr("data-userId"));
			
			$.ajax({
				url :"joinAccept.do",
				type : "post",
				data : { chbox : checkArr },
				success : function(result){
					if(result ==1){
						location.href = "memberDataAdmin.do?tabNum=2";
						alert("가입을 수락했습니다.");
					} else {
						alert("가입 수락에 실패했습니다.");
					}
				}
			});
		}
	});
	
	// 가입거절 
	$("input[name=joinRefuse]").click(function(e){
		e.preventDefault();
		var check = $("input:checkbox[name=chBox]:checked").length;
		if(check < 1){
			alert("선택된 회원이 없습니다.");
		} else{
			var confirm_val = confirm("가입을 거절하시겠습니까?");
		}
		  
		if(confirm_val) {
		   var checkArr = new Array();
		   
		   $("input[class='chBox']:checked").each(function(){
		    	checkArr.push($(this).attr("data-userId"));
		   });

		   history.replaceState({}, null, location.pathname); 
		   $.ajax({
		    url : "deleteDropDate.do",
		    type : "post",
		    data : { chbox : checkArr },
		    success : function(result){
		    	if(result == 1) {
		    		history.replaceState({}, null, location.pathname);
		    		alert("가입을 거절했습니다.");
			     	location.href = "memberDataAdmin.do?tabNum=2";
		    	} else {
		    		alert("가입 거절에 실패했습니다.");
		    	}
		     }
		   });
		 } 
	});
	
	// 한명만 가입거절할 개별버튼
	$("input[name=joinRefuseOne]").click(function(e){
		e.preventDefault();
		var confirm_val = confirm("가입을 거절하시겠습니까?");
		
		if(confirm_val){
			var checkArr = new Array();
			checkArr.push($(this).attr("data-userId"));
			
			$.ajax({
				url :"deleteDropDate.do",
				type : "post",
				data : { chbox : checkArr },
				success : function(result){
					if(result ==1){
						location.href = "memberDataAdmin.do?tabNum=2";
						alert("가입을 거절했습니다.");
					} else {
						alert("가입 거절에 실패했습니다.");
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
			document.location.href="${contextPath}/admin/memberDataAdmin.do?"+params.toString();
			}else{
				if (sortNum == 30 || sortNum ==45){
					params.append("sortNum", sortNum);
				}
				params.delete("pageNum");
				document.location.href="${contextPath}/admin/memberDataAdmin.do?"+params.toString();
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
			document.location.href="${contextPath}/admin/memberDataAdmin.do?"+params.toString();
			params.delete("pageNum");
			console.log("${contextPath}/admin/articleManage.do?"+params.toString());
		}else{
			params.append("searchInput", $("input[name=searchInput]").val());
			params.append("searchCondition", $("select[name=searchCondition]").val());
			document.location.href="${contextPath}/admin/memberDataAdmin.do?"+params.toString();
		}
	});

</script>
