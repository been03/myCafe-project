<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
	.member_level_wrap{
		width:920px;
		margin: 30px auto;
		font-family: 'Poor Story', cursive !important;
	}
	.member_level_wrap div{
	    width: 600px;
   		margin: 50px auto 0;
	}
	.member_level_desc_wrap{
		font-size: 16px;
	}
	.member_level_desc_wrap p{
	    font-size: 18px;
   		font-weight: bold;
   		color: #ef962d;
	}
	.member_level_desc_wrap table{
		width: 100%;
    	border-collapse: collapse;
    	line-height: 35px;
    	margin-bottom: 30px;
	}
	.member_level_desc_wrap table td:nth-child(2){
		font-weight:bold;
		color:#ef962d;
	}
	.member_level_buttons_wrap{
		text-align:center;
	}
	.member_level_buttons_wrap button{
		background: #ef962d;
		border: 1px solid #ef962d;
		font-weight:bold;
	}
</style>
</head>
<body>
	<div class="member_level_wrap" style="width:600px">
		<div class="member_level_desc_wrap">
			<p style="font-size: 18px;"><span style="font-family: 'Pacifico', cursive !important;">myCafe</span> 자동 등업 조건 안내</p>
			<table>
				<c:forEach var="level" items="${level }" varStatus="status">
					<c:if test="${level.levelNo == 2}">
						<tr>
							<td style="width: 20px;"><img width="12px" height="12px" src="${contextPath }/resources/image/level_one.png" ></td>
							<td>${level.levelName}</td>
							<td>가입 후 기본 등급</td>
						</tr>
					</c:if>
					<c:if test="${level.levelNo > 2}">
					<tr>
						<c:if test="${level.levelNo ==3 }">
							<td><img width="12px" height="12px" src="${contextPath }/resources/image/level_two.png" ></td>
						</c:if>
						<c:if test="${level.levelNo ==4 }">
							<td><img width="12px" height="12px" src="${contextPath }/resources/image/level_three.png" ></td>
						</c:if>
						<c:if test="${level.levelNo ==5 }">
							<td><img width="12px" height="12px" src="${contextPath }/resources/image/level_four.png" ></td>
						</c:if>
						<c:if test="${level.levelNo ==6 }">
							<td><img width="12px" height="12px" src="${contextPath }/resources/image/level_five.png" ></td>
						</c:if>
						<td> ${level.levelName }</td>
						<td>자동등업(게시글 수 ${level.articleCnt }, 댓글 수 ${level.commentCnt }, 방문 수 ${level.visitCnt  } 만족 시 자동등업)</td>
					</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
		<div class="member_one_desc_wrap">
			<p style="color:red; font-weight:bold;"> 등급별 등업 조건을 만족 시 자동으로 등업됩니다.</p>
			<hr style="border-top: 1px solid #ef962d;">
			<c:if test="${!member.memberId.equals('guest')}">
				<p><span>내 활동정보</span>&nbsp;총 게시글 ${member.articleCnt }&nbsp;댓글 수 ${member.commentCnt }&nbsp;방문 수 ${member.loginCnt }</p>
			</c:if>
		</div>
		<div class="member_level_buttons_wrap">
			<button onclick="window.close()">닫기</button>
		</div>
	</div>
</body>
</html>