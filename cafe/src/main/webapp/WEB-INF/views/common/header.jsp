<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<body>
	<div class="header_buttons_div">
		<c:if test="${member == null || member.role == 'GUEST' }">
			<input type="button" value="회원가입"
			onclick="location.href='${contextPath}/member/memberJoinForm.do'">
			<input type="button" value="로그인"
				onclick="location.href='${contextPath}/member/loginForm.do'">
			<a href='javascript:void(0);' onclick="window.open('${contextPath}/member/findIdForm.do','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=400, height=300, left=500, top=200, scrollbars=yes');return false">아이디찾기</a>
			<a href='javascript:void(0);' onclick="window.open('${contextPath}/member/findPwForm.do','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=400, height=350, left=500, top=200, scrollbars=yes');return false">비밀번호찾기</a>
		</c:if>
		<c:choose>
			<c:when test="${member != null and member.role != 'ADMIN' and member.role != 'GUEST' }">
				<input type="button" onclick="location.href='${contextPath}/member/myPageMain.do?memberId=${member.memberId}'" value="${member.memberId } 님 마이페이지">
				<input type="button" value="로그아웃" onclick="location.href='${contextPath}/member/logout.do'">
			</c:when>
		</c:choose>
		<c:if test="${member.role.equals('ADMIN') }">
			<input type="button"  value="카페관리" onclick="location.href='${contextPath}/admin/articleManage.do'">
			<input type="button" value="로그아웃" onclick="location.href='${contextPath}/member/logout.do'">
		</c:if>
	</div>
	<div class="banner_div" onClick="location.href='${contextPath}/'">
		<h1>myCafe</h1>
	</div>
	<div class="menu_div">
		<ul class="menu_ul">
			<li class="menu_li"><a href="${contextPath}/member/boardMain.do?boardId=1">공지</a></li>
			<li class="menu_li"><a href="${contextPath}/member/boardMain.do?boardId=2">베스트글보기</a></li>
			<li class="menu_li"><a href="${contextPath}/member/boardMain.do?boardId=4">출석</a></li>
			<li class="menu_li"><a href="${contextPath}/member/boardMain.do?boardId=3">캘린더</a></li>
		</ul>
	</div>
</body>
