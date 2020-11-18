<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="filteredLength" value="${noDeletedArticleLength }"/>	
<c:set var="length" value="${articleListLength }"/>
<script type="text/javascript" src="${contextPath}/resources/js/formSerialize.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	a{
		text-decoration:none;
		color:black;
		cursor:pointer;
	}
	button{
		cursor:pointer;
	}
	#admin_comment{
		color:red;
		font-weight:900;
	}
    .article_section{
        width: 920px;
   	 	margin: 30px auto;
   	 	font-family: 'Poor Story', cursive !important;
    }
    .article_section .button_div button{
   		border: 1px solid orange;
    	padding: 10px 20px;
    	margin-right: 5px;
    	background: white;
    }
    .fas fa-angle-up, .fas fa-angle-down {
    	width: 10px;
    	height: 15px;
    	margin-left: -4px;
    }
    .article_table{
        border: 1px solid orange;
    	width: 920px;
   	 	margin-top: 10px;
    	border-bottom: none;
    }
    .article_table th{
   	    text-align: left;
    	border-bottom: 1px solid orange;
    	padding: 15px 10px;
    	font-size: 18px;
    }
    .articleBoard_span{
   	    color: #686868;
	    text-decoration: none;
	    font-size: 13px;
    }
    .articleDate_span{
        float: right;
    	font-size: 14px;
    	position: absolute;
    	right: 180px;
    	margin-top: 18px;
    }
    .articleWriter_td{
    	float:left;
    	text-align: left;
	   	padding: 10px;
	   	font-size: 14px;
	   	font-weight: 600;
    }
    .writerClick_div {
   	    position: absolute;
   	    top: 655px;
    	left: 485px; 
    }
    #hide_list_div{
    	background: white;
	    border: 1px solid orange;
	    margin: 0 7px;
  		height: 50px;
		text-align: center;
    }
    #hide_list_div :hover {
    	text-decoration: underline orange;
    }
    .content_div{
        width: 750px;
    	margin: auto 0 0 45px;
    	min-height: 500px;
    	text-align: left;
    	font-size: 20px;
    }
    .content_div img{
    	width: 750px;
    }
    .content_div p {
   	    line-height: 30px;
    }
    .tag_tr{
   	    height: 50px;
    }
    .tag_tr  div{
    	text-align: left;
    	margin-left: 40px;
    }
    .tag_tr  a{
   	    color: orange;
    	font-weight: bold;
    }
    .like_btn{
	   	border-style: none;
	    background: transparent;
	    color: #ff385b;
	    cursor: pointer;
	    margin-left: 40px;
	    font-weight: bold;
    }
    .like_btn + span{
   	    font-size: 13px;
	    margin-left: -5px;
	    font-weight: bold;
	    color: #ff385b;
    }
    .statistics_tr span{
   	    margin-right: 20px;
	    font-size: 13px;
	    font-weight: 600;
    }
    .comment_form{
	    border: 1px solid orange;
	    border-top: none;
	    width: 920px;
	    padding: 30px 50px;
	    border-bottom: none;
    }
    .comment_form textarea{
        height: 55px;
	    line-height: 13px;
	    resize: none;
	    width: 750px;
        padding: 5px;
	    border: 1px solid orange;
    }
    .comment_button{
        float: right;
	    position: absolute;
	    right: 225px;
	    padding: 15px;
	    background: transparent;
	    border: 1px solid orange;
	    color: black;
	    font-weight: bold;
    }
    .reply_form{
	    width: 920px;
    	border: 1px solid orange;
    	border-top: none;
    }
    .reply_form table{
   	    margin: 0 auto;
	    width: 820px;
	    border-spacing: 10px;
	    background-color: #eeeeee7d;
	    overflow: hidden;
	    padding-bottom: 20px;
    }
    .comment_table tr:first-child{
	    font-size: 13px;
	    font-weight: 900;
	    color: red;
	    text-align: center;
	    height: 25px;
    }
    .comment_table tr{
        font-size: 15px;
    	color: black;
    }
    .comment_table tr.user_deleted_comment{
    	height: 36px;
    }
    .user_deleted_comment td{
   	    padding-left: 55px;
    	font-weight: bold;
    	color: red;
    }
    .comment_table td:first-child{
    	width: 600px;
    }
    .open_reply_button{
   	    background: transparent;
    	border-style: none;
    	width: 45px;
    	height: 10px;
    	font-size: 10px;
    	cursor: pointer;
    }
    .delete_btn{
    	background: transparent;
    	border-style: none;
    	color: red;
   	    margin-left: -8px;
    }
    .reply_content{
   	    resize: none;
    	width: 710px;
    	height: 70px;
    	margin-left: 7px;
    	border: 1px solid orange;
    }
    .reply_btn{
        float: right;
    	padding: 22px;
    	height: 70px;
   	    border: 1px solid orange;
    	background: white;
    	font-weight: bold;
    }
    .ban_btn{
        border: none;
	    background: transparent;
	    color: orangered;
	    font-size: 14px;
	    margin-left: -10px;
    }
    .comment_writer_span{
    	border-radius: 13px;
    	border: 1px solid red;
    	font-size: 10px;
    	font-weight: 600;
    	padding: 2px;
    }
    .profile_image{
   	    width: 32px;
    	height: 32px;
    	border-radius: 18px;
    	border: 1px solid black;
    	vertical-align: top;
    	margin-left:5px;
    }
    .user_comment_wrap{
    	margin-left: 10px;
    	margin-top: -2px;
    	display: inline-block;
   	    width: inherit;
    }
    .clear{
   	    height: 60px;
    }
    .button_wrap{
    	text-align:right;
    	margin: 35px 0 70px;
    }
    .button_wrap a, .button_wrap button{
   	    font-size: 15px;
    	border: 1px solid orange;
    	padding: 10px 20px;
    	background-color: transparent;
    	margin-top: 10px;
    }
    .button_wrap a{
    	padding: 13px 10px;
    }
    .next_prev_articles table{
   	    width: 100%;
    	border: 1px solid orange;
    	border-collapse: collapse;
    	line-height: 30px;
    	font-weight: 600;
    	text-align: center;
    	font-size:12px;
    }
    .next_prev_articles table tr{
        border: 1px solid orange;
    }
    .next_prev_articles table td:first-child{
   	    width: 70px;
    }
    .next_prev_articles table td:nth-child(2){
   	    width: 660px;
    	text-align: left;
    }
    .next_prev_articles table td:nth-child(3){
    	width:80px;
    }
</style>
	<section class="article_section">
		<div class="button_div">
			<c:choose>
				<c:when test="${article.parentId > 0 }">
					<button onClick="location.href='${contextPath}/member/articleDetail.do?boardId=${board.boardId }&articleId=${article.parentId }'">본문보러가기</button>
				</c:when>
				<c:otherwise>
					<c:if test="${prevId > 0 }">
						<button onClick="location.href='${contextPath}/member/articleDetail.do?boardId=${board.boardId }&articleId=${prevId }'"><i style="width: 10px; height: 15px; margin-left: -4px;" class="fas fa-angle-up"></i>이전글</button>
					</c:if>
					<c:if test="${nextId > 0 }">
						<button onClick="location.href='${contextPath}/member/articleDetail.do?boardId=${board.boardId }&articleId=${nextId }'"><i style="width: 10px; height: 15px; margin-left: -4px;" class="fas fa-angle-down"></i>다음글</button>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
		<table id="article_table" class="article_table">
			<thead>
				<tr>
					<th>
						<c:if test="${article.parentId > 0  }">
							RE: ${article.articleTitle } 
						</c:if>
						<c:if test="${article.parentId == 0  }">
							${article.articleTitle } 
						</c:if>
						<span class="separator_span">|</span> 
						<a href="boardMain.do?boardId=${board.boardId }">
							<span class="articleBoard_span">${board.boardName }</span>
						</a>
						<span class="articleDate_span">
							<fmt:formatDate value="${article.articleDate}" pattern="yyyy년  M월 d일  HH:mm:ss" />
						</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="articleWriter_td">
						<c:if test="${article.imageId.equals('basic')  }">
							<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/profile_basic.png">
						</c:if>
						<c:if test="${article.imageId.equals('admin')  }">
							<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/profile_admin.png">
						</c:if>
						<c:if test="${!article.imageId.equals('basic') && !article.imageId.equals('admin') }">
							<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/${article.memberId}/${article.imageId}">
						</c:if>
						<div class="writerClick_div">  
							<span id="hideListBtn" onClick="hideList()">
							${article.nickName }(${fn:substring(article.memberId, 0, 4)}****)
							</span>
							<div class="hide_list_div" id="hide_list_div" style="display:none;">
								<p style="display:inline-block">
									<a href='javascript:void(0);' onclick="window.open('${contextPath}/member/otherMyPage.do?nickName=${article.nickName}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=700,left=0, top=0, scrollbars=yes');return false">
										마이페이지
									</a>
								</p>
								<br>
								<p style="display:inline-block" onclick="openNewWindow()"><a>쪽지보내기</a></p>
							</div>
						</div> 
					</td>
				</tr>
				<tr>
					<td><div class="content_div">${article.articleContent }</div></td>
				</tr>
				<c:if test='${article.tag != "NONE_TAG" && article.tag != "[NONE_TAG]" }'>
					<tr class="tag_tr">
						<td>
							<div>
								<c:forEach items="${tagList }" var="tag">
									<a href="articleSearch.do?searchInput=${tag }&searchCondition=tag&articleCategory=all">#${tag }</a>
								</c:forEach>
							</div>
						</td>
					</tr>
				</c:if>
				<tr class="statistics_tr">
					<td>
						<c:choose>
							<c:when test="${board.likeAllow == 'on' }">
								<button id="likebtn" class="like_btn" name="likebtn" onClick="<c:out value="${likeInfo == true ? 'return false;' : 'increaseLikeCnt()' }"/>"><i class="fas fa-heart"></i>좋아요</button>
							</c:when>
							<c:otherwise>
								<button id="likebtn" class="like_btn" name="likebtn" onClick="javascript:alert('좋아요가 허용되지 않는 게시글입니다!');"><i class="fas fa-heart"></i>좋아요</button>
							</c:otherwise>
						</c:choose>	
						<span>${article.articleLikeCnt }</span><span class="separator_span">|</span><span>댓글 수 ${fn:length(comment) }</span><span class="separator_span">|</span><span>조회 수 ${article.articleReadCnt }</span>
						<c:if test="${likeInfo }">
							<p style="margin-left: 40px; font-size: 12px; color: #ff385b; font-weight: bold;">※이미 좋아요를 누른 게시글입니다※</p>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
		<form id="comment_form" name="comment_form" class="comment_form" method="post" onsubmit = "return false;">
			<input id="articleId" name="articleId" type="hidden" value="${article.articleId }">
			<input id="nickName" name="nickName" type="hidden" value="${member.nickName }"> 
			<textarea id="commentContent" name="commentContent" class="content_input" title="댓글달기" maxLength="6000"></textarea>
			<input type="submit" class = "comment_button" id="comment_button" name="comment_button" value = "등록">
		</form>
		<form id="reply_form" class="reply_form" name="reply_form" onsubmit="return false;">
			<table id = "comment_table" class="comment_table">
				<tbody id = "comment_tbody">
					<tr id="comment">
						<td>욕설과 비방은 관리자가 삭제합니다.</td>
					</tr>
					<!-- commentLevel이 1이면 그냥 댓글 2면 댓글에 달린 댓글 -->
					<!-- 3이면 댓글에 달린 댓글에 달린 댓글 -->
					<c:forEach items="${comment}" var="list">
						<c:if test="${list.commentStatus == 'TRUE' }">
							<tr id="user_comment${list.commentId }" class="user_deleted_comment">
								<td>삭제된 댓글입니다</td>
							</tr>
						</c:if>
						<c:if test="${list.commentStatus != 'TRUE' }">
						<c:choose>
		      				<c:when test='${list.commentLevel >= 2 }'>  
		     					<tr id="user_comment${list.commentId }" class="user_comment">
									<td>
										<span style="padding-left:50px"></span>
										<c:if test="${list.imageId.equals('basic')  }">
											<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/profile_basic.png">
										</c:if>
										<c:if test="${list.imageId.equals('admin')  }">
											<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/profile_admin.png">
										</c:if>
										<c:if test="${!list.imageId.equals('basic')  && !list.imageId.equals('admin')  }">
											<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/${list.memberId}/${list.imageId}">
										</c:if>
										<c:if test="${list.commentStatus == 'FALSE' }">
											<div class="user_comment_wrap">
												<span id="user_nickname_${list.commentId }"><i class="fas fa-comment-dots"></i>${list.nickName }</span>
												<c:if test="${list.nickName == article.nickName }">
													<span class="comment_writer_span">작성자</span>
												</c:if>
												<span><fmt:formatDate value="${list.commentDate}" pattern="yyyy년  M월 d일  HH:mm:ss" /></span>
												<button class="open_reply_button" id="reply_btn${list.commentId }" value="${list.commentId }" onClick="openCommentForm(${list.commentId })">
													<i class="fas fa-reply"></i>답글
												</button>
												<button id="delete_btn${list.commentId }" class="delete_btn" type="submit" value="${list.commentId }">
													<i class="fas fa-trash-alt"></i>
												</button>
												<c:if test="${member.memberId != list.memberId }">
													<button id="ban_btn${list.commentId }" class="ban_btn" type="submit" value="${list.commentId }">
														<i class="fas fa-exclamation-triangle"></i>신고
													</button>
												</c:if>
												<span style="display:block; width: 670px; word-break: break-word; margin-left: 14px;">${list.commentContent }</span>
											</div>
										</c:if>
										<c:if test="${list.commentStatus == 'BLOCK' }">
											<div class="user_comment_wrap">
												<span id="spam_span${list.commentId }" onClick="showContent(${list.commentId}, this)">신고된 댓글이라서 블라인드 처리가 되었습니다.</span>
											</div>
											<div id="spam_wrap${list.commentId }" class="user_comment_wrap spam" style="display:none;" onClick="blockContent(${list.commentId},this)">
												<span id="user_nickname_${list.commentId }"><i class="fas fa-comment-dots"></i>${list.nickName }</span>
												<c:if test="${list.nickName == article.nickName }">
													<span class="comment_writer_span">작성자</span>
												</c:if>
												<span><fmt:formatDate value="${list.commentDate}" pattern="yyyy년  M월 d일  HH:mm:ss" /></span>
												<span style="display:block; width: 670px; word-break: break-word; margin-left: 14px;">${list.commentContent }</span>
											</div>
										</c:if>
									</td>
								</tr>
		 						<tr>
		 							<td>
										<textarea id="reply_content${list.commentId }" class="reply_content" name="commentContent" style="display:none;"></textarea>
										<input type="hidden" id="reply_submit${list.commentId }" class="reply_btn" value="등록">
									</td>
		 						</tr>
							</c:when>
							<c:otherwise>
								<tr id="user_comment${list.commentId }" class="user_comment">
									<td>
										<c:if test="${list.imageId.equals('basic')  }">
											<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/profile_basic.png">
										</c:if>
										<c:if test="${list.imageId.equals('admin')  }">
											<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/profile_admin.png">
										</c:if>
										<c:if test="${!list.imageId.equals('basic')   && !list.imageId.equals('admin') }">
											<img class="profile_image" alt="basic" src="${contextPath }/resources/upload/photo_profile/${list.memberId}/${list.imageId}">
										</c:if>
										<c:if test="${list.commentStatus == 'FALSE' }">
										<div class="user_comment_wrap">
											<span id="user_nickname_${list.commentId }">${list.nickName }</span>
											<c:if test="${list.nickName == article.nickName }">
												<span class="comment_writer_span">작성자</span>
											</c:if>
											<span><fmt:formatDate value="${list.commentDate}" pattern="yyyy년  M월 d일  HH:mm:ss" /></span>
											<button class="open_reply_button" id="reply_btn${list.commentId }" value="${list.commentId }" onClick="openCommentForm(${list.commentId })">
												<i class="fas fa-reply"></i>답글
											</button>
											<button id="delete_btn${list.commentId }" class="delete_btn" type="submit" value="${list.commentId }">
												<i class="fas fa-trash-alt"></i>
											</button>
											<c:if test="${member.memberId != list.memberId }">
												<button id="ban_btn${list.commentId }" class="ban_btn" type="submit" value="${list.commentId }">
													<i class="fas fa-exclamation-triangle"></i>신고
												</button>
											</c:if>
											<span class="comment_content_span" style="display:block; width: 670px; word-break: break-word;">${list.commentContent }</span>
										</div>
										</c:if>
										<c:if test="${list.commentStatus == 'BLOCK' }">
											<div class="user_comment_wrap">
												<span id="spam_span${list.commentId }" onClick="showContent(${list.commentId}, this)">신고된 댓글이라서 블라인드 처리가 되었습니다.</span>
											</div>
											<div id="spam_wrap${list.commentId }" class="user_comment_wrap spam" style="display:none;" onClick="blockContent(${list.commentId},this)">
												<span id="user_nickname_${list.commentId }">${list.nickName }</span>
												<c:if test="${list.nickName == article.nickName }">
													<span class="comment_writer_span">작성자</span>
												</c:if>
												<span><fmt:formatDate value="${list.commentDate}" pattern="yyyy년  M월 d일  HH:mm:ss" /></span>
												<span class="comment_content_span" style="display:block; width: 670px; word-break: break-word;">${list.commentContent }</span>
											</div>
										</c:if>
									</td>
								</tr>
								<tr>
		 							<td>
										<textarea id="reply_content${list.commentId }" class="reply_content" name="commentContent" style="display:none;"></textarea>
										<input type="hidden" id="reply_submit${list.commentId }" class="reply_btn" value="등록">
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
						</c:if>
					</c:forEach>
				</tbody>
			</table>	
			<div class="clear"></div>
		</form>
		<div class="button_wrap">
			<c:if test="${(member.memberLevel >= category.ctgWriteLevel && category.ctgWriteLevel != 0 && category.ctgId > 0) || member.role == 'ADMIN' }">
				<a class="write_btn" href="articleNew.do?boardId=${board.boardId }"><i class="fas fa-pencil-alt" style="margin-right:15px"></i>글쓰기</a>
				<c:if test="${category.ctgId != 0 }">
					<button type="button" onClick="location.href='articleNew.do?articleId=${article.articleId}&boardId=${board.boardId }'">답글</button>
				</c:if>
			</c:if>
			<button type="button" onClick="location.href='boardMain.do?boardId=${board.boardId}&curBlock=${curBlock }&pageNum=${pageNum }'">목록</button>
			<c:if test="${article.nickName == member.nickName }">
				<button type="button" onClick="location.href='articleModify.do?articleId=${article.articleId}&boardId=${board.boardId }'">
					<i class="fas fa-edit"></i>
					수정
				</button>
			</c:if>
			<a href="#article_table" style="display: block; border: none;"><i class="far fa-arrow-alt-circle-up"></i>TOP</a>
		</div>
		<div class="next_prev_articles">
			<table>
				<tbody>
					<c:choose>
						<c:when test="${article.parentId > 0 }">
							<tr>
								<td>${parentArticle.articleId }</td>
								<td>
									<a href="${contextPath}/member/articleDetail.do?boardId=${board.boardId }&articleId=${article.parentId }">
										<span style="color: #747474; margin-right: 10px;">[${parentArticle.articleHead }]</span>
										<span>[본문]</span>
										<span style="word-break: break-word;">${parentArticle.articleTitle }</span>
										<span style="color:red;">[${parentArticle.articleCommentCnt }]</span>
									</a>
								</td>
								<td>${parentArticle.nickName }</td>
								<td><fmt:formatDate value="${parentArticle.articleDate }" pattern = "yyyy년 M월 d일"/></td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:if test="${prevId > 0 }">
								<tr>
									<td><i style="width: 10px; height: 15px; margin-left: -4px; margin-right: 4px;" class="fas fa-angle-up"></i>${prevArticle.articleId }</td>
									<td>
										<a href="${contextPath}/member/articleDetail.do?boardId=${board.boardId }&articleId=${prevId }">
											<span style="color: #747474; margin-right: 10px;">[${prevArticle.articleHead }]</span>
											<span style="word-break: break-word;">${prevArticle.articleTitle }</span>
											<span style="color:red;">[${prevArticle.articleCommentCnt }]</span>
										</a>
									</td>
									<td>${prevArticle.nickName }</td>
									<td><fmt:formatDate value="${prevArticle.articleDate }" pattern = "yyyy년 M월 d일"/></td>
								</tr>
							</c:if>
							<c:if test="${nextId > 0 }">
								<tr>
									<td><i style="width: 10px; height: 15px; margin-left: -4px; margin-right: 4px;" class="fas fa-angle-down"></i>${nextArticle.articleId }</td>
									<td>
										<a href="${contextPath}/member/articleDetail.do?boardId=${board.boardId }&articleId=${nextId }">
											<span style="color: #747474; margin-right: 10px;">[${nextArticle.articleHead }]</span>
											<span style="word-break: break-word;">${nextArticle.articleTitle }</span>
											<span style="color:red;">[${nextArticle.articleCommentCnt }]</span>
										</a>
									</td>
									<td>${nextArticle.nickName }</td>
									<td><fmt:formatDate value="${nextArticle.articleDate }" pattern = "yyyy년 M월 d일"/></td>
								</tr>
							</c:if>
						</c:otherwise>
					</c:choose>	
				</tbody>
			</table>
		</div>
	</section>
	<script type="text/javascript">
		 function hideList() {
		    	var btn = document.getElementById("hideListBtn");
		    	var articleMemberRole = "${articleMember.role}";
		    	var articleMemberNickName = "${articleMember.nickName}";
		    	var memberNickName = "${member.nickName}";
		    	// 손님이거나 글쓴이가 본인 또는 관리자일때는 클릭해도 X
		    	if(articleMemberRole === "USER" && !(articleMemberNickName === memberNickName) && "${member.memberLevel}" != 1){
		    		if(!btn.nextElementSibling.className.includes("show")){
			    		document.getElementById("hide_list_div").style.display="block";
			    		btn.nextElementSibling.className += "_show";
			    	} else if (btn.nextElementSibling.className.includes("show")){
			    		document.getElementById("hide_list_div").style.display = "none";
			    		btn.nextElementSibling.className = btn.nextElementSibling.className.replace("_show","");
			    	}
		    	}
		    }
		    
		var newWindow;
		function openNewWindow(){
	        window.open("${contextPath}/member/messageForm.do?nickName=${article.nickName}" , "newWindow", "width=400, height=450, top=150, left=500, scrollbar=no");
		}
		
		$("#comment_button").click(function(e){
			e.preventDefault();
			if ("${member.memberLevel}" == 1){
				alert("회원만 댓글을 작성할 수 있습니다! 로그인 또는 회원가입을 해주세요!!");
				$("textarea[name=commentContent]").attr("disabled", true);
				$("textarea[name=commentContent]").val("");
				$("#comment_button").attr("disabled", true);
				return false;
			}
			
			var form_data = $("#comment_form").serializeObject();
			$.ajax({
				url : 'insertComment.do',
				type : 'POST',
				data : form_data,
				success : function(data){
					if(data == "insert_success"){
						location.reload();
					}else if (data == "insert_success&update"){
						alert("등업 되셨습니다!");
						location.reload();
					}
				},
				error: function(data){
					alert("문제가 발생했습니다! 다시 시도해주세요");
				}
			});
	    });
		
	    $(".delete_btn").click(function(e){
	    	e.preventDefault();
	    	var btn_name = e.currentTarget.id;
			var id = $('#'+btn_name).val();
			var nickName= document.getElementById("user_nickname_"+id).innerText;
			if ("${member.nickName}" != nickName && "${member.role}" != 'ADMIN'){
				alert("작성한 댓글만 삭제할 수 있습니다!");
				return;
			}
			$.ajax({
				url : 'deleteComment.do?commentId='+id,
				type : 'PUT',
				success : function(data) {
					if (data == "delete_success"){
						alert("삭제되었습니다.");
						location.reload();
					}
				},
				error: function(data){
					alert("문제가 발생했습니다! 다시 시도해주세요");
				}
			}); 
	    });
	    
	    $(".ban_btn").click(function(e){
	    	e.preventDefault();
	    	var btn_name = e.currentTarget.id;
			var id = $('#'+btn_name).val();
			$.ajax({
				url : 'banComment.do?commentId='+id,
				type : 'PUT',
				success : function(data) {
					if (data == "ban_success"){
						alert("신고되었습니다! 소중한 의견 감사합니다!");
						location.reload();
					}
				},
				error: function(data){
					alert("문제가 발생했습니다! 다시 시도해주세요");
				}
			}); 
	    });
	    
	    function showContent(id, obj){
	    	document.getElementById("spam_wrap"+id).style.display="inline-block";
	    	obj.parentElement.style.display="none";
	    }
	    
	    function blockContent(id, obj){
	    	console.log("click");
	    	console.log(obj);
	    	obj.previousElementSibling.style.display="inline-block";
	    	obj.style.display="none";
	    }
	    
	    function openCommentForm(id){
	    	if ("${member.memberLevel}" == 1){
				alert("회원만 댓글을 작성할 수 있습니다! 로그인 또는 회원가입을 해주세요!!");
				$("textarea[name=commentContent]").attr("disabled", true);
				$("textarea[name=commentContent]").val("");
				$("#comment_button").attr("disabled", true);
				return false;
			}
	    	
	    	document.getElementById("reply_content"+id).style.display="inline-block";
	    	document.getElementById("reply_submit"+id).type="submit";
	    }
	    
	    function increaseLikeCnt(){
	    	if ("${member.memberLevel}" == 1){
				alert("회원만 좋아요 버튼을 누를 수 있습니다! 로그인 또는 회원가입을 해주세요!!");
				$("textarea[name=commentContent]").attr("disabled", true);
				$("textarea[name=commentContent]").val("");
				$("#comment_button").attr("disabled", true);
				return false;
			}
	    	
	    	if("${article.memberId}" == "${member.memberId}"){
	    		alert("본인이 작성한 게시글은 좋아요를 누를 수 없습니다!");
	    		return false;
	    	}
	    	
	    	if (document.getElementById("likebtn").readOnly){
	    		alert("좋아요는 한번만 가능합니다!");
	    		return;
	    	}
	    	
	    	$.ajax({
				url : 'increaseLikeCnt.do?articleId=${article.articleId}&memberId=${member.memberId}',
				type : 'PUT',
				success : function(data) {
					document.getElementById("likebtn").nextElementSibling.innerText = Number(document.getElementById("likebtn").nextElementSibling.innerText)+1;
					document.getElementById("likebtn").readOnly = true;
				},
				error: function(data){
					alert("문제가 발생했습니다! 다시 시도해주세요");
				}
			}); 
	    }
	    
	    $(".reply_btn").click(function(e){
	    	
	    	if ("${member.memberLevel}" == 1){
				alert("회원만 댓글을 작성할 수 있습니다! 로그인 또는 회원가입을 해주세요!!");
				$("textarea[name=commentContent]").attr("disabled", true);
				$("textarea[name=commentContent]").val("");
				$("#comment_button").attr("disabled", true);
				return false;
			}
	    	
	    	var btn_name = e.currentTarget.id;
			var id = btn_name.substring(12);
			
			var formData = new FormData();
			formData.append('articleId', document.getElementById("articleId").value);
			formData.append('commentContent', document.getElementById("reply_content"+id).value);
			formData.append('parentId', id);
			formData.append('nickName', "${member.nickName}");
			
			$.ajax({
				url : 'replyComment.do',
				type : 'POST',
				cache : false,
				contentType: false,
				processData: false,
				data : formData,
				success : function(data) {
					if (data == "reply_success"){
						location.reload();
					}else if (data == "reply_success&update"){
						alert("등업 되셨습니다!");
						location.reload();
					}
					
				},
				error: function(data){
					alert("문제가 발생했습니다! 다시 시도해주세요");
				}
			}); 
	    });
	</script>
