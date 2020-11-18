<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<style>
	@import url('https://fonts.googleapis.com/css2?family=Stylish&display=swap');
	.attendance_section a{
		text-decoration:none;
		color:black;
	}
	.attendance_section{
	    width: 920px;
    	margin: 15px auto 0;
    	min-height: 600px;
    	font-family: 'Stylish', sans-serif !important;
	}
	.attendance_section ul{
		list-style-type: none;
	    margin: 20px 0;
	    padding: 0 0 0 10px;
	    overflow: hidden;
	    width: 920px;
	}
	.attendance_section li{
		float: left;
	    margin-right: 3px;
	    border-radius: 17px;
	    border: 1px solid #FF9800;
	    width: 26px;
	    height: 25px;
	    text-align: center;
	    text-decoration: none;
	    font-size: 15px;
	}
	.attendance_form{
	    margin: 30px auto;
	}
	.attendance_form > a{
	    margin-left: 10px;
    	font-size: 20px;
	}
	.attendance_section li > a{
		text-decoration: none;
    	color: black;
    	font-weight: bold;
	}
	.attendance_section h2{
		display: inline;
	    margin-left: 10px;
	    font-family: 'Stylish', sans-serif !important;
        font-weight: bold;
	}
	.attendance_section textarea{
        resize: none;
	    width: 900px;
	    padding: 15px;
	    margin: 0 0 0 10px;
	    display: inline-block;
	    height: 94px;
	    font-size: 18px;
	    font-weight: 600;
	}
	.attendance_section input[type=submit]{
		display: inline-block;
	    padding: 7px 25px 10px;
	    position: absolute;
	    margin: 57px 0 0 -108px;
	    height: 37px;
	    border: 1px solid #FF9800;
	    background-color: #FF9800;
	    font-weight: bold;
	    color: black;
	    font-size: 18px;
	}
	.attendance_div{
        padding: 12px 15px;
    	border-top: 1px solid #ffa50030;
    	font-size: 16px;
	}
	.attendance_div:last-child{
		border-bottom: 1px solid #ffa50030;
	}
	.profile_image{
        width: 30px;
    	height: 30px;
    	border: 1px solid black;
    	border-radius: 15px;
    	vertical-align: middle;
	}
	.profile_image + span{
	    margin-right: 40px;
    	font-size: 15px;
    	font-weight: bold;
	}
	.icon_span{
	    color: gold;
    	border-radius: 10px;
   		border: 1px solid gold;
	    padding: 1px 3px;
	    font-weight: bold;
        font-size: 15px;
	}
	.attendance_div span:nth-child(4){
	    word-break: break-word;
   	    width: 500px;
    	display: inline-block;
   	    vertical-align: top;
	}
</style>
	<section class="attendance_section">
		<form name="attendance_form" class="attendance_form" action="insertAttendance.do">
			<c:choose>
				<c:when test="${not empty next_month }">
				<a href="articleAttendance.do?month=${prev_month }">이전</a>
					<c:if test="${month > cur_month  }">
						<h2>${cur_year }년${next_month-1 }월</h2>
					</c:if>
					<c:if test="${month < cur_month }">
						<h2>${cur_year }년${prev_month+1 }월</h2>
					</c:if>
					<c:if test="${month == cur_month }">
						<h2>${cur_year }년${cur_month }월</h2>
					</c:if>
				<a href="articleAttendance.do?month=${next_month }">다음</a>
				</c:when>
				<c:otherwise>
					<a href="articleAttendance.do?month=${cur_month-1 }">이전</a>
					<h2>${cur_year }년${cur_month }월</h2>
					<a href="articleAttendance.do?month=${cur_month+1 }">다음</a>
				</c:otherwise>
			</c:choose>
			<ul>
				<c:forEach begin="1" end="${dayLength}" var="num" >
					<c:choose>
						<c:when test="${selected_date == num}">
							<li style="background-color:#FF9800;">
								<c:if test="${cur_month == month }">
									<a href="articleAttendance.do?day=${num }&month=${cur_month}" >${num}</a>
								</c:if>
								<c:if test="${cur_month != month }">
									<a href="articleAttendance.do?day=${num }&month=${month}" >${num}</a>
								</c:if>
							</li>
						</c:when>
						<c:when test="${(month > cur_month) || (today<num && month == cur_month)}">
							<li>
								<a href="javascript:void(0)">${num }</a>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<c:if test="${cur_month == month }">
									<a href="articleAttendance.do?day=${num }&month=${cur_month}" >${num}</a>
								</c:if>
								<c:if test="${cur_month != month }">
									<a href="articleAttendance.do?day=${num }&month=${month}" >${num}</a>
								</c:if>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul><br>
			<input type="hidden" name="cur_month" value="${cur_month }">
			<input type="hidden" name="cur_year" value="${cur_year }">
			<input type="hidden" name="today" value="${today }">
			<input type="hidden" name="nickName" value="${member.nickName }">
			<c:if test="${(today == selected_date && cur_month == month && member.memberLevel >= 2) || (today == selected_date && cur_month == month && member.role == 'ADMIN') }">
				<textarea placeholder="글을 입력해 주세요" name="content" title="출석내용" maxLength="300"></textarea>
				<input type="submit" value="출석하기">
			</c:if>
		</form>
		<div>
			<c:forEach items="${attendanceList }" var="list" varStatus="status">
				<div class="attendance_div">
					<c:if test="${list.imageId.equals('basic') }">
						<img class="profile_image" src="${contextPath }/resources/upload/photo_profile/profile_basic.png">
					</c:if>
					<c:if test="${list.imageId.equals('admin') }">
						<img class="profile_image" src="${contextPath }/resources/upload/photo_profile/profile_admin.png">
					</c:if>
					<c:if test="${ !list.imageId.equals('basic') && !list.imageId.equals('admin')}">
						<img class="profile_image" src="${contextPath }/resources/upload/photo_profile/${list.memberId}/${list.imageId}">
					</c:if>
					<span>${list.nickName }</span>
					<c:choose>
						<c:when test="${status.index+1 == fn:length(attendanceList)-2 }">
							<span class="icon_span" style="color: saddlebrown; border: 1px solid saddlebrown;"><i class="fas fa-crown"></i>3등</span>
						</c:when>
						<c:when test="${status.index+1 == fn:length(attendanceList)-1 }">
							<span class="icon_span" style="color: silver; border: 1px solid silver;"><i class="fas fa-crown"></i>2등</span>
						</c:when>
						<c:when test="${status.index+1 == fn:length(attendanceList) }">
							<span class="icon_span"><i class="fas fa-crown"></i>1등</span>
						</c:when>
					</c:choose>
					<span>${list.content } <span style="font-size: 13px; color:#666666; font-weight:bold; margin-left:10px;"><fmt:formatDate value="${list.attendanceDate}" pattern="yyyy년  M월 d일  HH:mm:ss" /></span></span>
				</div>
			</c:forEach>
		</div>
	</section>
