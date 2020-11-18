<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />    
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
		@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
		.member_level_wrap{
			width:920px;
			margin: 30px auto;
			font-family: 'Poor Story', cursive !important;
		}
		.member_level_wrap div{
	        width: 850px;
    		margin: 50px 0 0 70px;
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
	<div class="member_level_wrap">
		<div class="member_level_info_wrap">
			<c:if test="${not empty readLevelName }">
				<p style="font-size:30px;"><span style="color:#ef962d; font-weight:bold;">${readLevelName }</span> 등급 이상이면 읽기가 가능한 ${boardInfo.boardName } 게시판 입니다.</p>
			</c:if>
			<c:if test="${empty readLevelName }">
				<p style="font-size:30px;"><span style="color:#ef962d; font-weight:bold;">새싹멤버</span> 등급 이상이면 읽기가 가능한 ${boardInfo.boardName } 게시판 입니다.</p>
			</c:if>
			<c:if test="${not empty readLevelName && not empty writeLevelName && (readLevelName != writeLevelName) && writeLevelName != 'none'}">
				<p style="font-size:30px;"><span style="color:#ef962d; font-weight:bold;">${writeLevelName }</span> 등급 이상이면 쓰기가 가능한 ${boardInfo.boardName } 게시판 입니다.</p>
			</c:if>
			<c:if test="${empty readLevelName && empty writeLevelName && boardInfo.boardId != 4 }">
				<p style="font-size:30px;"><span style="color:#ef962d; font-weight:bold;">관리자</span>만이 쓰기가 가능한 ${boardInfo.boardName } 게시판 입니다.</p>
			</c:if>
			<c:if test="${empty readLevelName && empty writeLevelName && boardInfo.boardId == 4 }">
				<p style="font-size:30px;"><span style="color:#ef962d; font-weight:bold;">새싹멤버</span> 등급 이상이면 쓰기가 가능한 ${boardInfo.boardName } 게시판 입니다.</p>
			</c:if>
			<c:if test="${member.nickName.equals('guest') }">
				<p style="font-size: 18px; margin-top:10px;">현재 <span style="font-weight:bold;">${member.nickName }님</span>은 <span style="font-weight:bold; color:coral;">${member.levelName }</span>입니다. 가입 후 이용해 주세요</p>
			</c:if>
			<c:if test="${!member.nickName.equals('guest') }">
				<p style="font-size: 18px; margin-top:10px;">현재 <span style="font-weight:bold;">${member.nickName }님</span>은 <span style="font-weight:bold; color:coral;">${member.levelName }</span>등급이시며, 등업에 관련된 궁금하신 사항은 관리자에게 문의해 주세요.</p>
			</c:if>
		</div>
		<div class="member_level_desc_wrap">
			<p style="font-size: 18px;"><span style="font-family: 'Pacifico', cursive !important;">myCafe</span> 자동 등업 조건 안내</p>
			<table>
				<c:forEach var="level" items="${level }" varStatus="status">
					<c:if test="${level.levelNo == 1}">
						<tr>
							<td style="width: 20px;"></td>
							<td>${level.levelName}</td>
							<td>익명의 사용자 (비회원 상태입니다)</td>
						</tr>
					</c:if>
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
			<c:if test="${member.memberId.equals('guest')}">
				<button onclick="location.href='${contextPath}/member/memberJoinForm.do'">회원가입 하러가기</button>
				<button onclick="location.href='${contextPath}/member/loginForm.do'">로그인 하러가기</button>
				<c:if test="${boardInfo.boardId > 4 }">
					<button onClick="location.href='${contextPath }/member/boardMain.do?boardId=${boardId }'">이전으로</button>
				</c:if>
				<c:if test="${boardInfo.boardId <= 4 }">
					<button onClick="location.href='${contextPath }/'">메인으로</button>
				</c:if>
			</c:if>
		</div>
	</div>
