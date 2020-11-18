<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
    
	<style>
		.menu_section a{
			text-decoration:none;
			color:black;
		}
		.menu_section{
	        width: 920px;
	    	margin: 0 auto;
		}
		.menu_section h2{
			font-size: 30px;
		}
		.menu_section ul{
		    list-style: none;
	    	text-align: center;	
		}
		.default_list_ul li{
			margin: 10px;
			font-weight:bold;
			font-size: 20px;
		}
		.menu_section li.selected{
			margin-bottom:10px;
			font-weight:bold;
			font-size:20px;
		}
		.group_list{
			padding: 5px 10px 0;
			font-weight:500;
			font-size: 16px;
		}
		.group_selected li{
		    line-height: 30px;
		}
		#custom_list button, #admin_list button{
		    border: 1px solid #ef962d;
	    	background: #ef962d;
	    	font-weight: bold;
	    	font-size: 10px;
	    	cursor: pointer;
	    	font-family: 'Poor Story', cursive !important;
		}
		.setup_menus_div{
			display: inline-block;
		    width: 315px;
		    font-size: 16px;
		}
		.setup_menus_div h3{
			font-size: 1.03em;
		}
		.category_form{
		    float: right;
	    	display: inline-block;
	    	width: 580px;
	    	margin-left: 25px;
		}
		.category_form select, .category_form input{
			font-family: 'Poor Story', cursive !important;
		}
		.category_setting{
	    	font-size: 14px;
	    	font-weight: 900;
	    	padding: 20px 0px;
		}
		.category_form label{
		    width: 118px;
	    	display: inline-block;
	    	text-align: center;
		}
		.category_form input[type=text]{
		    width: 420px;
	    	margin-bottom: 25px;
	    	line-height: 25px;
		}
		select[name=ctgReadLevel], select[name=ctgWriteLevel]{
			width: 129px;
	    	text-align: center;
	    	text-align-last: center;
	    	height: 25px;
		}
		.like_check_label{
			margin-top: 30px;
	    	display: block !important;
		}
		input[name=likeAllow]{
		    float: right;
	    	position: absolute;
	    	margin-left: 23px;
		}
		.board_setting_label{
		    display: inline-block !important;
	    	margin: 20px 0 0;
		}
		.board_setting_wrap{
		    display: inline-block;
	    	width: 390px;
	    	vertical-align: middle;
	    	font-weight: normal;
	    	line-height: 20px;
		}
		select[name=boardStatus]{
		    width: 129px;
		    text-align: center;
		    text-align-last: center;
		    height: 25px;
		    margin-bottom: 25px;
		}
		select[name=likeCnt], select[topArticleCnt]{
		    text-align: center;
	    	text-align-last: center;
		}
		.buttons_div{
		    text-align: right;
		    margin-top: 25px;
		}
		.buttons_div input[type=submit], .buttons_div input[type=reset]{
		    padding: 10px 20px;
	    	font-weight: 900;
	    	background: #ef962d;
	    	border: 1px solid #ef962d;
		}
		.buttons_div input[type=reset]{
			margin: 0 40px 0 5px;
		}
		.new_category_div{
			font-size:15px;
			padding:0;
		}
		.new_category_div hr{
			margin: 30px 0;
		}
		.group_select_label{
		    width: 230px !important;
		}
		.ctg_select_label{
			width: auto !important;
	    	margin-right: 20px;
		}
		select[name=category_select]{
		    text-align: center;
	    	text-align-last: center;
	    	width: 155px;
	    	height: 25px;
		}
		.add_category_button{
			margin-bottom: 10px;
	    	background: transparent;
	    	border: none;
	    	font-weight: bold;
	   	    color: #ef962d;
		}
	</style>
	<section id="menu_section" class="menu_section">
		<h2>메뉴 관리</h2>
		<div id="setup_menus" class="setup_menus_div">
			<h3>기존에 존재하는 게시판메뉴에 새로운 게시판을 추가 또는 새로운 게시판메뉴를 생성해서 게시판을 추가하는 것이 가능합니다.</h3>
			<ul id="default_list" class="default_list_ul">
				<li>
					<a href="javascript:alert('기본으로 제공되는 메뉴들은 수정할 수 없습니다');" title="전체글보기">
						<span>공지사항</span>
					</a>
				</li>
				<li>
					<a href="javascript:alert('기본으로 제공되는 메뉴들은 수정할 수 없습니다');" title="베스트 게시글">
						<span>베스트 게시글</span>
					</a>
				</li>
				<li>
					<a href="javascript:alert('기본으로 제공되는 메뉴들은 수정할 수 없습니다');" title="카페 캘린더">
						<span>카페 캘린더</span>
					</a>
				</li>
				<li>
					<a href="javascript:alert('기본으로 제공되는 메뉴들은 수정할 수 없습니다');" title="출석부">
						<span>출석부</span>
					</a>
				</li>
			</ul>
			<hr>
			<ul id="custom_list" >
				<c:forEach var="ctgList" items="${categories }">
					<c:if test="${ctgList.ctgId != 4 }">
						<li id="${ctgList.ctgId }" class="selected">
							<span id="menu_name${ctgList.ctgId }">${ctgList.ctgName }</span>
							<button id="btn${ctgList.ctgId }" onClick="fold(this)">그룹접기</button>
							<ul id="group_list${ctgList.ctgId }" class="group_list">
								<c:forEach var="boardList" items="${boards }" varStatus="status">
									<c:if test="${ctgList.ctgId == boardList.ctgId }">
										<li id="grp${ctgList.ctgId }_${boardList.boardId}" class="group_selected">
											<a href="${contextPath }/admin/categoryManage.do?boardId=${boardList.boardId }&ctgId=${ctgList.ctgId}" title="통합게시판">
												<span id="board_name${boardList.boardId}">${boardList.boardName }</span>
											</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
					</c:if>
				</c:forEach>
			</ul>
			<hr>
			<ul id="admin_list">
				<c:forEach var="ctgList" items="${categories }">
					<c:if test="${ctgList.ctgId == 4 }">
						<li id="${ctgList.ctgId }" class="selected">
							<span id="menu_name${ctgList.ctgId }">${ctgList.ctgName }</span>
							<button id="btn${ctgList.ctgId }" onClick="fold(this)">그룹접기</button>
							<ul id="group_list${ctgList.ctgId }" class="group_list">
								<c:forEach var="boardList" items="${boards }" varStatus="status">
									<c:if test="${ctgList.ctgId == boardList.ctgId }">
										<li id="grp${ctgList.ctgId }_${boardList.boardId}" class="group_selected">
											<a href="javascript:alert('비활성화된 게시판은 수정 및 활성화 상태로 변경할 수 없습니다!');" title="통합게시판">
												<span id="board_name${boardList.boardId}">${boardList.boardName }</span>
											</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<form id="category_form" name="category_form" class="category_form" method="post" onsubmit="return false;"> 
			<div id="newCategory" class="new_category_div" style='<c:out value="${not empty ctg ? 'display:none;' : 'display:block;' }"/>' >
				<p>게시판 형식 선택하기</p>
				<label><input type="radio" name="menu_format" value="통합게시판" checked>통합게시판</label>
				<label><input type="radio" name="menu_format" value="앨범형게시판" >앨범형게시판</label>
				<hr>
				<p>그룹 선택하기</p>
				<label class="group_select_label"><input type="radio" name="group_select" value="existing_group">존재하는 그룹에 추가하기</label>
				<label class="group_select_label"><input type="radio" name="group_select" value="new_group" checked>새로운 그룹 추가하기</label>
				<hr>
				<label for="category" id="category_select_label" class="ctg_select_label" >그룹 리스트</label>
				<select id="category" name="category_select" disabled>
					<c:forEach items="${categories }" var="list">
						<c:if test="${list.ctgId != 4 }">
							<option value="${list.ctgId }">${list.ctgName }</option>
						</c:if>
					</c:forEach>
				</select>
				<hr>
				<button id="add_category_button" class="add_category_button" onClick="addCategory()">게시판 선택하기</button>
			</div>
			<div id="category_setting" class="category_setting" style='<c:out value="${not empty ctg ? 'display:block;' : 'display:none;' }"/>' >
				<label for="ctgName">메뉴 이름</label>
				<input id="ctgName" type="text" name="ctgName" value="${ctg.ctgName }" <c:out value="${ctg.ctgName !=null ? 'disabled' : '' }"/> placeholder="게시판 메뉴 이름을 작성해주세요." maxLength="100" onkeyup="reflectChange1()">
				<input type="hidden" name="ctgId" value="${not empty ctg ? ctg.ctgId : '' }">
				<input type="hidden" name="boardId" value="${not empty board ? board.boardId : '' }">
				<label for="boardName">게시판 이름</label>
				<c:if test="${not empty board.boardName }">
					<input id="boardName" disabled type="text" name="boardName" value="${board.boardName }" placeholder="게시판 이름을 작성해주세요." maxLength="100" onkeyup="reflectChange2()">
				</c:if>
				<c:if test="${empty board.boardName }">
					<input id="boardName" type="text" name="boardName" value="${board.boardName }" placeholder="게시판 이름을 작성해주세요." maxLength="100" onkeyup="reflectChange2()">
				</c:if>
				<label for="boardDescription">게시판 설명</label>
				<input id="boardDescription" type="text" name="boardDescription" value="${board.boardDescription }" placeholder="게시판 설명을 작성해주세요." maxLength="100">
				<label for="boardStatus">게시판 활성화 상태</label>
				<c:choose>
					<c:when test="${board.boardId > 6 }">
						<select id="boardStatus" name="boardStatus">
							<option value="active" <c:out value="${ctg.ctgId != 4 ? 'selected' : '' }" /> >활성화</option>
							<option value="inactive" <c:out value="${ctg.ctgId == 4 ? 'selected' : '' }" /> >비활성화</option>
						</select>
					</c:when>
					<c:when test="${board.boardId <= 6 && ctg.ctgId <=2 }">
						<select id="boardStatus" name="boardStatus" disabled>
							<option value="active" selected>활성화</option>
							<option value="inactive">비활성화</option>
						</select>
					</c:when>
					<c:otherwise>
						<select id="boardStatus" name="boardStatus">
							<option value="active" selected>활성화</option>
							<option value="inactive">비활성화</option>
						</select>
					</c:otherwise>
				</c:choose>
				<br>
				<label for="ctgReadLevel">읽기권한</label>
				<select id="ctgReadLevel" name="ctgReadLevel">
					<option value="1" <c:out value="${ctg.ctgReadLevel == 1 ? 'selected' : '' }"/>>익명의 사용자</option>
					<option value="2" <c:out value="${ctg.ctgReadLevel == 2 ? 'selected' : '' }"/>>새싹멤버</option>
					<option value="3" <c:out value="${ctg.ctgReadLevel == 3 ? 'selected' : '' }"/>>일반멤버</option>
					<option value="4" <c:out value="${ctg.ctgReadLevel == 4 ? 'selected' : '' }"/>>성실멤버</option>
					<option value="5" <c:out value="${ctg.ctgReadLevel == 5 ? 'selected' : '' }"/>>열심멤버</option>
					<option value="6" <c:out value="${ctg.ctgReadLevel == 6 ? 'selected' : '' }"/>>우수멤버</option>
					<option value="0" <c:out value="${ctg.ctgReadLevel == 0 ? 'selected' : '' }"/>>관리자</option>
				</select>
				<label for="ctgWriteLevel">쓰기권한</label>
				<c:if test="${board.boardId == 5 }">
					<select id="ctgWriteLevel" name="ctgWriteLevel" disabled>
				</c:if>
				<c:if test="${board.boardId != 5 }">
					<select id="ctgWriteLevel" name="ctgWriteLevel">
				</c:if>
					<option value="1" <c:out value="${ctg.ctgWriteLevel == 1 ? 'selected' : '' }"/>>익명의 사용자</option>
					<option value="2" <c:out value="${ctg.ctgWriteLevel == 2 ? 'selected' : '' }"/>>새싹멤버</option>
					<option value="3" <c:out value="${ctg.ctgWriteLevel == 3 ? 'selected' : '' }"/>>일반멤버</option>
					<option value="4" <c:out value="${ctg.ctgWriteLevel == 4 ? 'selected' : '' }"/>>성실멤버</option>
					<option value="5" <c:out value="${ctg.ctgWriteLevel == 5 ? 'selected' : '' }"/>>열심멤버</option>
					<option value="6" <c:out value="${ctg.ctgWriteLevel == 6 ? 'selected' : '' }"/>>우수멤버</option>
					<option value="0" <c:out value="${ctg.ctgWriteLevel == 0 ? 'selected' : '' }"/>>관리자</option>
				</select>
				<c:choose>
					<c:when test="${board.boardId == 5 }">
						<label class="like_check_label" for="like_check">좋아요 기능 설정<input disabled id="like_check" type="checkbox" name="likeAllow" value="on" ></label>
						<label class="board_setting_label" for="board_setting">게시글 기능 설정</label>
						<p class="board_setting_wrap"><input disabled id="board_setting" type="checkbox" name="setting" > '<span style="color:red; font-weight:bold;">좋아요</span>' 개수가 
							<select id="like_cnt" name="likeCnt" disabled>
								<c:forEach var="cnt" begin="5" end="100" step="5">
									<option value="${cnt }" <c:out value="${board.likeCnt == cnt ? 'selected' : '' }"/> >${cnt }개</option>
								</c:forEach>	
							</select>
							이상인 글 중에 
							<select id="top_article_cnt" name="topArticleCnt" disabled>
								<c:forEach var="cnt" begin="1" end="5">
									<option value="${cnt }" <c:out value="${board.topArticleCnt == cnt ? 'selected' : '' }"/> >상위 ${cnt }개</option>
								</c:forEach>
							</select>	
							가 게시판 상단에 올라가도록 설정합니다.
						</p>
					</c:when>
					<c:otherwise>
						<label class="like_check_label" for="like_check">좋아요 기능 설정<input id="like_check" type="checkbox" name="likeAllow" value="on" <c:out value="${board.likeAllow == 'on' ? 'checked' : '' }"/> ></label>
						<label class="board_setting_label" for="board_setting">게시글 기능 설정</label>
						<p class="board_setting_wrap"><input id="board_setting" type="checkbox" name="setting" <c:out value="${board.likeCnt == 0 ? '' : 'checked' }"/> > '<span style="color:red; font-weight:bold;">좋아요</span>' 개수가 
							<select id="like_cnt" name="likeCnt">
								<c:forEach var="cnt" begin="5" end="100" step="5">
									<option value="${cnt }" <c:out value="${board.likeCnt == cnt ? 'selected' : '' }"/> >${cnt }개</option>
								</c:forEach>	
							</select>
							이상인 글 중에 
							<select id="top_article_cnt" name="topArticleCnt">
								<c:forEach var="cnt" begin="1" end="5">
									<option value="${cnt }" <c:out value="${board.topArticleCnt == cnt ? 'selected' : '' }"/> >상위 ${cnt }개</option>
								</c:forEach>
							</select>	
							가 게시판 상단에 올라가도록 설정합니다.
						</p>
					</c:otherwise>
				</c:choose>
				<div class="buttons_div">
				<c:if test="${not empty ctg }">
					<input name="modify_button" type="submit" value="수정하기">
				</c:if>
				<c:if test="${ctg == null }">
					<input name="save_button" type="submit" value="저장하기">
				</c:if>
				<input type="reset" value="취소" onClick="location.href='${contextPath}/admin/categoryManage.do'">
				</div>
			</div>
		</form>
	</section>
	<script type="text/javascript">
		$("input[name=group_select]").change(function(){
			var group_select = $("input[name=group_select]:checked").val();
			if (group_select === 'existing_group'){
				$("select[name=category_select]").attr("disabled", false);
			}else{
				$("select[name=category_select]").attr("disabled", true);
			}
		});
		
		function addCategory(){
			var menu_selected = $("input[name=menu_format]:checked").val();
			var group_select = $("input[name=group_select]:checked").val();
			
			var length = document.getElementsByClassName("selected").length;
			var length2 = document.querySelectorAll("ul.group_list").length;
			var length3 = document.querySelectorAll("li.group_selected").length;
			
			if (group_select === 'existing_group'){
				var group_name = $("select[name=category_select]").val();
				var group_list = document.getElementById("group_list"+group_name);
				var menu_name = group_list.previousElementSibling.previousElementSibling.innerHTML;
				var new_id = Number(group_list.childElementCount)+1;
				$("#group_list"+group_name).append(
							'<li id="grp'+group_name+'_'+(length3+5)+'" class="group_selected">' +
								'<a href="${contextPath}/categoryManage.do?ctgId='+(group_name)+'&boardId'+(length3+5)+'" title="'+menu_selected+'">' +
									'<span id="board_name'+(length3+5)+'">'+menu_selected+'</span>' +
								'</a></li>'
				);
				document.category_form.ctgName.value = menu_name;
				document.category_form.ctgId.value=group_name;
				$("input[name=ctgName]").attr("readOnly", true);
			}else{
				$("#custom_list").append('<li id="'+(length+1)+'" class="selected">'+
						'<span id="menu_name'+(length+1)+'">'+menu_selected+'</span>' +
						'<button id="btn'+(length+1)+'" onClick="fold(this)">그룹접기</button>' +
						'<ul id="group_list'+(length2+1)+'" class="group_list">' +
							'<li id="grp'+(length+1)+'_1" class="group_selected">' +
								'<a href="${contextPath}/categoryManage.do?ctgId='+(length2+1)+'&boardId'+(length3+5)+'" title="'+menu_selected+'">' +
									'<span id="board_name'+(length3+5)+'">'+menu_selected+'</span>' +
								'</a></li></ul></li>'
				);
			}
			$("#category_setting").css("display", "block");
			$("input[name=menu_format]").attr("disabled", true);
			$("input[name=group_select]").attr("disabled", true);
			$("select[name=category_select]").attr("disabled", true);
			$("#add_category_button").attr("disabled", true);
			$("#add_category_button").html("게시판 생성 중에 다른 게시판을 생성할 수 없습니다!");
			$('.menu_section a').bind('click', false);
		}
		
		$("input[name=save_button]").click(function(){
			$("input[name=menu_format]").attr("disabled", false);
			$("select[name=menu_format]").attr("disabled", false);
			$("input[name=group_select]").attr("disabled", false);
			$("select[name=category_select]").attr("disabled", false);
			$("#add_category_button").attr("disabled", false);
			
			var formData = new FormData($("#category_form")[0]);
			
			$.ajax({
	    		url:"categoryManage.do",
	    		data : formData,
	    		type:'post',
	    		cache: false,
	    		contentType: false,
	    		processData: false,
	    		success:function(data, textStatus){
	    			alert("새로운 게시판이 추가되었습니다!");
	    			location.href="${contextPath}/admin/categoryManage.do";
	    		},error: function(data, textStatus){
	    			alert("문제가 발생했습니다! 다시 시도해주세요!!");
	    		}
	    	 });
		});
		
		$("input[name=modify_button]").click(function(){
			if ($("select[name=boardStatus]").val() === 'inactive'){
				if (!confirm('게시판을 비활성화 상태로 변경하면 활성화 상태로 변경하지 못합니다! 이대로 수정하시겠습니까?')){
					return false;
				}				
			}
			
			$("input[name=menu_format]").attr("disabled", true);
			$("input[name=group_select]").attr("disabled", true);
			$("select[name=category_select]").attr("disabled", true);
			$("#add_category_button").attr("disabled", true);
			
			$("input[name=ctgName]").attr("disabled", false);
			$("input[name=boardName]").attr("disabled", false);
			$("select[name=boardStatus]").attr("disabled", false);
			$("select[name=ctgWriteLevel]").attr("disabled", false);
			var formData = new FormData($("#category_form")[0]);
			
			$.ajax({
	    		url:"modifyCategoryInfo.do",
	    		data : formData,
	    		type:'post',
	    		cache: false,
	    		contentType: false,
	    		processData: false,
	    		success:function(data, textStatus){
	    			if (data == 'success'){
	    				alert("수정되었습니다!");
	    				location.href="${contextPath}/admin/categoryManage.do";
	    			}
	    		},error: function(data, textStatus){
	    			alert("문제가 발생했습니다! 다시 시도해주세요!!");
	    		}
	    	 });
		});
		
		function reflectChange1(){
			var length = document.getElementsByClassName("selected").length;
			var length2 = document.querySelectorAll("ul.group_list").length;
			var length3 = document.querySelectorAll("li.group_selected").length;
			var text = $("input[name=ctgName]").val();
			var span = $("span#menu_name"+(length)).html(text);
		}
		
		function reflectChange2(){
			var length = document.getElementsByClassName("selected").length;
			var length2 = document.querySelectorAll("ul.group_list").length;
			var length3 = document.querySelectorAll("li.group_selected").length;
			var text = $("input[name=boardName]").val();
			console.log(length3);
			var span = $("span#board_name"+(length3+4)).html(text);
		}
		
		function fold(btn){
			var btn = document.getElementById(btn.id);
			if (!btn.nextElementSibling.className.includes("folded")){
				btn.nextElementSibling.style.display = "none";
				btn.nextElementSibling.className += " folded";
			}else if (btn.nextElementSibling.className.includes("folded")){
				btn.nextElementSibling.style.display = "block";
				btn.nextElementSibling.className = btn.nextElementSibling.className.replace(" folded", "");
			}
		}
	</script>
</body>
</html>