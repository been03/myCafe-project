<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />  

<style>
	@import url('https://fonts.googleapis.com/css2?family=Stylish&display=swap');
	.board_section a{
		color:black;
		text-decoration:none;
		font-size:13px;
		font-family: 'Stylish', sans-serif !important;
	}
	.board_section{
	    width: 920px;
    	margin: 15px auto 0;
	}
	.board_name{
		font-family: 'Stylish', sans-serif !important;
	    font-size: 40px;
	    margin: 0;
	}
	.board_desc{
		font-size: 18px;
	    padding-left: 5px;
	    margin: 0 0 20px;
	    font-weight: 500;
	    font-family: 'Stylish', sans-serif !important;
	}
	.board_table{
		border-collapse: collapse;
		width: 100%;
    	line-height: 30px;
    	border-top: 3px solid #ef962d;
    	border-bottom: 3px solid #ef962d;
    	font-size: 18px;
    	font-family: 'Stylish', sans-serif !important;
	}
	.board_table thead{
		border-bottom: 1px solid #ef962d;
		font-size: 20px;
	    text-align: center;
	}
	.board_table thead > tr{
	    background-color: #ff8c0099;
    	color: white;
   	    line-height: 40px;
        font-size: 20px;
	}
	.board_section th:first-child{
		width: 80px;
	}
	.board_section th:nth-child(2){
        width: 490px;
	}
	.board_section tbody{
		text-align:center;
	}
	.board_section tr{
		font-size:15px;
		font-weight: bold;
	}
	.board_section td{
	    line-height: 35px;
    	padding: 5px;
    	border-bottom: 1px solid #ef962d38;
    	vertical-align: middle;
   	    border-top: none;
	}
	.board_section td:nth-child(2){
		text-align:left;
	}
	.table_row_top_article{
		background-color: #ff98003b;
    	border-collapse: collapse;
	}
	.article_title_span{
	    display: inline-block;
    	line-height: 20px;
    	vertical-align: middle;
    	margin: 3px 0 7px;
   	    font-size: 17px;
	}
	.search_div{
        display: inline-block;
    	margin-right: 20px;
    	margin-left: 115px;
    	margin-bottom: 10px;
	}
	.board_section select[name=searchCondition]{
        height: 35px;
    	margin: 10px 5px 10px 5px;
    	text-align: center;
    	text-align-last: center;
    	width: 155px;
    	font-family: 'Stylish', sans-serif !important;
	}
	.board_section input[name=searchInput]{
        line-height: 35px;
	    height: 35px;
	    width: 355px;
	    padding-left: 5px;
	    font-family: 'Stylish', sans-serif !important;
	}
	.board_section input[name=searchSubmit]{
	    padding: 7px 20px;
	    background: #ef962d;
	    border: 1px solid #ef962d;
	    font-weight: bold;
	    height: 36px;
	    position: absolute;
	    margin-top: 9px;
	    margin-left: -1px;
	    font-family: 'Stylish', sans-serif !important;
	}
	.board_section .page_navigation_wrap{
        width: 850px;
    	margin: 35px auto;
    	overflow: hidden;
    	text-align: center;
    	font-family: 'Stylish', sans-serif !important;
	}
	.board_section .page_nav_ul{
	    list-style-type: none;
    	margin: 0 auto;
    	overflow: hidden;
    	text-align: center;
    	padding: 0px 0 0 80px;
	}
	.board_section .page_nav_ul li{
		float: left;
    	margin: 0 10px;
    	text-align: center;
    	font-size: 15px;
    	line-height: 36px;
    	width: 36px;	
	}
	.board_section li.page_nav_li a{
		font-size: 18px;
	}
	.board_section .modify_button{
	    color: red !important;
    	font-weight: bold;
    	font-size: 15px;
    	font-family: 'Stylish', sans-serif !important;
	}
	.board_section .delete_button{
		border-style: none;
	    background: transparent;
	    color: #5f5f5f;
	    font-weight: 900;
	    font-size: 13px;
	    font-family: 'Stylish', sans-serif !important;
	}
	.board_section .write_btn{
        float: right;
	    margin-top: 10px;
	    border: 1px solid #c1c0c0;
	    padding: 5px 10px;
	    background-color: #f6f6f6;
	    font-size: 18px;
	    font-family: 'Stylish', sans-serif !important;
	}
	.board_section .table_row_announce_article {
		background: #eeeeee87;
		font-weight:600;
	}
	.board_section .announcement_p{
        border-radius: 20px;
	    background-color: #ff980085;
	    line-height: 20px;
	    width: 50px;
	    text-align: center;
	    margin: 0 auto;
	    font-weight: 900;
	    font-size: 12px;
	}
</style>
     <section class="board_section">
       <div class="table">
         <h2 class="board_name">${board.boardName }게시판</h2>
         <h3 class="board_desc">${board.boardDescription }</h3>
         <table class="board_table">
           <thead>
             <tr class="table_heading">
               <th></th>
               <th>제목</th>
               <th>작성자</th>
               <th>날짜</th>
               <th>조회수</th>
               <c:if test="${member.role == 'ADMIN' }">
               	<th>수정</th>
               	<th>삭제</th>
               </c:if>
             </tr>
           </thead>
           <tbody>
           	<c:if test="${board.ctgId != 4 }">
			   <c:forEach var="list" items="${announcements }">
			   	<tr class="table_row_announce_article">
			   		<td><p class="announcement_p">공지</p></td>
			   		<td>
			   			<c:choose>
	           				<c:when test="${(member.role!='ADMIN' && member.memberLevel >= 2 ) || member.role == 'ADMIN' || (category.ctgReadLevel == 7 && member.memberLevel >=2) }">
	           					<a href="articleDetail.do?boardId=${list.boardId }&articleId=${list.articleId }&curBlock=${curBlock }&pageNum=${pageNum}"> 
	           				</c:when>
	           				<c:otherwise>
	           					<a href="${contextPath }/member/levelCheck.do?boardId=${list.boardId}">
	           				</c:otherwise>
	           			</c:choose>
       						<span class="article_title_span">
       							<span style="color: #747474; margin-right: 10px;">[${list.articleHead }]</span> 
       							${list.articleTitle }
       							<span style="color:red; font-weight:900">[${list.articleCommentCnt }]</span>
   							</span>
       					</a> 
			   		</td>
			   		<td>${list.nickName }</td>
			   		<td>
	              		<fmt:formatDate value="${list.articleDate }" pattern="yyyyMMdd" var="articleDate"/>
               			<fmt:formatDate value="${today }" pattern="yyyyMMdd" var="toDay"/>
	               		<c:if test="${articleDate==toDay }">
	               			<fmt:formatDate value="${list.articleDate }" pattern="HH:mm" />
	               		</c:if>
	               		<c:if test="${articleDate != toDay }">
	               			<fmt:formatDate value="${list.articleDate }" pattern="yyyy-MM-dd" />
	               		</c:if>
               		</td>
			   		<td>${list.articleReadCnt }</td>
			   		<c:if test="${member.role == 'ADMIN' }">
	                	<c:choose>
	                		<c:when test="${member.role == 'ADMIN' && list.nickName == 'admin'}">
			               		<td class="modify_button" ><a style="color:red" href="articleModify.do?articleId=${list.articleId }&boardId=${boardId}">수정</a></td>
			                	<td><button id="deletebutton" class="delete_button" onClick="deleteArticle(${list.articleId})">삭제</button></td>
			                </c:when>
			                <c:otherwise>
			                	<td class="modify_button" ><a style="color:red" href="javascript:alert('본인이 작성한 글만 수정할 수 있습니다!');">수정</a></td>
			                	<td><button id="deletebutton" class="delete_button" onClick="deleteArticle(${list.articleId})">삭제</button></td>
			                </c:otherwise>
				        </c:choose>
			       	</c:if>
			   	</tr>
			   </c:forEach>           
	           <c:if test="${board.topArticleCnt > 0}">
	           	 <c:forEach var="list" items="${topArticles}" begin="0" end="${board.topArticleCnt-1 }" varStatus="status"> 
	           	 	<tr class="table_row_top_article" >
	            		<td>${list.articleId }</td>
	            		<td>
		           			<c:choose>
		           				<c:when test="${(member.role!='ADMIN' && member.memberLevel >= category.ctgReadLevel && category.ctgReadLevel != 0) || member.role == 'ADMIN' }">
		           					<a href="articleDetail.do?boardId=${list.boardId }&articleId=${list.articleId }&curBlock=${curBlock }&pageNum=${pageNum}"> 
		           				</c:when>
		           				<c:otherwise>
		           					<a href="${contextPath }/member/levelCheck.do?boardId=${list.boardId}">
		           				</c:otherwise>
		           			</c:choose>
           						<span class="article_title_span">
           							<span style="color: #747474; margin-right: 10px;">[${list.articleHead }]</span>
           							${list.articleTitle }
           							<span style="color:red; font-weight:900">[${list.articleCommentCnt }]</span>
           						</span>
           					</a> 
	            		</td>
	            		<td>${list.nickName }</td>
	              		<td>
		              		<fmt:formatDate value="${list.articleDate }" pattern="yyyyMMdd" var="articleDate"/>
	               			<fmt:formatDate value="${today }" pattern="yyyyMMdd" var="toDay"/>
		               		<c:if test="${articleDate==toDay }">
		               			<fmt:formatDate value="${list.articleDate }" pattern="HH:mm" />
		               		</c:if>
		               		<c:if test="${articleDate != toDay }">
		               			<fmt:formatDate value="${list.articleDate }" pattern="yyyy-MM-dd" />
		               		</c:if>
	               		</td>
	                	<td>${list.articleReadCnt }</td>
	                	<c:if test="${member.role == 'ADMIN' }">
		                	<c:choose>
		                		<c:when test="${member.role == 'ADMIN' && list.nickName == 'admin'}">
				               		<td class="modify_button" ><a style="color:red" href="articleModify.do?articleId=${list.articleId }&boardId=${boardId}">수정</a></td>
				                	<td><button id="deletebutton" onClick="deleteArticle(${list.articleId})">삭제</button></td>
				                </c:when>
				                <c:otherwise>
				                	<td class="modify_button" ><a style="color:red" href="javascript:alert('본인이 작성한 글만 수정할 수 있습니다!');">수정</a></td>
				                	<td><button id="deletebutton" class="delete_button" onClick="deleteArticle(${list.articleId})">삭제</button></td>
				                </c:otherwise>
					        </c:choose>
				       	</c:if>
	             	</tr>
	           	</c:forEach>
	           </c:if>
	          </c:if>
	          <c:if test="${empty articles }">
	          	<tr class="table_row">
	          		<td colspan="7">
	          			작성된 게시글이 없습니다
	          		</td>
	          	</tr>
	          </c:if>
	           <c:forEach var="list" items="${articles}" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status"> 
	             <tr class="table_row">
             		<td>${list.articleId }</td>
             		<td>
             			<c:choose>
             				<c:when test="${(member.role!='ADMIN' && member.memberLevel >= category.ctgReadLevel && category.ctgReadLevel != 0) || member.role == 'ADMIN' || (category.ctgReadLevel == 7 && member.memberLevel >=2)}">
             					<a href="articleDetail.do?boardId=${boardId }&articleId=${list.articleId }&curBlock=${curBlock }&pageNum=${pageNum}">
             				</c:when>
             				<c:otherwise>
             					<a href="${contextPath }/member/levelCheck.do?boardId=${list.boardId}">
           					</c:otherwise>
             			</c:choose>
             			<c:choose>
             				<c:when test='${list.articleLevel >= 2 }'> 
           						<span class="article_title_span">
            						<span style="color: #747474; margin-right: 10px;">
            							<i style="margin-left: 30px;" class="fas fa-reply"></i>
            							[${list.articleHead }]
            						</span>
            						RE: ${list.articleTitle }
            				</c:when>
            				<c:otherwise>
            					<span class="article_title_span">
           							<span style="color: #747474; margin-right: 10px;">[${list.articleHead }]</span>
           							${list.articleTitle }
            				</c:otherwise>
           				</c:choose>
       							<span style="color:red; font-weight:900">[${list.articleCommentCnt }]</span>
       						</span>
       					</a> 
             		</td>
             		<td>${list.nickName }</td>
               		<td>
               			<fmt:formatDate value="${list.articleDate }" pattern="yyyyMMdd" var="articleDate"/>
               			<fmt:formatDate value="${today }" pattern="yyyyMMdd" var="toDay"/>
	               		<c:if test="${articleDate==toDay }">
	               			<fmt:formatDate value="${list.articleDate }" pattern="HH:mm" />
	               		</c:if>
	               		<c:if test="${articleDate != toDay }">
	               			<fmt:formatDate value="${list.articleDate }" pattern="yyyy-MM-dd" />
	               		</c:if>
               		</td>
	                <td>${list.articleReadCnt }</td>
	                <c:if test="${member.role == 'ADMIN' }">
	                	<td class="modify_button" >
	                		<a style="color:red" href="articleModify.do?articleId=${list.articleId }&boardId=${boardId}">수정</a>
	                	</td>
	                	<td>
	                		<button id="deletebutton" class="delete_button" onClick="deleteArticle(${list.articleId})">삭제</button>
	                	</td>
	                </c:if>
	             </tr>
	           </c:forEach>  
           </tbody>
         </table>
       </div>
       <c:if test="${(member.memberLevel >= category.ctgWriteLevel && category.ctgWriteLevel != 0) || (member.role == 'ADMIN' && board.ctgId != 4) }">
      	<a class="write_btn" href="articleNew.do?boardId=${boardId }"><i class="fas fa-pencil-alt" style="margin-right:15px"></i>글쓰기</a>
       </c:if>
       <c:if test="${not empty articles }">
       <div class="page_navigation_wrap">
         <ul class="page_nav_ul">
         	<c:if test="${curBlock > 0 }">
         		<li class="page_nav_li">
         			<a href="boardMain.do?boardId=${boardId }&curBlock=${curBlock-1 }&prev=prev&pageNum=${pageStart}">&lt;</a>
         		</li>
         	</c:if>
         	<c:if test="${curBlock == 0 }">
         		<li class="page_nav_li"><a href="javascript:alert('더 불러올 게시글이 없습니다!');">&lt;</a></li>
         	</c:if>
         	<c:forEach var="pageIndex" begin="0" end="9" varStatus="idx">
         		<c:choose>
         			<c:when test="${curBlock == 0 }" >
         				<c:if test="${idx.index+1 <= pageCount }">
         					<c:if test="${pageIndex*10 == pageNum }">
	         					<li class="page_nav_li" style="font-weight:bold; border:1px solid #ef962d;">
	         				</c:if>
	         				<c:if test="${pageIndex*10 != pageNum }">
	         					<li class="page_nav_li">
	         				</c:if>
			         			<a href="boardMain.do?boardId=${boardId }&curBlock=${curBlock }&pageNum=${pageIndex*10}">${idx.index +1 }</a>
			         		</li>	
			         	</c:if>
			         	<c:if test="${idx.index+1 > pageCount }">
			         		<li class="page_nav_li">
			         			<a href="javascript:void(0);">${idx.index+1 }</a>
			         		</li>
			         	</c:if>
         			</c:when>
         			
         			<c:otherwise>
         				<c:if test="${(curBlock*10)+idx.index+1 <= pageCount }">
	         				<c:if test="${((pageIndex+1)*10)+curBlock*10*10 == pageNum+10 }">
	         					<li class="page_nav_li" style="font-weight:bold; border:1px solid #ef962d;">
	         				</c:if>
	         				<c:if test="${((pageIndex+1)*10)+curBlock*10*10 != pageNum+10 }">
	         					<li class="page_nav_li">
	         				</c:if>
	         					<a href="boardMain.do?boardId=${boardId }&curBlock=${curBlock }&pageNum=${((pageIndex)*10)+curBlock*10*10}">${(curBlock*10)+(idx.index+1) }</a>
			         		</li>
		         		</c:if>
		         		<c:if test="${(curBlock*10)+idx.index+1 > pageCount }">
			         		<li class="page_nav_li">
			         			<a href="javascript:void(0);">${(curBlock*10)+idx.index+1 }</a>
			         		</li>
			         	</c:if>
         			</c:otherwise>
         		</c:choose>
         	</c:forEach>
         	<c:choose>
	         	<c:when test="${pageCount/10 > curBlock+1 }">
	         		<li class="page_nav_li">
	         			<a href="boardMain.do?boardId=${boardId }&curBlock=${curBlock+1 }&pageNum=${pageEnd}">&gt;</a>
	         		</li>
	         	</c:when>
	         	<c:otherwise>
	         		<li class="page_nav_li">
	         			<a href="javascript:alert('더 불러올 게시글이 없습니다!');">&gt;</a>
	         		</li>
	         	</c:otherwise>
         	</c:choose>
         </ul>
        </div>
        <c:if test="${board.ctgId != 0 }">
	        <div id="search" class="search_div">
		       <form id="search_form" name="search_form" action="articleSearch.do" method="post">
		       		<input type="hidden" value="${board.boardName }" name="articleCategory">
		        	<select name="searchCondition">
		        		<option value="articleTitle" <c:out value="${searchCondition == 'articleTitle'? 'selected':'' }"/> >제목</option>
		        		<option value="nickName" <c:out value="${searchCondition == 'nickName'? 'selected':'' }"/>>작성자</option>
		        		<option value="articleHead" <c:out value="${searchCondition == 'articleHead' ? 'selected' : '' }"/>>말머리</option>
		        		<option value="tag" <c:out value="${searchCondition == 'tag' ? 'selected' : '' }"/>>태그</option>
		        		<option value="articleContent" <c:out value="${searchCondition == 'articleContent'? 'selected':'' }"/>>내용</option>
		        		<option value="contentTitle" <c:out value="${searchCondition == 'contentTitle'? 'selected':'' }"/>>제목+내용</option>
		        		<option value="all" <c:out value="${searchCondition == 'all'? 'selected':'' }"/>>제목+작성자+내용</option>
		        		<option value="commentContent" <c:out value="${searchCondition == 'commentContent' ? 'selected':'' }" />>댓글</option>
		        		<option value="commentNickName" <c:out value="${searchCondition == 'commentNickName' ? 'selected': '' }" />>댓글 작성자</option>
		        	</select>
		        	<input type="text" name="searchInput" value="${searchInput}" class="board_search_searchInput"/>
		        	<input type="submit" name="searchSubmit" value="검색">
		        </form>
	       </div>
       </c:if>
       </c:if>
     </section>
     <script type="text/javascript">
	     $( document ).ready(function() {
	  		var url = location.search;
	  		var params = new URLSearchParams(url);
	  		if ("${curBlock}" == 0 && "${pageCount}" != "0" && !params.has("pageNum")){
	  			document.querySelectorAll("li.page_nav_li")[1].style.fontWeight = 900;
	      		document.querySelectorAll("li.page_nav_li")[1].style.border = '1px solid #ef962d';
	  		}
	  		if ("${levelUp}"){
	  			alert("등업 되셨습니다!");
	  		}
	 	});
	     $("input[name=searchSubmit]").click(function(e){
	 		if ($(".board_search_searchInput").val() == ""){
	 			alert("검색어를 입력하세요!");
	 			document.search_form.searchInput.focus();
	 			return false;
	 		}
	 	});
	     
	     function deleteArticle(id){
	    	 $.ajax({
				url : 'delete.do?articleId='+id,
				type : 'delete',
				success : function(data){
					if (data.trim()=='delete_success'){
						alert('삭제되었습니다!!');
						location.reload();
					}
				}
			});
	     }
     </script>
