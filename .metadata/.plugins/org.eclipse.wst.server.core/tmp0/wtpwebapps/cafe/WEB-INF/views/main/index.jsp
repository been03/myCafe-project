<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<style media="screen">
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
  .slideshow_section{
    width: 920px;
    margin: 30px auto;
    font-family: 'Poor Story', cursive;
  }
  * {
    box-sizing: border-box;
  }
  .container {
    position: relative;
  }
  .mySlides {
    display: none;
  }
  .cursor {
    cursor: pointer;
  }
  .row{
    width: 920px;
    height: 80px;
    overflow: hidden;
  }
  .prev, .next {
    cursor: pointer;
    position: absolute;
    top: 40%;
    width: auto;
    padding: 16px;
    margin-top: -50px;
    color: white;
    font-weight: bold;
    font-size: 20px;
    border-radius: 0 3px 3px 0;
    user-select: none;
    -webkit-user-select: none;
  }
  .next {
    right: 0;
    border-radius: 3px 0 0 3px;
  }
  .prev:hover,
  .next:hover {
    background-color: rgba(0, 0, 0, 0.8);
  }
  .numbertext {
    color: white;
    font-weight: 900;
    background: #ef962d;
    font-size: 12px;
    line-height: 18px;
    padding: 2px 12px;
    position: absolute;
    top: 0;
  }
  .caption-container {
    text-align: center;
    background-color: #ef962d;
    padding: 15px 16px;
    color: white;
    font-weight:bold;
  }
  .row:after {
    content: "";
    display: table;
    clear: both;
  }
  .column {
    float: left;
    width: 92px;
  }
  .demo {
    opacity: 0.6;
  }
  .active,
  .demo:hover {
    opacity: 1;
  }
  .fade {
    -webkit-animation-name: fade;
    -webkit-animation-duration: 1.5s;
    animation-name: fade;
    animation-duration: 1.5s;
  }
  @-webkit-keyframes fade {
    from {opacity: .4}
    to {opacity: 1}
  }
  @keyframes fade {
    from {opacity: .4}
    to {opacity: 1}
  }
  @media only screen and (max-width: 300px) {
    .text {font-size: 11px}
  }
  #slideshow{
    float: right;
    margin: 1px -13px 0 0;
    font-size: 13px;
  }
  .tables_section{
  	font-family: 'Poor Story', cursive;
  	width:920px;
  	margin: 0 auto;
  }
  .tables_section h2{
  	font-family: 'Poor Story', cursive;
  }
  .tables_section table{
  	width: 100%;
  	border-top: 3px solid #ef962d;
    border-bottom: 3px solid #ef962d;
    text-align:center;
    border-collapse:collapse;
  }
  .tables_section table th{
      line-height: 30px;
  }
  .tables_section table th:nth-child(2){
  	width:650px;
  }
  .tables_section table tbody tr:hover{
  	background:antiquewhite;
  }
  .tables_section table tbody td:nth-child(2){
  	text-align:left;
  	font-weight:bold;
  }
  
  </style>
  <section class="slideshow_section">
    <div class="container">
      <div class="mySlides fade">
        <div class="numbertext">1 / 10</div>
        <img src="${contextPath}/resources/image/slideshow1.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">2 / 10</div>
        <img src="${contextPath}/resources/image/slideshow2.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">3 / 10</div>
        <img src="${contextPath}/resources/image/slideshow3.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">4 / 10</div>
        <img src="${contextPath}/resources/image/slideshow4.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">5 / 10</div>
        <img src="${contextPath}/resources/image/slideshow5.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">6 / 10</div>
        <img src="${contextPath}/resources/image/slideshow6.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">7 / 10</div>
        <img src="${contextPath}/resources/image/slideshow7.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">8 / 10</div>
        <img src="${contextPath}/resources/image/slideshow8.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">9 / 10</div>
        <img src="${contextPath}/resources/image/slideshow9.jpg" style="width:100%; height: 500px;">
      </div>

      <div class="mySlides fade">
        <div class="numbertext">10 / 10</div>
        <img src="${contextPath}/resources/image/slideshow11.jpg" style="width:100%; height: 500px;">
      </div>

      <!-- Next and previous buttons -->
      <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
      <a class="next" onclick="plusSlides(1)">&#10095;</a>

      <div class="caption-container">
        <p id="caption" style="display:inline-block; font-weight: bold; color: antiquewhite;"></p>
        <span id="slideshow">슬라이드쇼
          <i style="height:13px; width:15px; cursor:pointer;" onClick="autoSlides()" class="fas fa-play"></i>
          <i style="height:15px; width:20px; cursor:pointer;" onClick="stopSlides()" class="fas fa-pause-circle"></i>
        </span>
      </div>

      <div class="row">
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow1.jpg" style="width:100%; height:80px" onclick="currentSlide(1)" alt="역사 여행은 그 어떠한 여행보다도 뜻깊은 여행이죠">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow2.jpg" style="width:100%; height:80px" onclick="currentSlide(2)" alt="도심 속에 공존하는 과거로 여행을 떠나봐요">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow3.jpg" style="width:100%; height:80px" onclick="currentSlide(3)" alt="사계절이 뚜렷하다는 것은 계절이 바뀌면 새로운 경치를 즐길 수 있다는 뜻이죠">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow4.jpg" style="width:100%; height:80px" onclick="currentSlide(4)" alt="아름다운 야경을 찾아 떠나세요">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow5.jpg" style="width:100%; height:80px" onclick="currentSlide(5)" alt="눈이 쉴 수 있도록 자연을 찾아서 떠나봐요">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow6.jpg" style="width:100%; height:80px" onclick="currentSlide(6)" alt="우리나라의 불교문화를 체험하러 가요">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow7.jpg" style="width:100%; height:80px" onclick="currentSlide(7)" alt="정자에 앉아서 바라보는 자연은 그 무엇보다도 아름답죠">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow8.jpg" style="width:100%; height:80px" onclick="currentSlide(8)" alt="눈에 덮힌 제주도는 정말로 신비롭고 아름답죠">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow9.jpg" style="width:100%; height:80px" onclick="currentSlide(9)" alt="여름에 떠나는 바다여행은 더위도 잊게 만들어요">
        </div>
        <div class="column">
          <img class="demo cursor" src="${contextPath}/resources/image/slideshow11.jpg" style="width:100%; height:80px" onclick="currentSlide(10)" alt="계절별로 다양한 축제들이 열려요">
        </div>
      </div>
    </div>
  </section>
  <section class="tables_section">
  <h2>공지사항</h2>
  	<table class="annoucements_table">
  		<thead>
  			<tr>
  				<th></th>
  				<th>제목</th>
  				<th>작성자</th>
  				<th>작성일자</th>
  			</tr>
  		</thead>
  		<tbody>
  		<c:forEach var="list" items="${announcements }">
  			<tr>
				<td>${list.articleId }</td>
				<td><a href="${contextPath}/member/articleDetail.do?boardId=${list.boardId}&articleId=${list.articleId}">${list.articleTitle }</a></td>
				<td>${list.nickName }</td>
				<td><fmt:formatDate value="${list.articleDate }" pattern="yyyy.MM.dd"/></td>
  			</tr>
  		</c:forEach>
  		</tbody>
  	</table>
  </section>
  <script type="text/javascript">
  var slideIndex = 1;
  var autoSlideIndex = 0;
  var check = true;
  var stop = false;
  showSlides(slideIndex);

  function plusSlides(n) {
    if (!check){
      alert('자동 슬라이드쇼 진행중입니다! 멈추기를 먼저 실행해주세요!');
      return;
    }else if (check) {
      var num = document.getElementsByClassName("active")[0].src.split(".")[0].split("slideshow")[1];
      showSlides(slideIndex = Number(num)+n);
    }
  }

  function currentSlide(n) {
    showSlides(slideIndex = n);
  }

  function showSlides(n) {
      var slides = document.getElementsByClassName("mySlides");
      var dots = document.getElementsByClassName("demo");
      var captionText = document.getElementById("caption");
      if (n > slides.length) {slideIndex = 1;}
      if (n < 1) {slideIndex = slides.length}
      for (var i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
      }
      for (var i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
      }
      slides[slideIndex-1].style.display = "block";
      dots[slideIndex-1].className += " active";
      captionText.innerHTML = '<i class="fas fa-quote-left" style="width: 10px; color:black;"></i><span style="margin: 0 10px;">'+dots[slideIndex-1].alt+'</span><i class="fas fa-quote-right" style="width: 10px; color:black;"></i>';
  }
  function stopSlides(){
    check = true;
    stop = true;
    document.getElementById("slideshow").lastElementChild.firstElementChild.style.color="green";
  }

  function autoSlides() {
    if (stop == true){
      stop = false;
      document.getElementById("slideshow").firstElementChild.firstElementChild.style.color='white';
      document.getElementById("slideshow").lastElementChild.firstElementChild.style.color="green";
      return;
    }else{
      check = false;
    }
    if (!check){
      document.getElementById("slideshow").firstElementChild.firstElementChild.style.color='red';
      document.getElementById("slideshow").lastElementChild.firstElementChild.style.color="white";
      var slides = document.getElementsByClassName("mySlides");
      var dots = document.getElementsByClassName("demo");
      var captionText = document.getElementById("caption");
      for (var i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
      }
      autoSlideIndex++;
      if (autoSlideIndex > slides.length) {autoSlideIndex = 1}
      for (var i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
      }
      slides[autoSlideIndex-1].style.display = "block";
      dots[autoSlideIndex-1].className += " active";
      captionText.innerHTML = dots[autoSlideIndex-1].alt;
      setTimeout(autoSlides, 3000); 
    }
  }
  </script>