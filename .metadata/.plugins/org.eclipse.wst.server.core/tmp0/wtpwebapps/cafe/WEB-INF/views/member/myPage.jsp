<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

	<script>
		$(function(){
			$("#final_submit").click(function(){
				location.href="${contextPath}/member/myPageMain.do?memberId=${member.memberId}";
			});
			
			$("#modifyBtn").click(function(){
				alert("회원정보를 수정합니다.");
				var formData = new FormData($("#myForm")[0]);
				console.log(formData);
			});
			
			$("#modifyPwd").click(function(){
				alert("비밀번호를 수정합니다.");
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
				
			if($("#pwForm").submit(function(){
				if($("#memberPwd").val() !== $("#pw2").val()){
					alert("비밀번호가 다릅니다.");
					$("#memberPwd").val("").focus();
					$("#pw2").val("");
					return false;
				}else if ($("#memberPwd").val().length < 8) {
					alert("비밀번호는 8자 이상으로 설정해야 합니다.");
					$("#memberPwd").val("").focus();
					return false;
				}else if($.trim($("#memberPwd").val()) !== $("#memberPwd").val()){
					alert("공백은 입력이 불가능합니다.");
					return false;
				}
			}));
				
			if($("#wdForm").submit(function(){
				if(!confirm("탈퇴하시겠습니까?")){
					return false;
				}
			}));
				
			// 닉네임 중복확인 AJAX
			$("#nickName").keyup(function() {
				$.ajax({
					url : "${contextPath}/member/checkNickName.do",
					type : "POST",
					data : {nickName : $("#nickName").val()},
					success : function(result) {
						if (result == 1) {	//result가 1이면 중복되는 값이 존재함 
							$("#check_nickName").html("중복된 닉네임이 존재합니다.");
							$("#modifyBtn").attr('disabled',true);
						} else {
							$("#check_nickName").html("");
							$("#modifyBtn").attr('disabled',false);
						}
					}
				});
			});
		});
		
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$('#preview').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}  
	</script>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
		@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap');
		.my_page_wrap{
			font-family: 'Poor Story', cursive !important;
			width:850px;
		    margin: 30px auto !important;
		    font-weight: bold;
		}
		.my_page_wrap h2{
			font-family: 'Gamja Flower', cursive;
			font-size: 30px;
			font-weight:bold;
		}
		.profile_image_div{
		    margin-bottom: 20px;
	    	padding: 0 0 0 10px;
		}
		.profile_image_div img{
			width:100px;
			height:100px;
			margin-bottom:10px;
		}
		.profile_image_div label{
		    margin-right: 20px;
	    	display: block;
		}
		.profile_image_div input[type=file]{
		    margin-left: 10px;
	    }
	    .my_page_wrap label{
	    	font-size: 20px;
		    margin-top: 7px;
		    color: #ef962d;
		    font-weight:bold;
	    }
	    .my_page_wrap input[type=text]{
	    	font-size: 18px;
	    }
	    .my_page_wrap input[type=submit], .my_page_wrap button[type=submit]{
		    background: #ef962d !important;
		    font-weight: 900;
		    color: black !important;
		    font-size: 18px;
	    }
	    .my_page_wrap input[type=submit]:hover, .my_page_wrap button[type=submit]:hover{
	    	color: white !important;
	    	transform:scale(1.1);
	    }
	    .my_page_wrap input[type=submit]:last-child{
	    	margin-top: 30px !important;
	   	    color: white !important;
	    }
	    .my_page_wrap input[type=submit]:last-child:hover{
	    	color: black !important;
	    	transform:scale(1.1);
	    }
	    .my_page_form_wrap{
	    	padding-bottom: 30px;
	    }
	</style>
	<div class="w3-content w3-container w3-margin-top my_page_wrap">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h2>마이페이지</h2>
			</div>
			<div class="my_page_form_wrap">
				<form id="myForm" name="myForm" class="my_form" action="${contextPath }/member/updateMyPage.do"  method="post" enctype="multipart/form-data">
					<div class="profile_image_div">
						<c:if test="${member.imageId.equals('basic')  }">
							<label>프로필 사진</label>
						    <input type= "hidden" name="originalImageId" value="${member.imageId }" />
						    <img src="${contextPath }/resources/upload/photo_profile/profile_basic.png" id="preview"><br>
						    <input type="file"name="imageId" id="i_imageId"  onchange="readURL(this);"   />
						</c:if>
						<c:if test="${!member.imageId.equals('basic')  }">
							<label>프로필 사진</label>
						    <input type= "hidden"  name="originalImageId" value="${member.imageId }" />
						    <img src="${contextPath }/resources/upload/photo_profile/${member.memberId}/${member.imageId}" id="preview"><br>
						    <input type="file" name="imageId " id="i_imageId" onchange="readURL(this);"   />
						</c:if>
					</div>
					<div>
						<label>ID</label> 
						<input class="w3-input" type="text" id="memberId" name="memberId" readonly value="${ member.memberId }"> 
					</div>
					<div>
						<label>Email</label> 
						<input class="w3-input" type="text" id="email" name="email" readonly value="${ member.email }" required> 
					</div>
					<div>
                  		<label>닉네임</label> <input type="text" class="w3-input" id="nickName" name="nickName" value="${member.nickName }" maxLength="8" >
                  		<span id="check_nickName" class="w3-text-red"></span>
              		</div>
					<div>
						<label>핸드폰번호</label> <input type="text" class="w3-input" id="telNum" name="telNum" value="${member.telNum }">
					</div>
					<div>
						<label>이름</label> <input type="text" class="w3-input" id="memberName" name="memberName" value="${member.memberName }">
					</div>
					<div class="w3-center">
						<input type="submit" id="modifyBtn" value="회원정보 변경하기" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">
					</div>
				</form>
				<br>
				
				<form id="pwForm" action="${contextPath }/member/updatePw.do" method="post">	
					<input type="hidden" name="memberId" value="${ member.memberId }">
					<div>
						<label>현재 비밀번호</label>
						<input class="w3-input" id="old_pw" name="old_pw" type="password" placeholder="현재 비밀번호를 입력하세요" required>
					</div>
					<div>
						<label>새로운 비밀번호</label> 
						<input class="w3-input" id="memberPwd" name="memberPwd" type="password" placeholder="새로운 비밀번호를 입력하세요" required>
					</div>
					<div>
						<label>새로운 비밀번호 확인</label>
						<input class="w3-input" type="password" id="pw2" type="password" placeholder="새로운 비밀번호를 입력하세요" required>
					</div>
					<div class="w3-center">
						<button type="submit" id="modifyPwd" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">비밀번호 변경 하기</button>
					</div>
				</form>
				<br>
				<form id="wdForm" action="${contextPath }/member/withdrawal.do" method="post">
					<input type="hidden" name="memberId" readonly value="${member.memberId }">
					<div>
						<label>패스워드</label>
						<input class="w3-input" type="password" name="memberPwd"  placeholder="비밀번호를 입력하세요" required>
					</div>
					<div class="w3-center">
						<button type="submit" id="byeBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" >회원탈퇴</button> 
					</div>
				</form>
				<div class="w3-center">
					<input type="submit" value="닫기" id="final_submit" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" >
				</div>
			</div>
		</div>
	</div>
