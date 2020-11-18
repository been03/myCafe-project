<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<style>
	@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	.find_id_form h2{
		font-size:25px;
		font-weight:bold;
	}
	.find_id_form{
	    font-family: 'Poor Story', cursive !important;
	    font-weight:bold;
	    font-size: 18px;
	}
	.find_id_form input[type=submit], .find_id_form button{
		background-color: #ef962d !important;
	    padding: 5px;
	}
</style>
<title>아이디 찾기</title>
</head>
<body onresize="parent.resizeTo(600, 385)" onload="parent.resizeTo(600, 385)">
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form class="find_id_form" method="post" onsubmit="return false;">
				<div class="w3-center w3-large w3-margin-top">
					<h2>아이디 찾기</h2>
				</div>
				<div>
					<p>
						<label>Email</label>
						<input class="w3-input" type="text" id="email" name="email">
					</p>
					<p class="w3-center">
						<button type="submit" id="findBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
						<input type="submit" value="Cancel" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round" onClick="window.close()">
					</p>
				</div>
			</form>
		</div>
	</div>
	<script>
		$(function(){
			$("#findBtn").click(function(){
				var email = $("input[name=email]").val();
				window.open('${contextPath}/member/findId.do?email='+email,'window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no,left=0, top=0, scrollbars=yes');
				return false;
			});
		});
	</script>
</body>
</html>