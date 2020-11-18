<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />    
<style>
	@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap');
	.my_page_main_form{
	    width: 910px;
	    text-align: left;
	    margin: 30px 0 0 40px;
	    font-family: 'Gamja Flower', cursive;
	    border: 1px dotted #ef962d;
	    padding: 20px 0px;
	}
	.profile_img_div{
		display: inline-block;
	   	margin-left: 10px;
	   	vertical-align: middle;
	   	height: 70px;
	}
	.profile_img_div img{
	    width: 70px;
	   	height: 70px;
	   	border-radius: 35px;
	   	border: 1px solid #ef962d;
	}
	.member_info_div{
	    display: inline-block;
	    line-height: 5px;
	    height: 90px;
	    width: 250px;
	}
	.member_info_div h2{
        font-size: 25px;
    	font-weight: bold;
    	line-height: 25px;
	}
	.member_detail_info_div{
	    margin-left: 85px;
	       margin-top: -23px;
	}
	.member_detail_info_div span{
		font-weight:bold;
		color:#ef962d;
	}
	.my_page_main_form div.buttons_div{
	       margin-left: 88px;
	   	margin-top: 10px;
	}
	.my_page_main_form input[type=submit], .my_page_main_form input[type=button]{
	    border: 1px solid #ef962d;
	   	background: #ef962d;
	   	font-weight: bold;
	}
	.my_page_main_tab{
	    margin: 30px 0 10px 40px;
	    font-family: 'Gamja Flower', cursive;
        font-size: 20px;
	   	font-weight: bold;
	}
	.my_page_main_tab a{
	    border: 1px solid #ef962d;
	   	display: inline-block;
  	    padding: 0px 35px;
  	    background: antiquewhite;
	}
	.my_page_main_tab a.selected:hover{
	    color: white;
    	text-decoration: none;
    	transform: scale(1.1);
	}
	.my_page_main_tab a:hover{
	    color: #ef962d;
    	text-decoration: none;
    	transform: scale(1.1);
	}
	.my_page_main_tab a.selected{
		background: #ef962d !important;
	}
	.my_page_main_tab a:nth-child(2), .my_page_main_tab a:nth-child(3){
	    margin-left: -5px;
	}
	.show_active_form_wrap{
		margin-left:40px;
	}
	.show_active_form_wrap table.my_page_table_buttons{
	    font-family: 'Poor Story', cursive !important;
	}
	.my_page_table_buttons input[type=submit]{
	    background: #ef962d;
    	border: 1px solid #ef962d;
    	font-weight: bold;
    	font-family: 'Gamja Flower', cursive;
   	    padding: 0 20px;
	}
	select[name=sortNum]{
		width:70px;
	}
	.show_active_form_wrap table.my_page_main_table{
		width:100%;
		font-family: 'Gamja Flower', cursive;
	    border-top: 3px solid #ef962d;
	    border-bottom: 3px solid #ef962d;
	    margin-top: 10px;
	    border-collapse: collapse;
	}
	.show_active_form_wrap table.my_page_main_table th{
		font-size:18px;
	}
	.show_active_form_wrap table.my_page_main_table th:last-child{
		width: 50px;
	}
	.show_active_form_wrap table.my_page_main_table tr{
		text-align:center;
	    border-bottom: 1px solid #ef962d38;
	}
	.show_active_form_wrap table.my_page_main_table tr:first-child{
	    border-bottom: 2px solid #ef962d;
	   	line-height: 35px;
	}	
	.show_active_form_wrap table.my_page_main_table td{
		line-height:16px;
		font-size: 16px;
	    padding: 10px 0;
	}
	.comment_tr th:nth-child(2){
		width:60px !important;
	}
	.comment_tr th:nth-child(3){
		width:620px !important;
	}
	.comment_tr td:nth-child(2){
		text-align:center !important; 
		padding:0 !important; 
		font-weight:normal !important;
	}
	.comment_tr td:nth-child(3){
		text-align:left !important; 
		padding-left:10px !important; 
		font-weight:bold !important;
	}
	.my_page_mini_wrap{
	    text-align: right;
    	margin-top: 20px;
    	font-family: 'Gamja Flower', cursive;
	}
	.my_page_mini_wrap input[type=button]{
	    border: 1px solid #ef962d;
    	background: #ef962d;
    	font-weight: bold;
	}
	.page_navigation_wrap{
        width: 920px;
   	 	height: 30px;
   	 	margin-top:30px;
    }
    .page_nav_ul{
        list-style: none;
    	margin: 0;
    	padding: 0;
    	height: 100%;
    	text-align: center;
    }
    .page_nav_li{
        text-align: center;
	    width: 30px;
	    display: inline-block;
	    height: 30px;
	    line-height: 30px;
	    font-weight: bold;
	    font-size:18px;
    }
    .page_nav_li:first-child{
    	margin-right: 5px;
    	font-size:13px !important;
    	text-align:right;
    }
    .page_nav_li:last-child{
    	font-size:13px !important;
    	text-align:left;
    	margin-left: 3px;
    }
    .page_nav_li a{
    	font-family: 'Gamja Flower', cursive;
    }
</style>
	<div>
		<form name="myPageMain_form" id="myPageMain_form" class="my_page_main_form" method="post">
			<div class="profile_img_div">
				<c:if test="${infoMember.imageId.equals('basic') && !infoMember.role.equals('ADMIN') }">
					<img src="${contextPath }/resources/upload/photo_profile/profile_basic.png">
				</c:if>
				<c:if test="${infoMember.role.equals('ADMIN') }">
					<img src="${contextPath }/resources/upload/photo_profile/profile_admin.png">
				</c:if>
				<c:if test="${!infoMember.imageId.equals('basic') && !infoMember.role.equals('ADMIN') }">
					<img src="${contextPath }/resources/upload/photo_profile/${infoMember.memberId}/${infoMember.imageId}">
				</c:if>
			</div>
			<div class="member_info_div">
				<h2>${infoMember.nickName }(${fn:substring(infoMember.memberId,0,4) }****)</h2>&nbsp;
				${infoMember.levelName }
			</div>
			<div class="member_detail_info_div">
				총 방문일 <span>${infoMember.loginCnt } </span>회&nbsp;
				총 게시물 <span>${infoMember.articleCnt } </span>개&nbsp;
				총 댓글 <span>${infoMember.commentCnt } </span>개&nbsp;
			</div>
			<div class="buttons_div">
            	<c:if test="${empty mini && (infoMember.nickName == member.nickName)}">
	               <c:if test="${member.role.equals('USER')}">
	                  <input type="button" value="쪽지확인" name="showMessage" onclick="location.href='${contextPath}/member/memberMessageList.do'">&nbsp;
	                  <input type="button"  value="내 정보 수정" onclick="location.href='${contextPath}/member/myPage.do'">
	               </c:if>
            	</c:if> 
         	</div>
		</form>
	</div>
	<div class="my_page_main_tab">
     	<c:if test="${tabNum == 1 }">
     	  <c:set var="tab" value="${tabNum }" />	
		  <a href="${contextPath }/member/myPageMain.do?tabNum=1&memberId=${infoMember.memberId}" class="tablinks selected">게시글</a>
		  <a href="${contextPath }/member/myPageMain.do?tabNum=2&memberId=${infoMember.memberId}" class="tablinks">댓글</a>
		  <a href="${contextPath }/member/myPageMain.do?tabNum=3&memberId=${infoMember.memberId}" class="tablinks">좋아요</a>
		</c:if>
		<c:if test="${tabNum == 2 }">
		  <c:set var="tab" value="${tabNum }" />
		  <a href="${contextPath }/member/myPageMain.do?tabNum=1&memberId=${infoMember.memberId}" class="tablinks">게시글</a>
		  <a href="${contextPath }/member/myPageMain.do?tabNum=2&memberId=${infoMember.memberId}" class="tablinks selected">댓글</a>
		  <a href="${contextPath }/member/myPageMain.do?tabNum=3&memberId=${infoMember.memberId}" class="tablinks">좋아요</a>
		</c:if>
		<c:if test="${tabNum == 3 }">
		  <c:set var="tab" value="${tabNum }" />
		  <a href="${contextPath }/member/myPageMain.do?tabNum=1&memberId=${infoMember.memberId}" class="tablinks">게시글</a>
		  <a href="${contextPath }/member/myPageMain.do?tabNum=2&memberId=${infoMember.memberId}" class="tablinks">댓글</a>
		  <a href="${contextPath }/member/myPageMain.do?tabNum=3&memberId=${infoMember.memberId}" class="tablinks selected">좋아요</a>
		</c:if>
	</div>
	<div class="show_active_form_wrap">
		<form name="showActive_form" id="showActive_form" class="show_active_form" method="post">
			<c:if test="${empty mini && infoMember.nickName == member.nickName}">
				<table id="buttons" class="my_page_table_buttons">
					<tr>
						<th><input type="checkbox" name="allCheck" id="allCheck" style="margin-top:6px;"/></th>
						<c:if test="${tabNum == 1 || tabNum == 3 }">
							<th>선택된 게시글</th>
						</c:if>
						<c:if test="${tabNum == 2 }">
							<th>선택된 댓글</th>
						</c:if>
						<th>
							<input type="submit" value="삭제" name="deleteAll" data-userId="${infoMember.memberId }">
						<th>
						<th>
							 <select name="sortNum" id="sortNum" style="margin-left: 660px;">
								 <option value="15" <c:out value="${sortNum == 15? 'selected':'' }"/>>15개씩</option>
								 <option value="30" <c:out value="${sortNum == 30? 'selected':'' }"/>>30개씩</option>
								 <option value="45" <c:out value="${sortNum == 45? 'selected':'' }"/>>45개씩</option>
							 </select>
	                    </th>
					</tr>
				</table>
			</c:if>
			<table class="my_page_main_table">
				<c:if test="${tabNum == 1 || tabNum == 3 }">
					<tr>
						<c:if test="${empty mini && infoMember.nickName == member.nickName}">
							<th></th>
						</c:if>
						<th style="width: 46px;">글번호</th>
						<th style="width: 600px;">제목</th>
						<th>글쓴이</th>
						<th style="width: 80px;">작성일</th>
						<th>조회</th>
						<c:if test="${tabNum == 3 }">
							<th>좋아요</th>
						</c:if>
					</tr>
					<c:forEach var="list" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" items="${article }">
						<tr>
							<c:if test="${empty mini && infoMember.nickName == member.nickName}">
								<td><input type="checkbox" name="chBox" class="chBox" data-userId="${list.articleId }" ></td>
							</c:if>
							<td>${list.articleId }</td>
							<td style="text-align:left; padding-left: 10px; font-weight:bold;"><a href="${contextPath }/member/articleDetail.do?boardId=${list.boardId}&articleId=${list.articleId}">
		                        <span style="color: #747474; margin-right: 10px;">
		                        [${list.articleHead }]
		                        </span>
		                        ${list.articleTitle }</a>
		                    </td>
							<td>${list.nickName }</td>
							<td><fmt:formatDate value="${list.articleDate}" pattern="yyyy.MM.dd. hh:mm:ss"></fmt:formatDate></td>
							<td>${list.articleReadCnt }</td>
							<c:if test="${tabNum == 3 }">
								<td>${list.articleLikeCnt }</td>
							</c:if>
						</tr>
					</c:forEach>
					<c:if test="${empty article }">
						<tr>
							<td colspan="6">작성한 게시글이 없습니다.</td>
						<tr>
					</c:if>
				</c:if>
				<c:if test="${tabNum ==2 }">
					<tr class="comment_tr">
						<th></th>
						<th>댓글번호</th>
						<th>댓글내용</th>
						<th>댓쓴이</th>
						<th>작성일</th>
					</tr>
					<c:forEach var="comment" items="${comment }" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status">
						<tr class="comment_tr">
							<td><input type="checkbox" name="chBox" class="chBox" data-userId="${comment.commentId }" ></td>
							<td>${comment.commentId }</td>
							<td><a href="${contextPath }/member/articleDetail.do?boardId=${comment.boardId}&articleId=${comment.articleId}">${comment.commentContent }</a></td>
							<td>${comment.nickName }</td>
							<td><fmt:formatDate value="${comment.commentDate }" pattern="yyyy.MM.dd. hh:mm:ss"></fmt:formatDate></td>
						</tr>
					</c:forEach>
					<c:if test="${empty comment }">
						<tr>
							<td colspan="6">작성한 댓글이 없습니다.</td>
						<tr>
					</c:if>
				</c:if>
			</table>
			<div class="my_page_mini_wrap">
				<c:if test="${not empty mini }">
					<input type="button" value="닫기" onclick="window.close()">
				</c:if>
			</div>
		</form>
		<c:if test="${not empty comment || not empty article }">
		<div class="page_navigation_wrap">
         <ul class="page_nav_ul">
          <c:choose>
          	<c:when test="${searchInput != null }">
	          	<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="myPageMain.do?memberId=${infoMember.memberId }&tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="myPageMain.do?memberId=${infoMember.memberId }&tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin }">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="myPageMain.do?memberId=${infoMember.memberId }&tabNum=${tabNum }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${end }"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           	</c:when>
           	<c:otherwise>
           		<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="myPageMain.do?memberId=${infoMember.memberId }&tabNum=${tabNum }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="myPageMain.do?memberId=${infoMember.memberId }&tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${begin}">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="myPageMain.do?memberId=${infoMember.memberId }&tabNum=${tabNum }&sortNum=${sortNum}&pageNum=${end}"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           	</c:otherwise>
           </c:choose>
         </ul>
       </div>
       </c:if>
	</div>
	<script>
		// 모두 선택 체크박스 체크시 개별 체크박스들도 모두 체크
		$("#allCheck").click(function(){
			var chk = $("#allCheck").prop("checked");
			if(chk) {
				$(".chBox").prop("checked", true);
			} else {
				$(".chBox").prop("checked", false);
			}
		});
		
		// 개별 체크박스가 선택되거나 선택해제되면 모두 선택 체크박스가 해제
		$(".chBox").click(function(){
			$("#allCheck").prop("checked",false);
		});
		
		// 개별 선택된 체크박스들을 배열 변수 checkArr에 저장한 뒤 컨트롤러로 전송 - 강제탈퇴
		$("input[name=deleteAll]").click(function(){
			var check = $("input:checkbox[name=chBox]:checked").length;
			if(check < 1){
				alert("삭제할 항목을 선택해주세요.");
			} else{
				var confirm_val = confirm("삭제 하시겠습니까?");
			}
			if(confirm_val) {
				var checkArr = new Array();
				$("input[class='chBox']:checked").each(function(){
					checkArr.push($(this).attr("data-userId"));
				});
				history.replaceState({}, null, location.pathname); 
				$.ajax({
					url : "deleteArticleComment.do?tabNum=${tabNum}",
					type : "post",
					data : { chbox : checkArr },
					success : function(result){
						if(result == 1) {
							history.replaceState({}, null, location.pathname);
							alert("삭제 성공했습니다");
							location.href = "myPageMain.do?memberId=${member.memberId}&tabNum=${tabNum}";
						} else {
							alert("삭제 실패");
						}
					}
				});
			} 
		});
		
		$("input[name=showMessage]").click(function(e){
	         e.preventDefault();
	         console.log("쪽지보기클릭");
	         var role = String($(e.target).attr("data-role"));
	         console.log(typeof role);
	         console.log(role);
	         if(role === 'USER'){
	            location.href='${contextPath}/member/memberMessageList.do';
	         } else if(role === 'ADMIN'){
	            location.href='${contextPath}/admin/messageList.do';      
	         }
	      });
		
		$("select[name=sortNum]").change(function(){
	          var sortNum = $("select[name=sortNum]").val();
	            var url = location.search;
	            var params = new URLSearchParams(url);
	            if (params.has("sortNum")){
	            params.set("sortNum", sortNum);
	            if (params.has("pageNum")){
	               params.set("pageNum", "0");
	            }
	            params.delete("pageNum");
	            document.location.href="${contextPath}/member/myPageMain.do?"+params.toString();
	            }else{
	               if (sortNum == 30 || sortNum ==45){
	                  params.append("sortNum", sortNum);
	               }
	               params.delete("pageNum");
	               document.location.href="${contextPath}/member/myPageMain.do?"+params.toString();
	            }
	        });
	</script>
