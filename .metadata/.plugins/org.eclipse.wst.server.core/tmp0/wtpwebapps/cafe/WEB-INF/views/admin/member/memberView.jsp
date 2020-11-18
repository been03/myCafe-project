<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 상세페이지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	.member_view_wrap{
		margin-top:50px;
		text-align:center;
		font-family: 'Poor Story', cursive !important;
	}
	.member_view_wrap h2{
		font-size:30px;
	}
	.member_view_wrap table{
		width: 300px;
	    margin: 0 auto;
	    padding-left: 35px;
	    line-height: 20px;
	    word-break: break-word;
	}
	.member_view_wrap tr:last-child{
	    padding-right: 80px;
    	line-height: 50px;
	}
	.member_view_wrap tr:last-child td{
	    padding-right: 65px;
	}
	.member_view_wrap td:first-child{
		font-weight:bold;
	}
	.member_view_wrap td:nth-child(2) {
    	text-align: left;
    }
	.member_view_wrap input[type=submit]{
		font-family: 'Poor Story', cursive !important;
		font-weight:bold;
		border:1px solid #ef962d;
		background:#ef962d;
	}
</style>
</head>
<body>
	<div class="member_view_wrap">
		<h2>회원정보 상세</h2>
		<form name="form1" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td>${member.memberId }</td>
				</tr>
				<tr>
					<td>등급</td>
					<td>${member.levelName }</td>
				</tr>
				<tr>
					<td>이름</td>
					<td>${member.memberName }</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>${member.email }</td>
				</tr>
				<tr>
					<td>핸드폰번호</td>
					<td>${member.telNum }</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<c:if test="${member.status.equals('active') || member.status.equals('inactive')}">
							<input type="submit" value="마이페이지" class="myPageBtn">
						</c:if>
						<input type="submit" value="닫기" class="cancelBtn" >
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script>
		$(function(){
			$(".myPageBtn").click(function(e){
				e.preventDefault();
				window.open('${contextPath}/member/otherMyPage.do?memberId=${member.memberId}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no,left=0, top=0, scrollbars=yes');
				window.resizeTo(1020, 700);
				return false;
			});
			$(".cancelBtn").click(function(e){
				e.preventDefault();
				window.close();
			});
		});
	</script>
</body>
</html>