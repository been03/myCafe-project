<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<style>
	@import
		url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	.event_write_section {
		width: 920px;
		margin: 30px auto;
	}
	
	.event_write_section h2 {
		font-size: 30px;
		margin-bottom: 0;
	}
	
	.new_event_form {
		width: 870px;
		margin: 0 auto;
		min-height: 500px;
	}
	
	.new_event_form input, .new_event_form select, .new_event_form textarea
		{
		font-family: 'Poor Story', cursive !important;
	}
	
	.new_event_form label {
		margin: 10px 0px 10px 12px;
		font-weight: 600;
		font-size: 18px;
	}
	
	.new_event_form label:nth-child(2) {
		display: inline-block;
		position: relative;
		top: -130px;
	}
	
	.new_event_form input[type=text], .new_event_form textarea,
		.new_event_form input[type=url] {
		width: 790px;
		margin: 15px 0px 0 33px;
		line-height: 30px;
	}
	
	.new_event_form textarea {
		height: 250px;
		resize: none;
	    width: 790px;
    	margin-left: 28px;
	}
	
	.new_event_form select[name=eventRegion], .new_event_form select[name=eventStatus] {
		width: 200px;
		margin: 20px 50px 20px 15px;
		padding-bottom: 5px;
		text-align-last: center;
		text-align: center;
		-ms-text-align-last: center;
		-moz-text-align-last: center;
		height: 30px;
	}
	
	.new_event_form select[name=eventRegion] {
		margin-right: 225px;
	}
	
	.new_event_form input[type=date] {
		margin: 0px 298px 10px 18px;
	}
	
	.new_event_form input[name=eventStartDate] {
		margin: 15px 120px 0 18px;
	}
	
	.new_event_form input[type=submit] {
		float: right;
		padding: 10px 20px;
		border-style: none;
		border: 1px solid #ef962d;
		background-color: #ef962dbd;
		font-weight: 900;
	}
	
	.new_event_form input[type=button] {
		border: 1px solid #ef962d;
		background: #ef962dbd;
		padding: 5px 10px;
		font-weight: bold;
	}
	
	.new_event_form div.file_div {
		margin: 10px 0 0 12px;
		display: inline-block;
		width: 785px;
		vertical-align: middle;
	}
	
	.new_event_form input[type=file] {
		margin: 0 0 15px;
	}
	
	.preview_file_p {
		display: inline-block;
		font-size: 13px;
		font-weight: bold;
		padding: 10px;
	}
</style>
<section class="event_write_section">
	<h2>이벤트 관리</h2>
	<form name="new_event_form" class="new_event_form"
		action="registerEvent.do" method="post" enctype="multipart/form-data">
		<label for="eventName">이름<input id="eventName" type="text"
			name="eventName" value="${event.eventName }"
			placeholder="이벤트/행사 이름을 작성해주세요. 최대 20자까지 입력할 수 있습니다." maxLength="20"
			required /></label> <label for="eventDescription">설명</label>
		<textarea id="eventDescription" name="eventDescription"
			placeHolder="간단한 이벤트/행사 설명을 작성해주세요. 최대 200자까지 입력할 수 있습니다."
			maxLength="200" required>${event.eventDescription }</textarea>
		<label for="eventPlace">장소<input id="eventPlace" type="text"
			name="eventPlace" value="${event.eventPlace }"
			placeholder="이벤트/행사  장소를 작성해주세요" required /></label> <label for="eventSite">URL<input
			id="eventSite" type="url" pattern="https?://.+" name="eventSite"
			value="${event.eventSite }"
			placeholder="https://www.google.com 이 형식을 지켜주세요" required /></label> <label
			for="eventStatus">행사 상태</label> <select id="eventStatus"
			name="eventStatus">
			<option value="행사중" selected>행사중</option>
			<option value="취소"
				<c:out value="${event.eventStatus == '취소'? 'selected' : '' }"/>>취소</option>
			<option value="연기"
				<c:out value="${event.eventStatus == '연기'? 'selected' : '' }"/>>연기</option>
			<option value="종료"
				<c:out value="${event.eventStatus == '종료'? 'selected' : '' }"/>>종료</option>
		</select> <label for="eventRegion">행사 지역</label> <select id="eventRegion"
			name="eventRegion">
			<option value="서울"
				<c:out value="${event.eventRegion == '서울'? 'selected' : '' }"/>>서울</option>
			<option value="경기도"
				<c:out value="${event.eventRegion == '경기도'? 'selected' : '' }"/>>경기도</option>
			<option value="강원도"
				<c:out value="${event.eventRegion == '강원도'? 'selected' : '' }"/>>강원도</option>
			<option value="경상북도"
				<c:out value="${event.eventRegion == '경상북도'? 'selected' : '' }"/>>경상북도</option>
			<option value="경상남도"
				<c:out value="${event.eventRegion == '경상남도'? 'selected' : '' }"/>>경상남도</option>
			<option value="전라북도"
				<c:out value="${event.eventRegion == '전라북도'? 'selected' : '' }"/>>전라북도</option>
			<option value="전라남도"
				<c:out value="${event.eventRegion == '전라남도'? 'selected' : '' }"/>>전라남도</option>
			<option value="충청북도"
				<c:out value="${event.eventRegion == '충청북도'? 'selected' : '' }"/>>충청북도</option>
			<option value="충청남도"
				<c:out value="${event.eventRegion == '충청남도'? 'selected' : '' }"/>>충청남도</option>
			<option value="제주도"
				<c:out value="${event.eventRegion == '제주도'? 'selected' : '' }"/>>제주도</option>
		</select> <input type="button" value="사진 등록" onClick="addFile()" />
		<div id="file_div" class="file_div">
			<c:if test="${not empty event && event.eventImage != 'NONE_IMAGE' }">
				<c:forEach items="${imageList }" var="list" varStatus="status">
					<input type="file" class="event_image"
						onchange="readURL(this, ${status.index})"
						name="event_image${status.index }">
				</c:forEach>
			</c:if>
		</div>
		<p class="preview_file_p">미리보기</p>
		<div id="preview_file_div" class="file_div">
			<c:if test="${not empty event && event.eventImage != 'NONE_IMAGE'  }">
				<c:forEach items="${imageList }" var="list" varStatus="status">
					<img class="preview_image" id="preview${status.index }"
						src="${contextPath }/resources/upload/event_image/${list}"
						style="width: 100px; height: 100px;">
					<i style='margin-left: -17px; color: red; position: absolute'
						class='fas fa-times' onClick='deleteImage(this, ${status.index})'></i>
					<input type="hidden" class="ori_event_image"
						name="ori_event_image${status.index }" value="${list}">
				</c:forEach>
			</c:if>
		</div>
		<label for="eventStartDate">시작일</label> <input id="eventStartDate"
			type="date" name="eventStartDate"
			value='<fmt:formatDate value="${event.eventStartDate }" pattern="yyyy-MM-dd" />'
			required onchange="inputDateComparison()"/> <label for="eventEndDate">마지막일</label> <input type="date"
			name="eventEndDate"
			value='<fmt:formatDate value="${event.eventEndDate }" pattern="yyyy-MM-dd" />'
			onchange="inputDateComparison()" required /> <input type="hidden"
			name="eventId" value="${event.eventId }">
		<c:choose>
			<c:when test="${empty event }">
				<input type="hidden" name="modify" value="false">
				<input type="submit" name="event_add_btn" value="이벤트/행사 등록하기" />
			</c:when>
			<c:otherwise>
				<input type="hidden" name="modify" value="true">
				<input type="submit" name="event_modify_btn" value="이벤트/행사 수정하기" />
			</c:otherwise>
		</c:choose>
	</form>
</section>
<script>
		function addFile(){
			var num = 0;
			if (document.getElementsByClassName("event_image").length > 0){
				num = document.getElementsByClassName("event_image").length;
			}
			if (num == 0){
				$("#file_div").append('<input  type="file" class="event_image main" name="event_image" onchange="readURL(this, '+num+')" />');
				$("#preview_file_div").append('<img id="preview'+num+'" width="100px;" height="100px;">');
				$("#preview_file_div").append("<i style='margin-left:-17px; color:red; position:absolute' class='fas fa-times' onClick='deleteImage(this, ${status.index})'></i>");
			}else if (num <3){
				$("#file_div").append('<input  type="file" class="event_image" name="event_image'+num+'" onchange="readURL(this, '+num+')" />');
				$("#preview_file_div").append('<img class="preview_image" id="preview'+num+'" width="100px;" height="100px;">');
				$("#preview_file_div").append("<i style='margin-left:-17px; color:red; position:absolute' class='fas fa-times' onClick='deleteImage(this, ${status.index})'></i>");
			}else{
				alert("파일은 최대 3개까지 첨부할 수 있습니다!");
			}
		}
		
		function readURL(input, preview) {
		   	if (input.files && input.files[0]) {
		    	var reader = new FileReader();
		       	reader.onload = function (e) {
		        	$('#preview'+preview).attr('src', e.target.result);
		       }
		       reader.readAsDataURL(input.files[0]);
		   	}
		}
		function deleteImage(icon, id){
			if (confirm("정말로 삭제하시겠습니까?")){
				var changed_id = icon.previousElementSibling.id.substring(7);
				console.log(changed_id);
				document.getElementById("preview"+changed_id).remove();
				document.getElementsByName("event_image"+changed_id)[0].remove();
				var ori_image = document.getElementsByName("ori_event_image"+changed_id);
				console.log(ori_image[0].value);
				var length = document.getElementsByClassName("del_event_image").length;
				ori_image[0].setAttribute("class", "del_event_image");
				ori_image[0].setAttribute("name", "del_event_image"+length);
				
				icon.remove();
				
				for (var i=0; i<document.getElementsByClassName("event_image").length; i++){
					var file = document.getElementsByClassName("event_image")[i];
					file.setAttribute("name", "event_image"+i);
					file.setAttribute("onchange", "readURL(this, "+i+")");
					var image = document.getElementsByClassName("preview_image")[i];
					image.setAttribute("id", "preview"+i);
					var ori_image = document.getElementsByClassName("ori_event_image")[i];
					ori_image.setAttribute("name", "ori_event_image"+i);
				}
			}
		}
		
		   function inputDateComparison() {
		        var eventStartDate = inputDateSplit(document.getElementsByName("eventStartDate")[0].value);    
		        var eventEndDate = inputDateSplit(document.getElementsByName("eventEndDate")[0].value); 
		        
		        if (document.getElementsByName("eventStartDate")[0].value == ""){
		        	alert("시작일을 먼저 선택해주세요!!");
		        	document.getElementsByName("eventStartDate")[0].focus();
		        	return false;
		        }
		        if (document.getElementsByName("eventStartDate")[0].value != "" && document.getElementsByName("eventEndDate")[0].value != ""){
			        if(eventStartDate > eventEndDate){
			        	alert("시작일이 종료일보다 이후 일 수 없습니다!");
			        	document.getElementsByName("eventStartDate")[0].value = document.getElementsByName("eventEndDate")[0].value;
			        	document.getElementsByName("eventStartDate")[0].focus();
			        	return false;
			        }
		        }
		    }

		    // 날짜형식에 "-"이 사용된 경우에 한하여 날짜값에서 "-" 기호를 제거한다.
		    function inputDateSplit(obj) {
		        var dateArray = obj.split("-");
		        return dateArray[0] + dateArray[1] + dateArray[2];
		    }
	</script>
