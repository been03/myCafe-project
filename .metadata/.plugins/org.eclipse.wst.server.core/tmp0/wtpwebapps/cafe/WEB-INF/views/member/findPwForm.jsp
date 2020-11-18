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
	.find_pw_div h2{
		font-size:25px;
		font-weight:bold;
	}
	.find_pw_div{
	    font-family: 'Poor Story', cursive !important;
	    font-weight:bold;
	    font-size: 18px;
	}
	.find_pw_div  button{
		background-color: #ef962d !important;
	    padding: 5px;
	}
	.loading_wrap{
		position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background-color: #9e9e9e82;
	}
	.loading_wrap img{
		position: fixed;
    	top: 19%;
    	left: 33%;
	}
</style>
<script>
	$(function(){
		$("#findBtn").click(function(){
			$("#loading_wrap").css("display", "block");
			$.ajax({
				url : "${contextPath}/member/findPw.do",
				type : "POST",
				data : {
					memberId : $("#memberId").val(),
					email : $("#email").val()
				},
				success : function(result) {
					if (result === "이메일로 임시 비밀번호를 발송하였습니다."){
						$("#loading_wrap").css("display", "none");
					}
					alert(result);
					window.close();
				}
			});
		});
		
	});
	
</script>
<title>비밀번호 찾기</title>
</head>
<body onresize="parent.resizeTo(600, 470)" onload="parent.resizeTo(600, 470)">
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h2>비밀번호 찾기</h2>
			</div>
			<div class="find_pw_div">
				<p>
					<label>ID</label>
					<input class="w3-input" type="text" id="memberId" name="memberId" required>
				</p>
				<p>
					<label>Email</label>
					<input class="w3-input" type="text" id="email" name="email" required>
				</p>
				<p class="w3-center">
					<button type="button" id=findBtn class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">find</button>
					<button type="button" onClick="window.close()" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
				</p>
			</div>
			<div id="loading_wrap" class="loading_wrap" style="display:none;">
				<img src="${contextPath }/resources/image/loading.gif">
			</div>
		</div>
	</div>
</body>
</html>