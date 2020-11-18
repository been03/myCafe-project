<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#sendBtn').click(function() {
			sendMessage();
			$('#message').val(''); 
		});
	});

	let sock = new SockJS("http://localhost:8080/mycafe/echo");
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	// 메시지 전송
	function sendMessage() {
		var nickname = $("#nickname").val();
		var msg = $("#message").val();

		sock.send(nickname + "님의 메세지 <br> " + msg);
		$("#message").val("");
	}

	// 서버로부터 메시지를 받았을 때
	function onMessage(msg, nickname) {
		var data = msg.data;
		$("#messageArea").append(
				'<div class="row message-bubble">' + '<span>' + data + '</span>'
						+ '</div>' + '<hr>');
	}

	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#messageArea").append("다시 시도 하세요.");

	}
</script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	.chat_wrap_div {
	    padding: 0;
	    margin: 0 auto;
	    border: 1px solid #ef962d;
	    font-family: 'Poor Story', cursive !important;
	}
	
	.chat_heading_div {
		background-color: #ef962d;
	    color: white;
	    line-height: 30px;
	    text-align: center;
	    font-weight: bold;
	}
	.msg_area {
	    height: 620px;
	    overflow-y: scroll;
	    padding: 0 10px;
	    margin-bottom: 10px;
	}
	.chat_footer_div{
	    text-align: center;
	    height: 95px;
	    background: #ef962d17;
	    font-family: 'Poor Story', cursive !important;
	}
	input[name=nickName]{
	    display: block;
	    text-align: left;
	    margin: 0 auto 10px;
	    width: 96%;
	    border: none;
	    border-bottom: 1px solid white;
	    font-weight: bold;
	    color: white;
	    background: #ef962d;
	    line-height: 15px;
	    padding: 8px;
	    font-family: 'Poor Story', cursive !important;
	}
	textarea[name=message]{
	    background: #ef962d00;
	    width: 370px;
	    line-height: 18px;
	    resize: none;
	    font-weight: 600;
	    border: none;
	    font-family: 'Poor Story', cursive !important;
	}
	.send_button{
	    border: 1px solid #ef962d;
	    background: #ef962d;
	    font-weight: 900;
	    padding: 10px;
	    vertical-align: top;
	    font-family: 'Poor Story', cursive !important;
	}
	.message-bubble{
		padding:10px;
	}
	.message-bubble > span{
	    word-break: break-word;
	}
</style>
</head>
<body onresize="parent.resizeTo(500, 800)" onload="parent.resizeTo(500, 800)">
	<div class="chat_wrap_div">
		<div class="chat_heading_div">myCafe 채팅방입니다. 욕설 및 비방은 금지입니다.</div>
		<div class="chat_body_div">
			<div id="messageArea" class="msg_area"></div>
		</div>
		<div class="chat_footer_div">
			<div class="chat_input_div">
				<input type="text" id="nickname" name="nickName" value="${member.nickName }" readOnly> 
				<textarea id="message" name="message" placeholder="최대 200자까지 입력가능합니다." maxLength="200"></textarea> 
				<button id="sendBtn" class="send_button" type="button" >보내기</button>
			</div>
		</div>
	</div>
</body>
</html>