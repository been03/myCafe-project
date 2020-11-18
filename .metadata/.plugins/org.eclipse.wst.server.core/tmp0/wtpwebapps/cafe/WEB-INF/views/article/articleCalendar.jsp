<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<style type="text/css">
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	#timeMain{
	    background: #ef962d;
	    border: #FFC107 1px solid;
	    width: 400px;
	    height: 100px;
	    position: absolute;
	    right: 255px;
	    font-family: 'Poor Story', cursive !important;
	}
	#calendarMain{
	    background: #ef962d;
	    border: #fff 1px solid;
	    width: 400px;
	    height: 300px;
	    position: absolute;
	    right: 255px;
	    top: 700px;
	    font-family: 'Poor Story', cursive !important;
	}
	#timeView{
	    position: absolute;
	    left: 20px;
	    bottom: 0px;
	    font-size: 50px;
	    color: #faf4f4;
	    font-family: 'Poor Story', cursive !important;
	}
	#timeDateView{
		position: absolute;
	    left: 20px;
	    top: 10px;
	    font-size: 20px;
	    color: #faf4f4;
	    font-family: 'Poor Story', cursive !important;
	}
	#timeWindowCtlBtn{
	    position: absolute;
	    right: 0px;
	    top: 0px;
	    padding: 10px;
	    color: #faf4f4;
	}
	#timeWindowCtlBtn:hover{
		background-color: #5a3f11;
	}
	#calendarWindowCtlBtn{
		position:absolute;
		top:0px;
		right:0px;
		padding:10px;
		color:#faf4f4;
	}
	#calendarWindowCtlBtn:hover{
		background-color: #5a3f11;
	}
	#calendarBeforeBtn{
		position:absolute;
		top:50%;
		left:0px;
		padding:10px;
		color:#faf4f4;
	}
	#calendarBeforeBtn:hover{
		background-color: #5a3f11;
	}
	#calendarAfterBtn{
		position:absolute;
		top:50%;
		right:0px;
		padding:10px;
		color:#faf4f4;
	}
	#calendarAfterBtn:hover{
		background-color: #5a3f11;
	}
	
	#calendarYearMonth{
		position:absolute;
		top:10px;
		left:40px;
		color:#faf4f4;
		font-size:20px;
		font-family: 'Poor Story', cursive !important;
	}
	#calendarDate{
		position: absolute;
	    top: 40px;
	    left: 40px;
	    color: #5a3f11;
	    font-size: 20px;
	    
	    width: 320px;
	    height: 240px;
	    background: #faf4f4;
	    font-family: 'Poor Story', cursive !important;
	}
	table { width:100%; height:100%; }
	table, td {
	    color: #5a3f11;
	    border: #5a3f11 1px solid;
	    border-collapse: collapse;
	    text-align: center;
	    cursor: pointer;
	    font-family: 'Poor Story', cursive !important;
	}
	td:first-child{
		color:red;
	}
	#timeMain.minimum{
		height:40px;
		position:absolute;
	}
	#timeView.minimum{
		display:none;
	}
	#timeDateView.minimum{
		display:none;
	}
	#calendarMain.minimum{
		height:40px;
		position:absolute;
	}
	#calendarYearMonth.minimum{
		display:none;
	}
	#calendarDate.minimum{
		display:none;
	}
	#calendarBeforeBtn.minimum{
		display:none;
	}
	#calendarAfterBtn.minimum{
		display:none;
	}
	.event_calendar_section{
	    width: 920px;
	    margin: 30px auto;
	    padding: 20px 0;
	    font-family: 'Poor Story', cursive !important;
	}
	.event_description{
	    width: 413px;
	    text-align: center;
	    min-height: 515px;
	}
	.event_div{
		border: 1px solid #EF962D;
		background-color:#EF962D;
	    overflow: hidden;
	    margin-bottom: 40px;
	    margin: 15px auto 25px;
	    -moz-box-shadow: 5px 5px 7px rgba(239, 150, 45, 0.3);
	    -webkit-box-shadow: 5px 5px 7px rgba(239, 150, 45, 0.3);
	    box-shadow: 5px 5px 7px rgba(239, 150, 45, 0.3);
	    width: 300px;
	    height: 280px;
	}
	.event_div:nth-child(2n){
		background-color:#EF962D;
	}
	.event_div > span:first-child{
	    line-height: 30px;
	    float: left;
	    background-color: #ffeb3bb3;
	    color: black;
	    font-weight: bold;
	    width: 75px;
	    transform: rotate(-21deg);
	    position: absolute;
        left: 455px;
	    margin-top: -8px;
	}
	.event_div span:nth-child(2){
	    float: left;
	    line-height: 20px;
	    width: 291px;
	    font-size: 15px;
	    word-break: break-word;
	    display: inline-block;
	    padding: 5px;
	    text-align: center;
	    margin: 0 auto;
	    font-weight: bold;
	    color: black;
	}
	.event_description_p{
	    padding: 0 10px;
	    line-height: 20px;
	    margin: 30px 0 0;
	    height: 167px;
	    text-align: left;
	    font-size: 15px;
	    width: 281px;
	    text-overflow: ellipsis;
	    word-break: break-word;
	}
	.event_div span:nth-child(4), .event_div span:nth-child(5){
		float: left;
	    color: #007eff;
	    font-weight: 600;
	    display: inline-block;
	    line-height: 30px;
	    margin: 0 10px;
	    font-style: italic;
	    font-size: 13px;
	}
	.event_link{
	    margin-top: 30px;
	    display: block;
	    text-decoration: none;
	    color: #faf4f4;
	    font-weight: 600;
	    margin-left: 10px;
	    text-align: left;
	    font-size: 13px;
	}
	.event_link_span:hover{
	    color: #2196F3;
	    font-weight: bold;
	}
	.event_date_p{
	    border-top: 2px solid #ef962d;
	    line-height: 30px;
	    font-family: sans-serif;
	    text-align: center;
	    font-size: 13px;
	    color: #faf4f4;
	    font-weight: 600;
	    font-family: 'Poor Story', cursive !important;
	}
	.event_date_p span{
	    margin: 0 5px;
	}
	.event_div:hover, .event_div:focus{
		-moz-box-shadow:10px 10px 7px rgba(0,0,0,.7);
	  	-webkit-box-shadow: 10px 10px 7px rgba(0,0,0,.7);
	  	box-shadow:10px 10px 7px rgba(0,0,0,.7);
	  	-webkit-transform: scale(1.1);
	  	-moz-transform: scale(1.1);
	  	-o-transform: scale(1.1);
	  	position:relative;
	  	z-index:5;
	}
	.event_calendar_today_p{
	    text-align: center;
	    line-height: 30px;
	    margin-bottom: 30px;
	    font-size: 30px;
	    color: CORAL;
	    font-weight: bold;
	}
</style>
<body onload='javascript:main();'>
	<section class="event_calendar_section">
		<p class="event_calendar_today_p"><i class="fas fa-anchor"></i><span>${date }</span><i class="fas fa-anchor"></i></p>
		<div id='timeMain'>
			<div id='timeView'>시간</div>
			<div id='timeWindowCtlBtn'>▽</div>
			<div id='timeDateView'>날짜</div>
		</div>
		<div id='calendarMain'>
			<div id='calendarYearMonth'>년 월</div>
			<div id='calendarWindowCtlBtn'>△</div>
			<div id='calendarDate'>날짜</div>
			<div id='calendarBeforeBtn'>&lt;</div>
			<div id='calendarAfterBtn'>&gt;</div>
		</div>
		<div id="eventDescription" class="event_description">
			<c:forEach items="${events }" var="event">
				<div class="event_div">
					<span>${event.eventStatus } </span>
					<span>${event.eventName } </span>
					<p class="event_description_p">${event.eventDescription } </p>
					<span>#${event.eventPlace } </span>
					<span>#${event.eventRegion }</span>
					<a class="event_link" href="${event.eventSite }">관련사이트: <span class="event_link_span">${event.eventName }</span> </a>
					<p class="event_date_p"><span>행사기간:</span> <fmt:formatDate value="${event.eventStartDate}" pattern="yyyy년  M월 d일" /> ~ <fmt:formatDate value="${event.eventEndDate}" pattern="yyyy년  M월 d일" /> </p>
				</div>
			</c:forEach>
			<c:if test="${empty events }">
				<div class="event_div">
					<span>없어요</span>
					<span>등록된 이벤트/행사가 없습니다</span>
					<p class="event_description_p"><i class="far fa-sad-tear" style="width: 200px; height: 105px; margin: 10px 40px; text-align: center;"></i></p>
					<span>#없어요</span>
					<span>#없어요</span>
					<a class="event_link" href="javascript:void(0);"><span class="event_link_span">없어요</span> </a>
					<p class="event_date_p"><span>없어요</span>  </p>
				</div>
			</c:if>
		</div>
	</section>
	<script type="text/javascript">
		window.addEventListener('DOMContentLoaded', function () {
		    var td_list = document.getElementById("calendarDate");
		    td_list.addEventListener('click', function(e) {
		    if (e.target && e.target.nodeName === 'TD') {
		        if (e.target.innerHTML == "" || e.target.innerHTML === '일' || e.target.innerHTML === '월'
		        	|| e.target.innerHTML === '화' || e.target.innerHTML === '수' || e.target.innerHTML === '목'
		        		|| e.target.innerHTML === '금' || e.target.innerHTML === '토'){
		        	alert("날짜를 선택하세요!!");
		        	return;
		        }
		        document.getElementById("eventDescription").innerHTML = document.getElementById("calendarYearMonth").innerHTML + " " + e.target.innerHTML + "일";
		      	var selected_date = document.getElementById("eventDescription").innerHTML;
		    	history.replaceState({}, null, location.pathname);
		    	location.href="${contextPath}/member/articleCalendar.do?eventDate="+selected_date;
		    }
		     
		    }); 
		});
		function main(){
			let curTime = new Date();
			setTimeView();
			setTimeDateView(curTime);
			setCalendarYearMonth(curTime);
			setCalendarDate(curTime);
			setMoveBtn();
			setTimeWindowMinimumBtn();
			setcalendarWindowMinimumBtn();
		}
		function setTimeWindowMinimumBtn(){
			let timeWindowCtlBtn = document.getElementById('timeWindowCtlBtn');
			timeWindowCtlBtn.addEventListener('click',
			() => {
				let timeWindowCtlBtn = document.getElementById('timeWindowCtlBtn');
				let timeMain = document.getElementById('timeMain');
				let timeView = document.getElementById('timeView');
				let timeDateView = document.getElementById('timeDateView');
				
				if (timeWindowCtlBtn.innerText == '▽'){
					timeMain.setAttribute('class','minimum');
					timeView.setAttribute('class','minimum');
					timeDateView.setAttribute('class','minimum');
					
					timeWindowCtlBtn.innerHTML='□';
				} else {
					timeMain.removeAttribute('class');
					timeView.removeAttribute('class');
					timeDateView.removeAttribute('class');
					
					timeWindowCtlBtn.innerHTML='▽';
				}
			});
		}
		
		function setcalendarWindowMinimumBtn(){
			let calendarWindowCtlBtn = document.getElementById('calendarWindowCtlBtn');
			calendarWindowCtlBtn.addEventListener('click',
			() => {
				let calendarWindowCtlBtn = document.getElementById('calendarWindowCtlBtn');
				let calendarMain = document.getElementById('calendarMain');
				let calendarYearMonth = document.getElementById('calendarYearMonth');
				let calendarDate = document.getElementById('calendarDate');
				let calendarBeforeBtn = document.getElementById('calendarBeforeBtn');
				let calendarAfterBtn = document.getElementById('calendarAfterBtn');
				
				if (calendarWindowCtlBtn.innerText == '△'){
					calendarMain.setAttribute('class','minimum');
					calendarYearMonth.setAttribute('class','minimum');
					calendarDate.setAttribute('class','minimum');
					calendarBeforeBtn.setAttribute('class','minimum');
					calendarAfterBtn.setAttribute('class','minimum');
					
					
					calendarWindowCtlBtn.innerHTML='□';
				} else {
					calendarMain.removeAttribute('class');
					calendarYearMonth.removeAttribute('class');
					calendarDate.removeAttribute('class');
					calendarBeforeBtn.removeAttribute('class');
					calendarAfterBtn.removeAttribute('class');
					
					calendarWindowCtlBtn.innerHTML='△';
				}
			});
		}
		function setMoveBtn(){
			let calendarBeforeBtn = document.getElementById('calendarBeforeBtn');
			let calendarAfterBtn = document.getElementById('calendarAfterBtn');
			
			calendarBeforeBtn.addEventListener('click', moveCalendar);
			calendarAfterBtn.addEventListener('click', moveCalendar);
		}
		
		function moveCalendar(event){
			let oldYearMonth =document.getElementById('calendarYearMonth');
			
			let temp = oldYearMonth.innerText.split(' '/*'년'*/);
			let oldYear = temp[0].split('년');
			let oldMonth = temp[1].split('월');
			let other = 0
			if (event.target.id == 'calendarBeforeBtn'){
				other = 2;
			} 
			
			let moveDate = new Date(
					oldYear[0], // 2020
					oldMonth[0] - other, // 1 - 2
					// 0 - 1월 / 11 - 12월
					1
			);
			setCalendarYearMonth(moveDate);
			setCalendarDate(moveDate);
		}
		
		function setTimeView(){
			let timeView = document.getElementById('timeView');
			setInterval(()=>{
				let curTime = new Date();
				timeView.innerHTML = 
				convertHour(curTime.getHours())+':'+
				makeTwoWords(curTime.getMinutes())+':'+
				makeTwoWords(curTime.getSeconds());
			},1000);
		}
		
		function makeTwoWords(num){
			if(num<10) {
				return '0'+num;
			}
			return num;
		}
		function convertHour(h){
			let str='오전 ';
			if (h > 12){
				h -= 12;
				str='오후 ';
			}
			return str+makeTwoWords(h);
		}
		
		function setTimeDateView(curTime){
			let timeDateView = document.getElementById('timeDateView');
			timeDateView.innerHTML = curTime.getFullYear()+'년 ';
			timeDateView.innerHTML += (curTime.getMonth()+1)+'월 ';
			timeDateView.innerHTML += curTime.getDate()+'일 ';
			timeDateView.innerHTML += getDay(curTime.getDay());
		}
		
		function getDay(day){
			let dayArr = ['일','월','화','수','목','금','토'];
			return dayArr[day]+'요일';
		}
		
		function getYearMonth(curTime){
			return curTime.getFullYear()+'년 '+ (curTime.getMonth()+1)+'월';
		}
		function setCalendarYearMonth(curTime){
			let calendarYearMonth = document.getElementById('calendarYearMonth')
			calendarYearMonth.innerHTML = getYearMonth(curTime);
		}
		
		function setCalendarDate(curTime){
			let calendarDate = document.getElementById('calendarDate');
			
			calendarDate.innerHTML='';
			
			let firstDaylastDate = getCurrentCalendar(
					curTime.getFullYear(),
					curTime.getMonth()
			);
			
			calendarDate.appendChild(createTable(
					firstDaylastDate.firstDay,
					firstDaylastDate.lastDate
				)
			);
		}
		
		function createTable(day, endDate){
			let dayArr=['일','월','화','수','목','금','토'];
			let table = document.createElement('table');
			let dateCnt = 1; // 1 ~ 31 일까지 증가
			let maxI = (endDate+day)/7+1;
			
			for(let i=0;i<maxI;i++){
				let tr = document.createElement('tr');
				for(let j=0;j<7;j++){
					let td = document.createElement('td');
					if(i == 0){
						td.innerHTML = dayArr[j];
					} else if(i==1 && j<day){
					 	td.innerHTML = '';
					} else {
						td.innerHTML = dateCnt++;
					}
					tr.appendChild(td);
					if (dateCnt > endDate){
						break;
					}
				}
				table.appendChild(tr);
			}
			return table;
		}
		
		function getCurrentCalendar(year, month){
			return {
				firstDay:new Date(year,month, 1).getDay(),
				lastDate:32 - new Date(year,month,32).getDate()
			}
		}
	</script>
