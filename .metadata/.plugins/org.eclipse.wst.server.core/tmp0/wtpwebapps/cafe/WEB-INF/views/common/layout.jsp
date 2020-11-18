<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myCafe</title>
<!-- google charts -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Stylish&display=swap');
	
	li, ul, div, p, a {
		margin: 0;
		padding: 0;
		list-style-type: none;
		text-decoration:none;
		color:black;
	}
	button, a, input[type=button], input[type=submit]{
		cursor:pointer;
	}
	.banner_div {
		background-image: url(${contextPath}/resources/image/main_banner1.jpg);
		background-size: cover;
		background-repeat: no-repeat;
		background-position-y: -450px;
		height: 400px;
	}
	.header_buttons_div{
		line-height: 40px;
	    font-size: 15px;
	    text-align: right;
	    font-weight: bold;
	    font-family: 'Poor Story', cursive;
	}
	.header_buttons_div input[type=button]{
	    border: none;
	    background: transparent;
	    padding: 0;
	    font-weight: bold;
	    color: #ef962d;
	   	margin: 0 10px;
	}
	.header_buttons_div a{
		color: #ef962d;
		margin: 0 10px;
	}
	.top_section h1 {
		text-align: left;
	    margin: 0;
	    line-height: 40px;
	    font-family: 'Pacifico', cursive !important;
	    font-size: 45px;
	    font-weight: 900;
	    color: #ef962d;
	    position: relative;
	    top: 360px;
	    left: 1057px;
	    width: 144px;
	}
	.top_section {
		width: 1200px;
		height: 491px;
		margin: 0 auto;
		text-align: center;
	}
	.menu_div {
		height: 50px;
		line-height: 50px;
		background-color: antiquewhite;
		border: 1px solid #ef962d;
		font-family: 'Nanum Pen Script', cursive;
	}
	.menu_li {
		float: left;
		margin: 0 20px;
		font-weight: bold;
		font-size:30px;
	}
	.menu_li a{
		color: coral;
	}
	.main_div{
	    width: 1200px;
	    margin: 0 auto;
	    min-height: 1200px;
	    overflow: hidden;
	}
	aside{
	    width: 250px;
	    text-align: center;
	    margin: 0;
	    display: inline-block !important;
	    left: 160px;
	    margin-top: 30px;
	    font-size: 13px;
	}
	aside+div{
		width: 950px;
	    margin: 0;
	    display: inline-block;
	    float: right;
	}
	.cafe_info_wrap{
		border: 1px solid #ef962d;
        height: 335px;
	    font-family: 'Stylish', sans-serif;
	}
	.mem_info_wrap{
	    text-align: center;
	    width: 220px;
	    margin: 0px auto 15px;
	    padding-top: 25px;
	}
	.mem_info_wrap img{
	    width: 60px;
	    height: 60px;
	    border: 1px solid #ef962d;
	    border-radius: 32px;
	    vertical-align: top;
	    margin-left: -15px;
	}
	.mem_info_wrap span{
	    display: inline-block;
	}
	.mem_stat_wrap{
	    text-align: left;
	    margin-top: 25px;
	    width: 200px;
	    margin: 25px auto 0;
	}
	.guest_buttons_wrap{
	    margin-top: 80px;
	}
	.guest_buttons_wrap a{
	    padding: 10px 20px;
    	border: 1px solid #ef962d;
    	font-weight: bold;
	}
	.info_button{
	    border: 1px solid #ef962d;
	    background: #ef962d;
	    padding: 2px 50px;
	    width: 200px;
	    margin: 5px;
	    font-weight: bold;
	    font-size: 20px;
	}
	.side_search_form input{
		font-family: 'Poor Story', cursive;
	}
	.side_search_form input[type=text]{
	    padding: 0 5px;
	    line-height: 30px; 
	    width: 205px;
        border: 2px solid #ef962d;
	}
	.side_search_form input[type=submit]{
		height: 34px;
	    border: 1px solid #ef962d;
	    background: #ef962d;
	    font-weight: bold;
	    width: 40px;
	    padding-bottom:2px;
	    margin-left: -5px;
	}
	.ctg_menu_outer_ul{
		margin:15px 0 30px;
	   	font-family: 'Stylish', sans-serif;
	   	font-size:15px;
	}
	.ctg_menu_outer_li{
	    line-height: 40px;
	    border-top: 3px solid #ef962d;
	}
	.ctg_menu_outer_li > span{
	    font-weight: bold;
	    color: #ef962d;
	    width: 100%;
	    display: inline-block;
	}
	.ctg_menu_inner_ul {
		border-top: 1px solid #ef962d;
	}
	.ctg_menu_inner_li{
	    border-bottom: 1px solid #ef962d2e;
	}
	.ctg_menu_inner_li:hover{
		background:antiquewhite;
	}
	.recent_article_wrap{
	    margin-top: 200px;
		margin-bottom: 30px;
		font-family: 'Poor Story', cursive !important;
		text-align: right;
		border: 1px dotted #ef962d;
	}
	.recent_article_wrap > p{
	    text-align: center;
	    line-height: 30px;
	    font-size: 16px;
	    font-weight: bold;
	    color: coral;
	    background: antiquewhite;
	}
	.recent_article_wrap ul.recent_article_ul{
	 	text-align: left;
	}
	.recent_article_wrap li.recent_article_li{
	    height: 30px;
    	padding: 5px;
    	line-height: 30px;
	}
	.recent_article_wrap .recent_article_li a{
		width: 245px;
   		display: inline-block;
	    text-overflow: ellipsis;
	    overflow: hidden;
	    line-height: 30px;
	}
	.recent_article_wrap button{
    	background: #ef962d;
    	border: 1px solid #ef962d;
    	font-weight: bold;
	}
	footer{
		font-family: 'Poor Story', cursive !important;
	    text-align: center;
	    font-size:12px;
	    margin-top: 40px;
	    width: 100%;
	    border-top: 1px solid #ef962d;
	    padding: 30px 0;
	  }
	p.contact{
  	    color: #ef962d;
    	font-weight: bold;
    	font-size: 13px
	}
	address > a{
	  	text-decoration: none;
	  	color:#999;
	  	font-style: normal;
	  	display:inline-block;
	}
	p.copyright{
	  	color:#000;
	  	font-weight: bold;
  	    margin-top: 10px;
	}
</style>
</head>
<body>
	<header class="top_section">
		<tiles:insertAttribute name="header" />
	</header>
	<div class="main_div">
		<aside>
			<tiles:insertAttribute name="side" />
		</aside>
		<div>
			<tiles:insertAttribute name="body" />
		</div>
	</div>
	<footer>
		<tiles:insertAttribute name="footer" />
	</footer>
</body>
</html>