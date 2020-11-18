<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />   

	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
		.board_section a{
			color:black;
			text-decoration:none;
			font-size: 16px;
		}
		.board_section{
	        width: 920px;
	    	margin: 0 auto;
	    	font-family: 'Poor Story', cursive !important;
		}
		.board_table_wrap{
		    min-height: 700px;
		    font-family: 'Poor Story', cursive !important;
		}
		.board_table{
			border-collapse: collapse;
			width: 100%;
	    	line-height: 30px;
	    	border-top: 3px solid orange;
	    	border-bottom: 3px solid orange;
	    	font-size:13px;
		}
		.board_table thead{
			border-bottom: 1px solid orange;
			font-size:15px;
		}
		.board_table thead > tr{
		    background-color: #ff8c0099;
	    	color: white;
	    	line-height: 45px;
		}
		.board_table th:first-child{
			width: 80px;
		}
		.board_table th:nth-child(2){
	        width: 450px;
		}
		.board_table tbody{
			text-align:center;
		    font-size: 15px;
	    	font-weight: bold;
		}
		.board_table td{
		    line-height: 35px;
	    	padding: 5px;
	    	border-bottom: 1px solid #ffa50038;
	    	vertical-align: middle;
		}
		.board_table td:nth-child(2){
			text-align:left;
		}
		.article_title_span{
		    display: inline-block;
	    	line-height: 20px;
	    	vertical-align: middle;
	    	margin: 3px 0 7px;
		}
		.search_form{
		    background-color: #ef962d17;
	    	margin-top: 30px;
	    	margin-bottom: 65px;
	    	font-family: 'Poor Story', cursive !important;
		}
		.article_category_div{
		    display: inline-block;
	    	margin-left: 20px;
		}
		.search_div{
		    display: inline-block;
	   		margin-right: 20px;
		}
		.sort_num_div{
	    	float: right;
	    	margin: 88px 0 5px 0;
		}
		.search_form select[name=articleCategory]{
	        width: 200px;
	    	text-align: center;
	    	text-align-last: center;
	    	height: 35px;
	    	vertical-align: inherit;
		}
		.search_form select[name=searchCondition]{
	        height: 35px;
	    	margin: 10px 5px 10px 5px;
	    	text-align: center;
	    	text-align-last: center;
	    	width: 155px;
		}
		.search_form input[name=searchInput]{
	        line-height: 35px;
	    	height: 35px;
	    	width: 420px;
	    	padding-left: 5px;
		}
		.search_form input[name=searchSubmit]{
		    padding: 7px 20px;
		    background: #ef962d;
		    border: 1px solid #ef962d;
		    font-weight: bold;
		    height: 36px;
		    position: absolute;
		    margin-top: 9px;
		    margin-left: -1px;
		}
		.search_form select[name=sortNum]{
		    height: 25px;
	    	text-align: center;
	    	text-align-last: center;
	    	width: 70px;
		}
		.page_navigation_wrap{
	        width: 850px;
	    	margin: 35px auto;
	    	overflow: hidden;
	    	text-align: center;
		}
		.page_nav_ul{
		    list-style-type: none;
	    	margin: 0 auto;
	    	overflow: hidden;
	    	text-align: center;
	    	padding: 0px 0 0 80px;
		}
		.page_nav_ul li{
			float: left;
	    	margin: 0 10px;
	    	text-align: center;
	    	font-size: 15px;
	    	line-height: 36px;
	    	width: 36px;	
		}
	</style>
     <section class="board_section">
     <form id="search_form" name="search_form" class="search_form" method="post">
	  	 <div id="articleCategory_div" class="article_category_div">
			<select id="articleCategory_select" name="articleCategory" >
	 	 		<option value="all">전체글보기</option>
	 	 		<c:forEach var="board" items="${boardList }">
	 	 			<c:if test="${board.ctgId > 1 }">
	 	 				<option value="${board.boardName }" <c:out value="${articleCategory == board.boardName ? 'selected': '' }"/> >${board.boardName }</option>
	 	 			</c:if>
	 	 		</c:forEach>
			</select>
 	 	</div>
       	<div id="search" class="search_div">
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
        	<input type="text" name="searchInput" value="${searchInput}" class="search_div_searchInput"/>
        	<input type="submit" name="searchSubmit" value="검색">
        </div>
        <div id="sort" class="sort_num_div">
        	<select name="sortNum">
	        	<c:forEach var="num" begin="10" end="50" step="10">
	         		<option value="${num }" <c:out value="${sortNum == num? 'selected':'' }"/> >${num }개</option>
	         	</c:forEach>
        	</select>
        </div>
       </form>
       <div class="board_table_wrap">
         <table class="board_table">
           <thead>
             <tr class="table_heading">
               <th></th>
               <th>제목</th>
               <th>작성자</th>
               <th>작성일</th>
               <th>조회</th>
             </tr>
           </thead>
           <tbody>
	           <c:forEach var="list" items="${articles}" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status"> 
	             	<tr class="table_row">
	             		<td>${list.articleId }</td>
						<td>
           					<a href="articleDetail.do?boardId=${list.boardId }&articleId=${list.articleId }"> 
           					<c:choose>
	             				<c:when test='${list.parentId > 0 }'> 
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
	               		<td><fmt:formatDate value="${list.articleDate }" pattern="yyyy-MM-dd"/></td>
		                <td>${list.articleReadCnt }</td>
		             </tr>
	           </c:forEach>
	           <c:if test="${empty articles }">
	           	<tr class="table_row">
	           		<td colspan="5">검색 조건에 해당되는 게시글이 없습니다.</td>
	           	</tr>
	           </c:if>  
           </tbody>
         </table>
       </div>
       <div class="page_navigation_wrap">
         <ul class="page_nav_ul">
         	<c:if test="${curBlock > 0 }">
         		<li class="page_nav_li">
         			<a href="articleSearch.do?searchInput=${searchInput }&searchCondition=${searchCondition }&articleCategory=${articleBoard }&curBlock=${curBlock-1 }&prev=prev&pageNum=${pageStart}&sortNum=${sortNum}">&lt;</a>
         		</li>
         	</c:if>
         	<c:if test="${curBlock == 0 }">
         		<li class="page_nav_li"><a href="javascript:alert('더 불러올 게시글이 없습니다!');">&lt;</a></li>
         	</c:if>
         	<c:forEach var="pageIndex" begin="0" end="9" varStatus="idx">
         		<c:choose>
         			<c:when test="${curBlock == 0 }" >
         				<c:if test="${idx.index+1 <= pageCount }">
         					<c:if test="${pageIndex*sortNum == pageNum }">
	         					<li class="page_nav_li" style="font-weight:bold; border:1px solid #ef962d;">
	         				</c:if>
	         				<c:if test="${pageIndex*sortNum != pageNum }">
	         					<li class="page_nav_li">
	         				</c:if>
			         			<a href="articleSearch.do?searchInput=${searchInput }&searchCondition=${searchCondition }&articleCategory=${articleBoard }&curBlock=${curBlock }&pageNum=${pageIndex*sortNum}&sortNum=${sortNum}">${idx.index +1 }</a>
			         		</li>	
			         	</c:if>
			         	<c:if test="${idx.index+1 > pageCount }">
			         		<li class="page_nav_li">
			         			<a href="javascript:void(0);">${idx.index+1 }</a>
			         		</li>
			         	</c:if>
         			</c:when>
         			
         			<c:when test="${pageCount > curBlock+1  }" >
         				<c:if test="${(curBlock*10)+idx.index+1 <= pageCount }">
	         				<c:if test="${((pageIndex+1)*sortNum)+curBlock*sortNum*10 == pageNum+sortNum }">
	         					<li class="page_nav_li" style="font-weight:bold; border:1px solid #ef962d;">
	         				</c:if>
	         				<c:if test="${((pageIndex+1)*sortNum)+curBlock*sortNum*10 != pageNum+sortNum }">
	         					<li class="page_nav_li">
	         				</c:if>
	         					<a href="articleSearch.do?searchInput=${searchInput }&searchCondition=${searchCondition }&articleCategory=${articleBoard }&curBlock=${curBlock }&pageNum=${((pageIndex)*sortNum)+curBlock*sortNum*10}&sortNum=${sortNum}">${(curBlock*10)+(idx.index+1) }</a>
			         		</li>
		         		</c:if>
		         		<c:if test="${(curBlock*10)+idx.index+1 > pageCount }">
         					<li class="page_nav_li">
         						<a href="javascript:void(0);">${(curBlock*10)+idx.index+1 }</a>
		         			</li>
			         	</c:if>
         			</c:when>
         		</c:choose>
         	</c:forEach>
         	<c:choose>
	         	<c:when test="${(pageCount/sortNum) > curBlock+1 || (pageCount/sortNum >= 0.5 && curBlock == 0) }">
	         		<li class="page_nav_li">
	         			<a href="articleSearch.do?searchInput=${searchInput }&searchCondition=${searchCondition }&articleCategory=${articleBoard }&curBlock=${curBlock+1 }&pageNum=${pageEnd}&sortNum=${sortNum}">&gt;</a>
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
     </section>
     <script type="text/javascript">
     	$( document ).ready(function() {
     		var url = location.search;
     		var params = new URLSearchParams(url);
     		if ("${curBlock == 0}" && !params.has("pageNum")){
     			document.querySelectorAll("li.page_nav_li")[1].style.fontWeight = 900;
         		document.querySelectorAll("li.page_nav_li")[1].style.border = '1px solid #ef962d';
     		}
    	});
     
	     $("select[name=sortNum]").change(function(){
	    	var sortNum = $("select[name=sortNum]").val();
	    	var articleCategory = $("select[name=articleCategory]").val();
			var url = location.search;
	 	 	var params = new URLSearchParams(url);
				//https://88240.tistory.com/36
				if (params.has("sortNum")){
					params.set("sortNum", sortNum);
					if (params.has("pageNum")){
						params.set("pageNum", "0");
					}
					params.delete("pageNum");
					params.delete("curBlock");
					params.delete("prev");
					document.location.href="${contextPath}/member/articleSearch.do?"+params.toString();
				}else{
					if(!params.has("searchInput")){
						//params.append("searchInput", $("input[name=searchInput]").val());
						params.append("searchInput", document.getElementsByName("searchInput")[1].value);
						params.append("searchCondition", $("select[name=searchCondition]").val());
						params.append("articleCategory", articleCategory);
					}
					params.append("sortNum", sortNum);
					params.delete("pageNum");
					params.delete("curBlock");
					params.delete("prev");
					document.location.href="${contextPath}/member/articleSearch.do?"+params.toString();
				}
	     });
	     
	     $("input[name=searchSubmit]").click(function(e){
	    	 if($(".search_div_searchInput").val() == ""){
	    		 alert("검색어를 입력해주세요!");
	    		 document.search_form.searchInput.focus();
	    		 return false;
	    	 }
	    	 e.preventDefault();
	    	 var url = location.search;
	    	 var params = new URLSearchParams(url);
	    	 var link = document.location.href;
	    	 var para = document.location.href.split("&");
	    	 if (params.has("searchInput")){
				 params.set("searchInput", document.getElementsByName("searchInput")[1].value);
				 params.set("searchCondition", $("select[name=searchCondition]").val());
				 params.set("articleCategory", $("select[name=articleCategory").val());
				 params.delete("pageNum");
				 params.delete("curBlock");
				 params.delete("prev");
				 console.log(params.toString());
				 document.location.href="${contextPath}/member/articleSearch.do?"+params.toString();
	    	 }else{
	    		 $("#search_form").submit();
	    	 }
	     });
     </script>
