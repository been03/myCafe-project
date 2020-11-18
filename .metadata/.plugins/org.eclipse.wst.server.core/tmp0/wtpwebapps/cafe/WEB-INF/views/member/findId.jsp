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
<script>
	$(function(){
		$("#loginBtn").click(function(){
			location.href='${contextPath}/member/loginForm.do';
		});
	});
</script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	
	.find_id_result_h2{
		font-family: 'Poor Story', cursive !important;
		font-size:25px;
		font-weight:bold;
	}
	.find_id_result_div{
	    font-family: 'Poor Story', cursive !important;
	    font-weight:bold;
	    font-size: 18px;
	}
	.find_id_result_div h3{
		font-family: 'Poor Story', cursive !important;
	    font-weight: bold;
	    font-size: 25px;
	    text-align: center;
	    color: #ef962d;
	}
	 .find_id_result_div button{
		background-color: #ef962d !important;
	    padding: 5px;
	}
</style>
<title>아이디 찾기</title>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h2 class="find_id_result_h2">아이디 찾기 검색결과</h2>
			</div>
			<div class="find_id_result_div">
				<h3>
					${ memberId }
				</h3>
				<p class="w3-center">
					<button type="button" onClick="window.close()" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
				</p>
			</div>
		</div>
	</div>
</body>
</html>