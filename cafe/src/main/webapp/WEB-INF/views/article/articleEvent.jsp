<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

	<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript" src="${contextPath }/resources/js/jquery-ui.min.js"></script>
	
	<!-- 카드형 레이아웃 참고 : https://endorphin0710.tistory.com/70 -->
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
		
		.event_card_sectionblockquote, .event_card_section q {
			quotes: none;
		}
		
		.event_card_section blockquote : before, .event_card_section blockquote : after, 
		.event_card_section q : before, .event_card_section q : after {
			content: '';
			content: none;
		}
		
		.event_card_section table {
			border-collapse: collapse;
			border-spacing: 0;
		}
		.event_card_section a{
			text-decoration:none;
			color: blue;
		}
		.event_card_section{
		    width: 920px;
		    margin: 0 auto;
		    font-family: 'Poor Story', cursive;
		}
		.event_card_section h2{
			margin: 20px 0 10px 30px;
		    font-size: 30px;
		    color: #ef962d;
		    font-weight:bold;
		    font-family: 'Poor Story', cursive;
		}
		.card {
			height: 410px;
			width: 350px;
			border-radius: 15px;
			display: inline-block;
		    margin: 15px 0px 5px 100px;
			position: relative;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
				rgba(0, 0, 0, 0.19);
			overflow: hidden;
			font-size:13px;
		}
		div.card:nth-child(2n){
			margin-left:30px;
		}
		.card_header {
			-webkit-transition: 0.5s; /*사파리 & 크롬*/
			-moz-transition: 0.5s; /*파이어폭스*/
			-ms-transition: 0.5s; /*인터넷 익스플로러*/
			-o-transition: 0.5s; /*오페라*/
			transition: 0.5s;
			width: 100%;
			height: 270px;
			border-radius: 15px 15px 0 0;
			background-image: url("${contextPath}/resources/image/경회루.jpg");
			background-size: 100% 280px;
			background-repeat: no-repeat;
		}
		.card:hover .card_header {
			opacity: 0.8;
			height: 100px;
		}
		.card_header_is_closed {
			background-color: #ef962d;
		    color: #FFF;
		    text-align: center;
		    float: right;
		    margin: 15px 15px 0 0;
		    border-radius: 50%;
		    font-weight: bold;
		    padding: 10px 10px;
		    line-height: 15px;
		    height: 50px;
		    width: 55px;
		}
		.card_body_header {
			line-height: 25px;
			margin: 10px 20px 0px 20px;
		}
		.card_body_description {
			opacity: 0;
			color: #757B82;
			line-height: 25px;
			-webkit-transition: .2s ease-in-out; /*사파리&크롬*/
			-moz-transition: .2s ease-in-out; /*파이어폭스*/
			-ms-transition: .2s ease-in-out; /*익스플로러*/
			-o-transition: .2s ease-in-out; /*오페라*/
			transition: .2s ease-in-out;
			overflow: hidden;
			height: 180px;
			margin: 5px 20px;
		}
		.card:hover .card_body_description {
			opacity: 1;
			-webkit-transition: .5s ease-in-out;
			-moz-transition: .5s ease-in-out;
			-ms-transition: .5s ease-in-out;
			-o-transition: .5s ease-in-out;
			transition: .5s ease-in-out;
			overflow-y: scroll;
		}
		.card_header > button{
			position: absolute;
		    background-color: orange;
		    border: 1px solid orange;
		    color: white;
		    cursor: pointer;
		}
		.card_header button:hover{
			color:blue;
		}
		.card_body_eventname{
		    font-size: 14px;
		    font-weight: bold;
		    text-align: center;
		   	word-break: break-word;
		}
		.card_body_desc{
			display: block;
		    word-break: break-word;
		    min-height: 138px;
		}
		.card_body_hashtag {
			color: #2478FF;
			font-style: italic;
		}
		.card_body_file_link{
		    margin-right: 5px;
		}
		.card_body_footer {
			position: absolute;
			margin: 15px auto 6px;
			bottom: 0;
			width: 350px;
			font-size: 14px;
			color: #9FA5A8;
			padding: 0 15px;
			text-align:center;
		}
		.icon {
			display: inline-block;
			vertical-align: middle;
			margin-right: 2px;
		}
		.reg_date {
			float: right;
		}
	</style>
	<section class="event_card_section">
		<h2>이벤트 게시판</h2>
		<div id="cardList">
			<c:forEach items="${eventList }" var="list">
				<div class="card">
					<div class="card_header" style="background-image: url(${contextPath }/resources/image/<c:out value="${list.eventRegion != null ? list.eventRegion : '경회루'}"/>.jpg)">
						<c:if test="${member.role == 'ADMIN' }">
							<button name="modifyEvent" onClick="location.href='${contextPath }/admin/articleEventRegister.do?eventId=${list.eventId}'"><i class="far fa-edit"></i></button>
						</c:if>
						<div class="card_header_is_closed">
							<div class="card_header_text">${list.eventStatus }</div>
							<div class="card_header_number">${list.eventId }</div>
						</div>
					</div>
					<div class="card_body">
						<div class="card_body_header">
							<p class="card_body_eventname">${list.eventName }</p>
							<p class="card_body_hashtag">#${list.eventPlace }</p>
							<p class="card_body_nickname">작성자: 관리자</p>
						</div>
						<p class="card_body_description">
							<span class="card_body_desc">${list.eventDescription }</span>
							<c:if test="${not empty list.imageList }">
								<c:forEach items="${list.imageList }" var="img" varStatus="status">
									<a class="card_body_file_link" href="${contextPath }/resources/upload/event_image/${img}" download="event_img${status.index+1 }.jpg">
										<span>첨부파일${status.index+1 }</span><i class="far fa-file-image"></i>
									</a>
								</c:forEach>
							</c:if>
							<br>
							<span>관련사이트:</span> <a href="${list.eventSite }" target="_blank">${list.eventName }</a>
						</p>
						<div class="card_body_footer">
							<hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31; width:315px">
							<span>
								<i class="far fa-calendar-check"></i>
								<fmt:formatDate value="${list.eventStartDate }" pattern="yyyy년 MM월 dd일"/> ~ 
								<i class="far fa-calendar-check"></i>
								<fmt:formatDate value="${list.eventEndDate }" pattern="yyyy년 MM월 dd일"/>
							</span>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	<script>
		//무한 스크롤 참고: https://wjheo.tistory.com/entry/Spring-%ED%8E%98%EC%9D%B4%EC%A7%80-%EB%AC%B4%ED%95%9C%EC%8A%A4%ED%81%AC%EB%A1%A4
		var lastScrollTop = 0;
		var page = 1;
		$(window).scroll(function(){ 
			if (Math.round($(window).scrollTop()) == $(document).height() - $(window).height()-1){
				alert("새로운 글을 불러옵니다!");
				page += 1;
				$.ajax({
					type : 'post', 				
					url : '${contextPath}/article/articleEvent.do?page='+page,
					dataType : 'json', 			
					success : function(data){	
						var str = "";
						if(data != ""){
							$(data).each(function(){
								str += '<div class="card">';
								if (this.eventRegion != null){
									str += '<div class="card_header" style="background-image: url(${contextPath }/resources/image/'+this.eventRegion+'.jpg)">';
								}else {
									str += '<div class="card_header">';
								}
								
								if ("${member.role}" == 'ADMIN'){
									str += '<button name="modifyEvent" onClick="location.href=\'';
									str += 'articleEventRegister.do?eventId=';
									str += this.eventId
									str += '\'"><i class="far fa-edit"></i></button>';
								}
								
								str += '<div class="card_header_is_closed">';
								str += '<div class="card_header_text">'+this.eventStatus+'</div>';
								str += '<div class="card_header_number">'+this.eventId+'</div></div></div>';
								str += '<div class="card_body"><div class="card_body_header">';
								str += '<p class="card_header_eventname">'+this.eventName+'</p>';
								str +=	'<p class="card_body_hashtag">#'+this.eventPlace+'</p><p class="card_body_nickname">작성자: 관리자</p></div>';
								str +=	'<p class="card_body_description"><span class="card_body_desc">'+this.eventDescription+'</span>';
								
								if (this.imageList != null){
									for (var i=0; i<this.imageList.length; i++){
											str += '<a class="card_body_file_link" href="${contextPath }/resources/upload/event_image/'+this.imageList[i]+'" download="'+this.eventName+'_'+(i+1)+'.jpg">';
											str += '<span><i class="far fa-file-image"></i>첨부파일'+(i+1)+'</span></a>';
									}
								}
								
								str +=	'<br><span>관련사이트:</span> <a href="'+this.eventSite+'" target="_blank">'+this.eventSite+'</a></p>';
								str +=	'<div class="card_body_footer"><hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">';
								str +=	'<span><i class="far fa-calendar-check"></i>';
								str +=	this.formattedStartDate+'~ <i class="far fa-calendar-check"></i>';
								str +=	this.formattedEndDate;
								str +=	'</span></div></div></div>';
							});
							$(".card").last().after(str);
						}
						else{
							alert("모든 데이터를 불러왔습니다!");
							return;
						}
					}
				});
			}
		});
	</script>
