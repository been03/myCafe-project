<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />  

	<style>
		.board_section a{
			color:black;
			text-decoration:none;
		}
		.board_section a.selected{
			background-color: #ef962d;
		}
		.board_section{
			width: 920px;
			margin: 20px auto 0;
		}
		.board_section div.tab a{
		    color: black;
		    text-decoration: none;
		    display: inline-block;
		    width: 200px;
		    text-align: center;
		    border: 1px solid #ef962d;
	        line-height: 30px;
	    	font-weight: 900;
		}
		.board_section div.tab a:nth-child(2){
			margin-left:-6px;
		}
		div.table_wrap{
		    padding: 10px;
	        min-height: 700px;
		}
		.table_wrap h2{
			font-size:30px;
		}
		.deleted_form{
			text-align: right;
		}
		.buttons_div{
		    margin-bottom: 10px;
		}
		.buttons_div input[type=submit]{
		    padding: 3px 20px;
	    	background: #ef962d;
	    	border: 1px solid #ef962d;
	    	font-weight: 900;
		}
		.deleted_form select, .deleted_form input{
			font-family: 'Poor Story', cursive !important;
		}
		select[name=searchCondition]{
			height: 25px;
		    width: 85px;
		    text-align-last: center;
		    text-align: center;
		    -ms-text-align-last: center;
		    -moz-text-align-last: center;
		}
		input[name=searchInput]{
		    line-height: 20px;
	    	width: 230px;
	    	display: inline-block;
	    	vertical-align: bottom;
		}
		input[name=searchSubmit]{
		    padding: 3px 20px;
	    	background: #ef962d;
	    	border: 1px solid #ef962d;
	    	font-weight: bold;
		}
		select[name=sortNum]{
			margin-top:10px;
			width: 70px;
			height:25px;
			text-align-last: center;
		    text-align: center;
		    -ms-text-align-last: center;
		    -moz-text-align-last: center;
		}
		.article_table{
		    width: 100%;
	    	text-align: center;
	    	border-collapse: collapse;
	    	margin-top: 10px;
	    	font-size: 16px;
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
		    width: 42px;
	    	line-height: 15px;
		}
		.article_table thead th:nth-child(3) {
		    width: 500px;
	    	word-break: break-word;
	    	line-height: 15px;
		}
		.article_table tbody tr.table_row {
	    	line-height: 30px;
	    	border-bottom: 1px solid #ef962d45;
	   	    font-size: 15px;
	    }
	    .article_table tbody td:nth-child(3){
	    	text-align:left;
	    	line-height: 20px;
	    	padding-left: 10px;
	    }
	    .article_table tbody td:last-child{
	    	color:red;
	    	font-weight:bold;
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
	    }
	    .page_nav_li:first-child{
	    	margin-right: 5px;
	    }
	</style>
    <section class="board_section">
     	<div class="tab">
     	<c:if test="${tabId == 1 }">
     	  <c:set var="tab" value="${tabId }" />	
		  <a href="${contextPath }/admin/articleManageDeleted.do?tabId=1" class="tablinks selected">삭제/스팸 게시글</a>
		  <a href="${contextPath }/admin/articleManageDeleted.do?tabId=2" class="tablinks">삭제/스팸 댓글</a>
		</c:if>
		<c:if test="${tabId == 2 }">
			<c:set var="tab" value="${tabId }" />
		  <a href="${contextPath }/admin/articleManageDeleted.do?tabId=1" class="tablinks">삭제/스팸 게시글</a>
		  <a href="${contextPath }/admin/articleManageDeleted.do?tabId=2" class="tablinks selected">삭제/스팸 댓글</a>
		</c:if>
		</div>
       <div class="table_wrap">
         <h2>삭제글/삭제댓글 관리</h2>
         <form id="deleted_form" class="deleted_form" name="deleted_form" method="post">
	         <div id="buttons" class="buttons_div">
	         	<input type="submit" name="restorebutton" value="복구">
	         	<input type="submit" name="deletebutton" value="영구삭제">
	         </div>
	         <div id="search" class="search_div">
	         	<select name="searchCondition">
	         		<option value="deleteMemberId" <c:out value="${searchCondition == 'deleteMemberId'? 'selected':'' }"/>>작성자</option>
	         		<option value="deleteDate" <c:out value="${searchCondition == 'deleteDate'? 'selected':'' }"/>>작성일</option>
	         	</select>
	         	<c:choose>
		         	<c:when test="${startDate != null }">
		         		<input type="text" name="searchInput" value="${searchInput }" style="display:none;"/>
		         		<input type='date' name='startDate' value="${startDate }"> 
		         		<span id='date'>~</span>
		         		<input type='date' name='endDate' value="${endDate }">
		         	</c:when>
		         	<c:otherwise>
		         		<input type="text" name="searchInput" value="${searchInput }"/>
		         		<input type='date' name='startDate' value="${startDate }" style="display:none;"> 
		         		<span id='date' style="display:none;">~</span>
		         		<input type='date' name='endDate' value="${endDate }" style="display:none;">
		         	</c:otherwise>
	         	</c:choose>
	         	<input type="hidden" name="tabId" value="${tabId }">
	         	<input type="submit" name="searchSubmit" value="검색">
	         </div>
	         <div id="sort" class="sort_div">
	         	<label for ="sortNum">정렬</label>
	         	<select id="sortNum" name="sortNum">
		         	<option value="15" <c:out value="${sortNum == 15? 'selected':'' }"/> >15개</option>
		         	<option value="30" <c:out value="${sortNum == 30? 'selected':'' }"/> >30개</option>
	         	</select>
	         </div>
	         <table class="article_table">
	           <thead>
	             <tr class="table_heading">
	             	<c:choose>
			           <c:when test="${not empty articles && tab == 1}">
			               <th></th>
			               <th>게시글 번호</th>
			               <th>제목</th>
			               <th>작성자</th>
			               <th>날짜</th>
			               <th>조회수</th>
			               <th>상태</th>
		               </c:when>
		               <c:otherwise>
			               <th></th>
			               <th>댓글 번호</th>
			               <th>내용</th>
			               <th>게시글번호</th>
			               <th>작성자</th>
			               <th>날짜</th>
			               <th>상태</th>
		               </c:otherwise>
	               </c:choose>
	             </tr>
	           </thead>
	           <tbody>
	           	 <c:if test="${empty articles && tab == 1 }">
		          	<tr class="table_row">
		          		<td colspan="10">
		          			삭제/스팸 처리된 게시글이 없습니다
		          		</td>
		          	</tr>
		          </c:if>
		          <c:if test="${empty comments && tab == 2}">
		          	<tr class="table_row">
		          		<td colspan="10">
		          			삭제/스팸 처리된 댓글이 없습니다
		          		</td>
		          	</tr>
		          </c:if>
		           <c:choose>
			           <c:when test="${not empty articles }">
				           <c:forEach var="list" items="${articles}" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status"> 
				             <tr class="table_row">
				             	<td><input id="checked_${list.articleId }" type="checkbox" name="checked_${list.articleId }"></td>
				               	<td>${list.articleId }</td>
			             		<td>
			             			<a href="articleDetail.do?boardId=${boardId }&articleId=${list.articleId }">
			             				<c:if test="${list.parentId > 0 }">
			             					RE: ${list.articleTitle }
			             				</c:if>
			             				<c:if test="${list.parentId == 0 }">
			             					${list.articleTitle }
			             				</c:if>
		             				</a>
		             			</td>
			             		<td>${list.nickName }</td>
			               		<td><fmt:formatDate value="${list.articleDate}" pattern="yyyy.MM.dd."></fmt:formatDate></td>
				                <td>${list.articleReadCnt }</td>
				                <c:if test="${list.articleStatus == 'BLOCK' }">
				                	<td>스팸</td>
				                </c:if>
				                <c:if test="${list.articleStatus == 'TRUE' }">
				                	<td>삭제</td>
				                </c:if>
				             </tr>
				           </c:forEach>  
			           </c:when>
			           <c:when test="${not empty comments }">
				           	<c:forEach var="list" items="${comments}" begin="${begin }" end="${end-1 < 0 ? 0 : end-1 }" varStatus="status"> 
					             <tr class="table_row">
					             	<td><input id="checked_${list.commentId }" type="checkbox" name="checked_${list.commentId }"></td>
					               	<td>${list.commentId }</td>
				             		<td><a href="articleDetail.do?boardId=${boardId }&articleId=${list.articleId }">${list.commentContent }</a></td>
				             		<td>${list.articleId }</td>
				             		<td>${list.nickName }</td>
				               		<td><fmt:formatDate value="${list.commentDate}" pattern="yyyy.MM.dd."></fmt:formatDate></td>
				               		<c:if test="${list.commentStatus == 'BLOCK' }">
					                	<td>스팸</td>
					                </c:if>
					                <c:if test="${list.commentStatus == 'TRUE' }">
					                	<td>삭제</td>
					                </c:if>
					             </tr>
					        </c:forEach> 
			           </c:when>
		           </c:choose>
	           </tbody>
	         </table>
         </form>
       </div>
       <div class="page_navigation_wrap">
         <ul class="page_nav_ul">
          <c:choose>
          	<c:when test="${searchInput != null }">
	          	<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin }">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&searchInput=${searchInput }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${end }"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           </c:when>
           <c:when test="${startDate != null }">
           		<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&startDate=${startDate }&endDate=${endDate }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
               	<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&startDate=${startDate }&endDate=${endDate }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${begin }">${curPage+1 }</a></li>
               	<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
               		<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&startDate=${startDate }&endDate=${endDate }&searchCondition=${searchCondition }&sortNum=${sortNum }&pageNum=${end }"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           </c:when>
           <c:otherwise>
           		<c:if test="${begin-sortNum < 0 }">
	           		<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a>
	           	</c:if>
	           	<c:if test="${begin-sortNum >= 0 }">
		       		<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&sortNum=${sortNum }&pageNum=${begin-sortNum }"><i style="color: #ef962d;" class="fas fa-chevron-left"></i></a></li>
	           	</c:if>
           		<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId }&sortNum=${sortNum}&pageNum=${begin}">${curPage+1 }</a></li>
           		<c:if test="${begin+sortNum >= totalNum }">
           			<li class="page_nav_li"><a href="javascript:void(0);"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a>
           		</c:if>
           		<c:if test="${begin+sortNum < totalNum }">
           			<li class="page_nav_li"><a href="articleManageDeleted.do?tabId=${tabId}&sortNum=${sortNum}&pageNum=${end}"><i style="color: #ef962d;" class="fas fa-chevron-right"></i></a></li>
           		</c:if>
           </c:otherwise>
           </c:choose>
         </ul>
       </div>
     </section>
     <script type="text/javascript">
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
  					document.location.href="${contextPath}/admin/articleManageDeleted.do?"+params.toString();
	   			}else{
	   				if (sortNum == 30){
	   					params.append("sortNum", sortNum);
	   				}else{
	   					params.append("sortNum", sortNum);
	   				}
	   				params.delete("pageNum");
	   				document.location.href="${contextPath}/admin/articleManageDeleted.do?"+params.toString();
	   			}
		     });
	     
	     $("input[name=deletebutton]").click(function(e){
	    	e.preventDefault();
	    	if (confirm("정말로 삭제하시겠습니까?")){
		    	$("#buttons").append("<input type='hidden' value='delete' name='buttonClicked'>"); 
		    	$("#buttons").append("<input type='hidden' value='${tabId}' name='tabId'>"); 
		    	var formData = new FormData($("#deleted_form")[0]);
		    	$.ajax({
		    		url:"articleManageDeleted.do",
		    		data : formData,
		    		type:'post',
		    		cache: false,
		    		contentType: false,
		    		processData: false,
		    		success:function(data, textStatus){
		    			alert("영구삭제되었습니다!");
		    			window.location.href="articleManageDeleted.do?tabId=${tabId}";
		    		},error: function(data, textStatus){
		    			alert("문제가 발생했습니다! 다시 시도해주세요!!");
		    		}
		    	});
	    	}
	     });
	     
	     $("input[name=restorebutton]").click(function(e){
	    	e.preventDefault();
	    	if (confirm("정말로 복구하시겠습니까?")){
			    $("#buttons").append("<input type='hidden' value='restore' name='buttonClicked'>"); 
			    $("#buttons").append("<input type='hidden' value='${tabId}' name='tabId'>"); 
			    var link = document.location.href;
				var para = document.location.href.split("&");
		    	var formData = new FormData($("#deleted_form")[0]);
		    	$.ajax({
		    		url:"articleManageDeleted.do",
		    		data : formData,
		    		type:'post',
		    		cache: false,
		    		contentType: false,
		    		processData: false,
		    		success:function(data, textStatus){
		    			alert("복구되었습니다!");
		    			window.location.href="articleManageDeleted.do?tabId=${tabId}";
		    		},error: function(data, textStatus){
		    			alert("문제가 발생했습니다! 다시 시도해주세요!!");
		    		}
		    	});
	    	}
		 });
	     
	     $("select[name=searchCondition]").change(function(){
	    	 var condition = $("select[name=searchCondition]").val();
	    	 if ($("select[name=searchCondition").val() == "deleteDate"){
	    		 $("input[name=searchInput]").css("display", "none");
	    		 $("input[name=searchInput]").attr("disabled", true);
	    		 $("input[name=startDate]").css("display", "inline-block");
	    		 $("input[name=endDate]").css("display", "inline-block");
	    		 $("input[name=startDate]").attr("disabled", false);
	    		 $("input[name=endDate]").attr("disabled", false);
	    		 $("#date").css("display", "inline-block");
	    	 }else{
	    		 $("input[name=searchInput]").css("display", "inline-block");
	    		 $("input[name=searchInput]").attr("disabled", false);
	    		 $("input[name=startDate]").css("display", "none");
	    		 $("input[name=endDate]").css("display", "none");
	    		 $("input[name=startDate]").attr("disabled", true);
	    		 $("input[name=endDate]").attr("disabled", true);
	    		 $("#date").css("display", "none");
	    	 }
	     });
	     
	     $("input[name=searchSubmit]").click(function(e){
	    	 if($("input[name=searchInput]").val() == ""){
	    		 alert("검색어를 입력해주세요!");
	    		 $("input[name=searchInput]").focus();
	    		 return false;
	    	 }
	    	 e.preventDefault();
	    	 var url = location.search;
	    	 var params = new URLSearchParams(url);
	    	 var link = document.location.href;
	    	 var para = document.location.href.split("&");
    		 params.delete("pageNum");
	    	 if ($("select[name=searchCondition").val() == "deleteDate"){
	    		 if (params.has("searchInput")){
	    			 params.set("searchCondition", "deleteDate");
	    			 params.delete("searchInput");
	    			 params.append("startDate", $("input[name=startDate]").val());
	    			 params.append("endDate", $("input[name=endDate]").val());
	    			 document.location.href="${contextPath}/admin/articleManageDeleted.do?"+params.toString();
	    		 }else{
	    			 params.set("startDate", $("input[name=startDate]").val());
	    			 params.set("endDate", $("input[name=endDate]").val());
	    			 params.set("searchCondition", "deleteDate");
	    			 document.location.href="${contextPath}/admin/articleManageDeleted.do?"+params.toString();
	    		 }
	    	 }else {
	    		 if(params.has("startDate")){
	    			 params.delete("startDate");
	    			 params.delete("endDate");
	    			 params.set("searchCondition", "deleteMemberId");
	    			 params.append("searchInput", $("input[name=searchInput]").val());
	    			 document.location.href="${contextPath}/admin/articleManageDeleted.do?"+params.toString();
	    		 }else{
	    			 params.set("searchInput", $("input[name=searchInput]").val());
	    			 params.set("searchCondition", "deleteMemberId");
	    			 document.location.href="${contextPath}/admin/articleManageDeleted.do?"+params.toString();
	    		 }
	    	 }
	     });
     </script>
