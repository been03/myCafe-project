<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />   
<c:set var="requestURI" value="${ param.articleCategory }" />

	<style>
		.board_section a{
			color:black;
			text-decoration:none;
		}
		.board_section{
		    width: 920px;
	    	margin: 0 auto;
		}
		.table_wrap{
		    margin-top: 50px;
	        min-height: 700px;
		}
		.table_wrap h2{
			font-size:30px;
		}
		.manage_form{
			text-align: left;
		}
		.manage_form select, .manage_form input{
			font-family: 'Poor Story', cursive !important;
		}
		select[name=articleCategory]{
		    width: 200px;
	    	text-align: center;
	    	text-align-last: center;
	    	height: 25px;
	    	vertical-align: top;
		}
		input[name=moveSubmit]{
			padding: 3px 20px;
	    	background: #ef962d;
	    	border: 1px solid #ef962d;
	    	font-weight: bold;
		}
		select[name=searchCondition]{
			height: 25px;
		    margin: 10px 5px 10px 0;
		    text-align: center;
		    text-align-last: center;
		}
		input[name=searchInput]{
		    line-height: 20px;
	    	width: 330px;
		}
		input[name=searchSubmit]{
		    padding: 3px 20px;
	    	background: #ef962d;
	    	border: 1px solid #ef962d;
	    	font-weight: bold;
		}
		select[name=sortNum]{
		    height: 25px;
	    	text-align: center;
	    	text-align-last: center;
	    	width: 70px;
		}
		.article_table{
			width: 100%;
		    text-align: center;
	        font-size: 16px;
		    margin: 20px 0;
		    border-collapse: collapse;
		}
		.article_table thead{
			border-top: 3px solid #ef962d;
	    	border-bottom: 2px solid #ef962d;
		}
		.article_table thead tr{
	        line-height: 40px;
	    }
		.article_table thead th:first-child{
			width: 20px;
		}
	    .article_table thead th:nth-child(2){
	        width: 30px;
	    }
	    .article_table thead th:nth-child(3){
	    	width: 460px;
	    }
	    .article_table thead th:nth-child(4){
	        width: 40px;
	    }
	    .article_table thead th:nth-child(5){
	    	width: 105px;
	    }
	    .article_table thead th:nth-child(6), .article_table thead th:nth-child(8), .article_table thead th:nth-child(9){
	    	width: 35px;
	    	line-height: 15px;
	    }
	    .article_table thead th:nth-child(7){
	    	line-height:15px;
	    }
	    .article_table thead th:last-child{
	   	 	width: 30px;
	    }
	    .article_table tbody{
	    	font-size: 15px;
	    }
	    .article_table td:nth-child(3){
	    	text-align: left;
	    	padding-left: 10px;
	    }
	    .article_table tbody tr{
	        border-bottom: 1px solid #ef962d45;
	    }
	    .ban_button, .delete_button, .modify_button{
		    border: none;
		    background: transparent;
		    color: #ef962d;
		    cursor:pointer;
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
	    	line-height:30px;
	    	height:30px;
	    	display: inline-block;
	    }
	    .page_nav_li:first-child{
	    	margin-right: 5px;
	    }
	</style>
     <section class="board_section">
       <div class="table_wrap">
         <h2>게시글 관리</h2>
         <form id="manage_form" name="manage_form" class="manage_form" method="post">
         	 <div id="moveArticle" class="move_article_div">
         	 	<label for="articleCategory_select">게시글 이동</label> 
         	 		<select id="articleCategory_select" name="articleCategory" >
	         	 		<option value="all">전체글보기</option>
	         	 		<option value="공지사항" <c:out value="${articleCategory == '공지사항' ? 'selected':'' }"/> >공지사항</option>
	         	 		<c:forEach var="board" items="${boardList }">
	         	 			<c:if test="${board.ctgId > 1 }">
	         	 				<option value="${board.boardName }" <c:out value="${articleCategory == board.boardName ? 'selected':'' }"/> >${board.boardName }</option>
	         	 			</c:if>
	         	 		</c:forEach>
	         	 	</select>
	         	 	<input type="submit" name="moveSubmit" value="이동" >
         	 </div>
	         <div id="search" class="search_div">
	         	<select name="searchCondition">
	         		<option value="select">선택하세요</option>
	         		<option value="articleTitle" <c:out value="${searchCondition == 'articleTitle'? 'selected':'' }"/> >제목</option>
	         		<option value="nickName" <c:out value="${searchCondition == 'nickName'? 'selected':'' }"/>>작성자</option>
	         		<option value="articleHead" <c:out value="${searchCondition == 'articleHead' ? 'selected' : '' }"/>>말머리</option>
	         		<option value="tag" <c:out value="${searchCondition == 'tag' ? 'selected' : '' }"/>>태그</option>
	         		<option value="articleContent" <c:out value="${searchCondition == 'articleContent'? 'selected':'' }"/>>내용</option>
	         		<option value="contentTitle" <c:out value="${searchCondition == 'contentTitle'? 'selected':'' }"/>>제목+내용</option>
	         		<option value="all" <c:out value="${searchCondition == 'all'? 'selected':'' }"/>>제목+작성자+내용</option>
	         	</select>
	         	<input type="text" name="searchInput" value="${searchInput}"/>
	         	<input type="submit" name="searchSubmit" value="검색">
	         </div>
	         <div id="sort" class="sort_num">
	         	<select name="sortNum">
		         	<option value="15" <c:out value="${sortNum == 15? 'selected':'' }"/> >15개</option>
		         	<option value="30" <c:out value="${sortNum == 30? 'selected':'' }"/> >30개</option>
	         	</select>
	         </div>
	         <table class="article_table">
	           <thead>
	             <tr class="table_heading">
	               <th></th>
	               <th>번호</th>
	               <th>제목</th>
	               <th>작성자</th>
	               <th>날짜</th>
	               <th>조회수</th>
	               <th>종아요수</th>
	               <th>댓글수</th>
	               <th>수정/스팸</th>
	               <th>삭제</th>
	             </tr>
	           </thead>
	           <tbody>
           		 <c:if test="${empty articles }">
		          	<tr class="table_row">
		          		<td colspan="10">
		          			조회된 게시글이 없습니다
		          		</td>
		          	</tr>
		          </c:if>
		           <c:forEach var="list" items="${articles}" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status"> 
			           <c:if test="${list.articleStatus == 'FALSE' }">
			             <tr class="table_row">
			             	<td><input id="checked_${list.articleId }" type="checkbox" name="checked_${list.articleId }"></td>
			               	<td>${list.articleId}</td>
		             		<td>
		             			<a target="_blank" href="${contextPath }/member/articleDetail.do?boardId=${list.boardId }&articleId=${list.articleId }">
		             				<c:if test="${list.parentId > 0 }">
		             					RE: ${list.articleTitle }
		             				</c:if>
		             				<c:if test="${list.parentId == 0 }">
		             					${list.articleTitle }
		             				</c:if>
		             			</a>
	             			</td>
		             		<td>${list.nickName }</td>
		               		<td><fmt:formatDate value="${list.articleDate}" pattern="yyyy.MM.dd. hh:mm:ss"></fmt:formatDate></td>
			                <td>${list.articleReadCnt }</td>
			                <td>${list.articleLikeCnt }</td>
			                <td>${list.articleCommentCnt }</td>
			                <c:if test="${list.role == 'ADMIN' }">
			                	<td><a class="modify_button" href="${contextPath }/member/articleModify.do?articleId=${list.articleId }&boardId=${list.boardId}"><i class="fas fa-edit"></i></a></td>
			                </c:if>
			                <c:if test="${list.role != 'ADMIN' }">
			                	<td><button id="banbutton" class="ban_button" onClick="blockArticle(${list.articleId})"><i class="fas fa-ban"></i></button></td>
			                </c:if>
			                <td><button id="deletebutton" class="delete_button" onClick="deleteArticle(${list.articleId})"><i class="fas fa-trash-alt"></i></button></td>
			             </tr>
			             </c:if>
		           </c:forEach>  
	           </tbody>
	         </table>
         </form>
       </div>
       <div class="page_navigation_wrap">
         <ul class="page_nav_ul">
           	<c:if test="${begin-sortNum < 0 }">
           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
           	</c:if>
           	<c:if test="${begin-sortNum >= 0 }">
	       		<li class="page_nav_li"><a href="articleManage.do?articleCategory=${articleCategory }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum}&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
           	</c:if>
       		<li class="page_nav_li"><a href="articleManage.do?articleCategory=${articleCategory }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum}&pageNum=${begin}">${curPage+1 }</a></li>
       		<c:if test="${begin+sortNum >= totalNum }">
       			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
       		</c:if>
       		<c:if test="${begin+sortNum < totalNum }">
       			<li class="page_nav_li"><a href="articleManage.do?articleCategory=${articleCategory }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum}&pageNum=${end}"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
       		</c:if>
         </ul>
       </div>
     </section>
     <script type="text/javascript">
	     function deleteArticle(id){
	    	 if (confirm("정말로 삭제하겠습니까?")){
		    	 $.ajax({
					url : '${contextPath}/member/delete.do?articleId='+id,
					type : 'delete',
					success : function(data){
						alert('삭제되었습니다!!');
						var link = document.location.href;
						location.href=link;
					}
				});
	    	 }
	     }
	     
	     function blockArticle(id){
	    	 if (confirm("정말로 스팸처리 하시겠습니까?")){
		    	 $.ajax({
					url : 'blockArticle.do?articleId='+id,
					type : 'put',
					success : function(data){
						alert('스팸처리 완료!!');
						var link = document.location.href;
						location.href=link;
					}
				});
	    	 }
	     }
	     
	     $("select[name=sortNum]").change(function(){
	    	var sortNum = $("select[name=sortNum]").val();
	    	var articleCategory = $("select[name=articleCategory]").val();
   			var url = location.search;
    	 	var params = new URLSearchParams(url);
   			if (params.has("sortNum")){
				params.set("sortNum", sortNum);
				if (params.has("pageNum")){
					params.set("pageNum", "0");
				}
				params.delete("pageNum");
				document.location.href="${contextPath}/admin/articleManage.do?"+params.toString();
   			}else{
   				if (sortNum == 30){
   					params.append("sortNum", sortNum);
   				}else{
   					params.append("sortNum", sortNum);
   				}
   				params.delete("pageNum");
   				document.location.href="${contextPath}/admin/articleManage.do?"+params.toString();
   			}
	     });
	     
	     $("input[name=moveSubmit]").click(function(e){
			e.preventDefault();
			var url = location.search;
			var params = new URLSearchParams(url);
			if ($("input[type=checkbox]:checked").length > 0){
				history.replaceState({}, null, location.pathname);
				$("#manage_form").submit();
			}else{
				if (params.has("articleCategory")){
					params.set("searchInput", $("input[name=searchInput]").val());
					params.set("searchCondition", $("select[name=searchCondition]").val());
					params.delete("sortNum");
					params.delete("pageNum");
					params.set("articleCategory", $("select[name=articleCategory]").val());
					document.location.href="${contextPath}/admin/articleManage.do?"+params.toString();
				}else{
					$("#manage_form").submit();
				}
			}
		 });
	     
	     $("input[name=searchSubmit]").click(function(e){
	    	 e.preventDefault();
	    	 if($("input[name=searchInput]").val() == ""){
	    		 alert("검색어를 입력해주세요!");
	    		 $("input[name=searchInput]").focus();
	    		 return false;
	    	 }
	    	 if($("select[name=searchCondition]").val() == "select"){
	    		 alert("검색범위를 선택해주세요!");
	    		 $("input[name=searchInput]").val("");
	    		 return false;
	    	 }
	    	 
	    	 var url = location.search;
	    	 var params = new URLSearchParams(url);
	    	 var link = document.location.href;
	    	 var para = document.location.href.split("&");
	    	 if (params.has("searchInput")){
    			 params.set("searchInput", $("input[name=searchInput]").val());
    			 params.set("searchCondition", $("select[name=searchCondition]").val());
    			 params.set("articleCategory", $("select[name=articleCategory").val());
    			 params.delete("pageNum");
    			 document.location.href="${contextPath}/admin/articleManage.do?"+params.toString();
	    	 }else{
	    		 $("#manage_form").submit();
	    	 }
	     });
     </script>
