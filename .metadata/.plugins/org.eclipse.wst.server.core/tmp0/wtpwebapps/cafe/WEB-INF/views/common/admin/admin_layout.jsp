<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myCafe 관리</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://use.fontawesome.com/releases/v5.7.0/js/all.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
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
	.top_section{
        width: 1200px;
    	margin: 0 auto;
    	padding: 0 0 10px;
	}
	.banner_div{
		width: 1200px;
	    margin: 0 auto;
	    height: 70px;
	    line-height: 70px;
	}
	.top_section h1 {
	    text-align: left;
	    line-height: 57px;
	    font-family: 'Pacifico', cursive !important;
	    font-size: 45px;
	    font-weight: 900;
	    color: #ef962d;
	    cursor: pointer;
	}
	.top_section .sub_title_span{
		font-size: 30px;
    	color: black;
    	margin-left: 10px;
    	font-family: 'Poor Story', cursive !important;
    	cursor: pointer;
	}
	.main_div{
		width: 1200px;
	    margin: 0 auto;
	    min-height: 1200px;
	    overflow: hidden;
	    border-top: 1px solid #ef962d;
	}
	aside{
        width: 250px;
	    text-align: center;
	    margin: 0;
	    display: inline-block !important;
	    left: 160px;
	    font-size: 13px;
	    font-family: 'Poor Story', cursive !important;
	    min-height: 1000px;
	}
	aside+div{
	    width: 949px;
	    margin: 0;
	    display: inline-block;
	    float: right;
	    font-family: 'Poor Story', cursive !important;
	    border-left: 1px solid #ef962d;
	}
	.ctg_menu_outer_ul{
		margin: 60px 0 30px;
    	font-family: 'Poor Story', cursive !important;
    	font-size: 15px;
	}
	.ctg_menu_outer_li{
	    line-height: 30px;
    	margin-bottom: 50px;
	}
	.ctg_menu_outer_li > span{
        font-weight: bold;
	    color: #ef962d;
	    width: 100%;
	    display: inline-block;
	    font-size: 25px;
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
		<tiles:insertAttribute name="admin_header" />
	</header>
	<div class="main_div">
		<aside>
			<tiles:insertAttribute name="admin_side" />
		</aside>
		<div>
			<tiles:insertAttribute name="admin_body" />
		</div>
	</div>
	<footer>
		<tiles:insertAttribute name="admin_footer" />
	</footer>
</body>
</html>