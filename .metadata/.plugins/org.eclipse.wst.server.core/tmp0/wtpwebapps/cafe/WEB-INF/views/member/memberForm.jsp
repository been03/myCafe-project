<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!-- <!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script> -->
<style>
	@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
	.join_form_wrap{
	    width: 850px;
   	    margin: 30px auto !important;
    	font-family: 'Poor Story', cursive !important;
    	font-weight: bold;
	}
	.join_form_wrap h2 > span{
		font-family: 'Pacifico', cursive !important;
	    color: #ef962d;
	    font-size: 35px;
	    font-weight: bold;
	}
	.join_form_wrap h2{
		font-family: 'Poor Story', cursive !important;
		font-size: 30px;
		font-weight:bold;
	}
	.join_form div{
	    margin: 40px 0px;
	}
	.join_form label{
	    font-size: 20px;
	    margin-top: 7px;
	    color: #ef962d;
	}
	.join_form button, .join_form input[type=submit]{
		background-color: #ef962d !important;
	}
</style>
<script>
	$(function() {
		// 아이디 중복확인 AJAX
		$("#memberId").keyup(function() {
			regexp = /[~!@#$%^&*()_+|<>?:{}]/;
			v = $(this).val();
			if( regexp.test(v) ) {
				alert("특수문자는 입력하실 수 없습니다");
				$(this).val(v.replace(regexp,''));
			}
			$.ajax({
				url : "${contextPath}/member/checkId.do",
				type : "POST",
				data : {
					memberId : $("#memberId").val()
				},
				success : function(result) {
					if (result == 1) {
						$("#id_check").html("중복된 아이디가 있습니다.");
						$("#joinBtn").attr("disabled", "disabled");
					} else {
						$("#id_check").html("");
						$("#joinBtn").removeAttr("disabled");
					}
				}
			});
		});
			
		$("#telNum").keyup(function() {
			var regNumber = /^[0-9]*$/;
			console.log("번호 체크");
			var temp = $("#telNum").val();
			if(!regNumber.test(temp)){
				alert("숫자만 입력하세요")
				$("#telNum").val(temp.replace(/[^0-9]/g,""));
			}
		});
			
		// 이메일  중복확인 AJAX
		$("#email").keyup(function() {
			$.ajax({
				url : "${contextPath}/member/checkEmail.do",
				type : "POST",
				data : {
					email : $("#email").val()
				},
				success : function(result) {
					if (result == 1) {
						$("#email_check").html("중복된 이메일이 있습니다.");
						$("#joinBtn").attr('disabled',true);
					} else {
						$("#email_check").html("");
						$("#joinBtn").attr('disabled',false);
					}
				}
			});
		});
			
		// 닉네임 중복확인 AJAX
		$("#nickName").keyup(function() {
			$.ajax({
				url : "${contextPath}/member/checkNickName.do",
				type : "POST",
				data : {
					nickName : $("#nickName").val()
				},
				success : function(result) {
					if (result == 1) {	//result가 1이면 중복되는 값이 존재함 
						$("#check_nickName").html("중복된 닉네임이 존재합니다.");
						$("#joinBtn").attr('disabled',true);
					} else {
						$("#check_nickName").html("");
						$("#joinBtn").attr('disabled',false);
					}
				}
			});
		});
			
		$("#joinBtn").click(function(){
			alert("회원가입합니다.");
		});
	});
	
	function checkId(obj) {
		if($('#memberId').val().length <5){
			alert("아이디는 5자 이상으로 설정해주세요!")
			$("#memberId").val("").focus();
		}
	}
	
	function checkEmail(obj) {
		console.log("이메일 유효성검사");
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		var v = $("#email").val();
		if( !reg_email.test(v) ) {
			alert("올바른 이메일 형식이 아닙니다.");
			document.joinForm.email.value = "";
		}
	}

	//비밀번호 유효성 검사 
	function check(obj) {
		console.log(obj);
		if($("#memberPwd").val().length < 8){
			alert("비밀번호는 8자 이상으로 설정해주세요!")
			$("#memberPwd").val("").focus();
		}
		if($("#pw2").val().length > 0 && $("#memberPwd").val() != $("#pw2").val()){
			alert("비밀번호가 다릅니다!");
			$("#memberPwd").val("").focus();
			$("#pw2").val("");
		}
	} 
</script>
	<div class="w3-content w3-container w3-margin-top join_form_wrap">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h2><span>myCafe</span> 회원가입</h2>
			</div>
			<div>
				<form id="joinForm" name="joinForm" class="join_form" action="joinMember.do" method="post">
					<div>
						<label>아이디</label> <input class="w3-input" type="text"
							id="memberId" name="memberId" onchange="checkId(this)" required placeholder="5자 이상의 아이디를 입력하세요">
						<span id="id_check" class="w3-text-red"></span>
					</div>
					<div>
						<label>비밀번호</label> <input class="w3-input" id="memberPwd"
							name="memberPwd" type="password" onchange="check(this)" required
							placeholder="비밀번호를 입력하세요(8자이상)">
					</div>
					<div>
						<label>비밀번호확인</label> <input class="w3-input" id="pw2"
							type="password" onchange="check(this)" required placeholder="비밀번호를 입력하세요(8자이상)">
					</div>
					<div>
						<label>이메일</label> <input type="text" id="email" name="email"
							class="w3-input" required placeholder="가입 인증번호 받을 이메일을 입력하세요" onChange="checkEmail()">
						<span id="email_check" class="w3-text-red"></span>
					</div>
					<div>
	                  <label>닉네임</label> 
	                  <input class="w3-input" type="text" id="nickName" name="nickName" required placeholder="닉네임을 입력하세요(8자까지만 가능합니다.)" maxLength="8">
	                  <span id="check_nickName" class="w3-text-red"></span>
	               </div>
					<div>
						<label>핸드폰번호</label> <input type="text" class="w3-input" 
							id="telNum" name="telNum" maxLength="11" placeholder="핸드폰번호를 입력하세요('-'없이 숫자 11자리 입력)" required>
					</div>
					<div>
						<label>이름</label> <input type="text" class="w3-input" id="
							memberName" name="memberName" placeholder="이름을 입력하세요" required>
					</div>
					<div class="w3-center">
						<input type="submit" id="joinBtn" value="가입하기"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">

						<button type="button" onclick="location.href='${contextPath}/member/index.do'"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>
