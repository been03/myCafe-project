<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	.message_wrap{
		width: 350px;
		margin: 0 auto;
		font-family: 'Poor Story', cursive !important;
	}
	.message_wrap p{
		font-size:15px;
	    margin: 5px 0;
	}
	.content_p{
	    min-height: 200px;
   		border: 1px solid #ef962d;
    	padding: 5px;
	}
	.message_wrap input[type=text]{
		width: 300px;
    	margin-left: 10px;
	}
	.message_wrap textarea{
	    resize: none;
    	width: 334px;
    	height: 300px;
	}
	.message_wrap input[type=submit], .message_wrap input[type=button]{
		background:#ef962d;
		border: 1px solid #ef962d;
		font-weight:bold;
		font-family: 'Poor Story', cursive !important;
	}
	.receiveMember {
		position: absolute;
		top: 1%;
		left: 90px;
	}
	.sendMember {
		position: absolute;
		top: 6%;
		left: 100px;
	}
	#sender {
		float:left;
		font-weight:bold;
	    position: absolute;
	    top: 3px;
	    left: 85px;
	}
</style>
</head>
<body onresize="parent.resizeTo(400, 500)" onload="parent.resizeTo(400, 500)">
	<div class="message_wrap">
		<form id="message_form" name="message_form" class="message_form" method="post">
			<c:if test="${loginMember.role.equals('ADMIN') && not empty msg}">
				<p style="font-weight:bold;">받는 사람&nbsp;${msg.nickName }(${msg.memberId })</p>
				<p style="font-weight:bold;">제목&nbsp;${msg.messageTitle }</p>
				<p class="content_p">${msg.messageContent }</p>
				<div><input type="submit" value="닫기" onClick="window.close()"></div>
			</c:if>
			<c:if test="${loginMember.role.equals('USER')  && not empty msg }">
				<c:if test="${loginMember.memberId.equals(msg.senderMemberId) }">
					<p style="font-weight:bold;">받는 사람&nbsp;${msg.nickName }</p>
				</c:if>
				<c:if test="${!loginMember.memberId.equals(msg.senderMemberId) }">
					<p style="font-weight:bold;">보낸사람</p>
					<p id="sender">${msg.senderNickName }</p>
				</c:if>
				<p style="font-weight:bold;">제목&nbsp;${msg.messageTitle }</p>
				<p class="content_p">${msg.messageContent }</p>
				<div>
					<c:if test="${!msg.senderNickName.equals('관리자') && loginMember.memberId.equals(msg.memberId) }">
						<input type="button" value="답장" id="reply" onclick="openNewWindow()">
					</c:if>
					<input type="submit" value="닫기" id="childClose">
				</div>
			</c:if>
			<c:if test="${empty msg && loginMember.role.equals('ADMIN')}">
				<p style="font-weight:bold;">받는 사람</p>
				<p id="member" class="receiveMember"></p>
				<p style="font-weight:bold;">보내는 사람</p>
				<p class="sendMember">관리자</p>
				<p>제목<input type="text" name="title" placeholder="제목을 입력하세요" maxLength="200"></p>
				<textarea name="content" id="content" placeholder="내용을 입력하세요"></textarea>
				<div>
					<input type="submit" value="보내기" name="send">
					<input type="submit" value="취소" onClick="window.close()">
				</div>
			</c:if>
			<c:if test="${empty msg && loginMember.role.equals('USER')}">
				<p style="font-weight:bold;">받는 사람</p>
				<p id="member" class="receiveMember"></p>
				<p style="font-weight:bold;">보내는 사람</p>
				<p class="sendMember">${loginMember.nickName }</p>
				<p>제목<input type="text" name="title" placeholder="제목을 입력하세요" maxLength="200"></p>
				<textarea name="content" id="content" placeholder="내용을 입력하세요"></textarea>
				<div>
					<input type="submit" value="보내기" name="send">
					<input type="submit" value="취소" onClick="window.close()">
				</div>
			</c:if>
		</form>
	</div>
	<script>
		function GET(search) {
			var obj = {};
			var uri = decodeURI(search);
			uri = uri.slice(1,uri.length);
			console.log(uri);
			var devide = uri.split('=');
			obj=devide[1];
			console.log(obj);
			return obj;
		  }
	 
		window.onload = function () {
			var search = window.location.search;
			var getData = GET(search);
			var member = document.getElementById('member');
			console.log(member);
			if(member != null) {
				member.innerHTML = getData;
			}
		}

		var newWindow;
		function openNewWindow(){
			var nickName = document.getElementById('sender').innerHTML;
			console.log(nickName);
		    window.open("messageForm.do?nickName="+nickName , "newWindow", "width=400, height=450, top=150, left=500, scrollbar=no");
		}
	    
		$("#childClose").click(function(e){
			opener.parent.location.reload();
			window.close();
		});
    
		$("input[name=send]").click(function(e){
			e.preventDefault();
			console.log("보내기클릭");
			var formData = new FormData();
			var title = $("input:text[name=title]").val();
			var content = $("#content").val();
			formData.append("title",title);
			formData.append("content",content);
			var search = window.location.search;
			var member = GET(search);
			formData.append("member",member);
			$.ajax({
				url : "messageSend.do",
				type : "post",
				data : formData,
				contentType : false,
				processData : false,
				success : function(data){
					if(data == '1') {
						alert("쪽지 보내기 성공");
						opener.parent.location.reload();
						window.close();
					} else {
						alert("쪽지 보내기 실패");
					}
				}
			});
		});
	</script>
</body>
</html>