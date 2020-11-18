<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
	
<script type="text/javascript" src="${contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	.article_write_section{
	    width: 850px;
    	margin: 30px auto;
    	font-family: 'Poor Story', cursive !important;
	}
	.write_form{
		width: 770px;
    	margin: 0 auto;	
    	padding-top: 10px;
	}
	.write_form label{
        margin: 10px 0px 10px 12px;
    	font-weight: 600;
    	font-size: 15px;
	}
	.write_form label:first-child{
    	margin:0 0 0 12px;
	}
	.write_form input[name=articleTitle]{
        width: 700px;
    	margin: 10px 0px 0 33px;
    	line-height: 20px;
	}
	.write_form input[name=articleWriter], .write_form input[name=articleDate]{
	    margin: 10px 151px 10px 20px;
    	line-height: 20px;
    	border: none;
    	color: #4d4d4d;
    	font-weight: 700;
    	font-size: 13px;
	}
	.write_form select[name=boardName], .write_form select[name=articleHead]{
		width:200px;
	    margin: 0 14px;
    	padding-bottom: 5px;
    	text-align-last: center;
   		text-align: center;
   		-ms-text-align-last: center;
   		-moz-text-align-last: center;
	}
	.tag_wrap{
	    margin-top: 20px;
	}
	.tag_wrap label{
		margin: 0 !important;
	}
	.add_tag_button{
	    border: 1px solid orange;
	    background-color: white;
	    font-weight: bold;
	    color: black;
	    width: 57px;
	    margin-left: -5px;
	    padding: 3px;
	}
	.article_tag_div{
	    font-size: 14px;
	    line-height: 20px;
	    margin-top: 8px;
	    font-weight: 600;
	}
	.article_tag_div span{
		margin-right: 5px;
    	font-size: 13px;
    	font-weight:600;
    	color: blue;
	}
	.write_form input[name=tag]{
        margin: 0 8px 0 15px;
    	width: 600px;
	}
	.write_icon_span{
		position: absolute;
	    margin-left: 702px;
	    margin-top: 15px;
	    color: orange;
	}
	.save_button{
	    border: 1px solid orange;
    	background: transparent;
    	margin-top: 5px;
    	margin-left: 696px;
    	font-weight: 800;
    	text-align: right;
    	padding: 10px 5px 10px 20px;
    	font-size: 12px;
	}
	.warning_p{
	    font-size: 12px;
    	font-weight: 900;
    	color: red;
    	text-align: center;	
    	margin-bottom:50px;
	}
</style>
	<section class="article_write_section">
		<form class="write_form" name="write_form" method="post" action="${contextPath}/member/modify.do" id="frm" enctype="multipart/form-data">
			<div class="boardinfo_wrap">
				<label for="boardName">게시판</label>
				<select id="boardName" name="boardName">
					<c:if test="${member.role != 'ADMIN' }">
						<c:forEach var="list" items="${boardListUser }">
							<option value="${list.boardId }" <c:out value="${list.boardName == article.articleBoard ? 'selected' : '' }"/>>${list.boardName }</option>
						</c:forEach>
					</c:if>
					<c:if test="${member.role == 'ADMIN' }">
						<c:forEach var="list" items="${boardList }">
							<c:if test="${list.ctgId > 1 }">
								<option value="${list.boardId }" <c:out value="${list.boardName == article.articleBoard ? 'selected' : '' }"/>>${list.boardName }</option>
							</c:if>
						</c:forEach>
					</c:if>
				</select>
				
				<label for="boardName">말머리 (필수)</label>
				<select id="articleHead" name="articleHead">
					<c:choose>
						<c:when test="${member.role == 'ADMIN'}">
							<option value="공지" <c:out value="${article.articleHead == '공지'? 'selected':'' }"/> >공지</option>
							<option value="안내" <c:out value="${article.articleHead == '안내'? 'selected':'' }"/> >안내</option>
							<option value="이벤트" <c:out value="${article.articleHead == '이벤트'? 'selected':'' }"/> >이벤트</option>
						</c:when>
						<c:otherwise>
							<option value="음식" <c:out value="${article.articleHead == '음식'? 'selected':'' }"/> >음식</option>
							<option value="여행" <c:out value="${article.articleHead == '여행'? 'selected':'' }"/> >여행</option>
							<option value="교통" <c:out value="${article.articleHead == '교통'? 'selected':'' }"/> >교통</option>
							<option value="질문" <c:out value="${article.articleHead == '질문'? 'selected':'' }"/> >질문</option>
							<option value="정보 공유" <c:out value="${article.articleHead == '정보 공유'? 'selected':'' }"/> >정보 공유</option>
							<option value="팁" <c:out value="${article.articleHead == '팁'? 'selected':'' }"/> >팁</option>
							<option value="홍보" <c:out value="${article.articleHead == '팁'? 'selected':'' }"/> >홍보</option>
							<option value="기타" <c:out value="${article.articleHead == '기타'? 'selected':'' }"/> >기타</option>
						</c:otherwise>
					</c:choose>
				</select>
				
			</div>
			
			<label for="articleTitle">제목<input id="articleTitle" type="text" name="articleTitle" value="${article.articleTitle }" ></label>
	    	<label for="articleWriter">작성자<input id="articleWriter" type="text" name="articleWriter" value="${article.nickName }" ></label>
	    	<label for="articleDate">작성일자<input id="articleDate" type="text" name="articleDate" value="${date }" readOnly> </label>
	    	
	    	<input type="hidden" name="articleId" value="${article.articleId }">
	    	<input type="hidden" name="boardId" value="${boardInfo.boardId }">
	    	
	    	<textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:766px; height:412px;">${article.articleContent }</textarea>
			<div class="tag_wrap">
		    	<label for="tag">태그 추가하기<input id="tag" placeholder="하나씩 입력해주세요. 최대 단어수는 15글자입니다." maxLength="15" type="text" name="tag"></label>
				<input type="button" class="add_tag_button" onClick="addArticleTag()" value="추가">
				<div id="article_tag_div" class="article_tag_div" >태그:  
					<c:forEach items="${tagList }" var="list" varStatus="status">
						<c:if test="${list != 'NONE_TAG' && list != '[NONE_TAG]' }">
							<span id='articleTag${status.index+1}' class='article_tag_span'>${list }
								<i style='margin-left:5px; color:red' class='fas fa-times' onClick='deleteArticleTag(this)'></i>
							</span>
							<input type='hidden' class='article_tag_input' name='articleTag${status.index+1}' value=${list }>
						</c:if>
					</c:forEach>
				</div>
			</div>
    		<p class="warning_p">※저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시글은 이용약관 및 관련법률에 의해 제재를 받으실 수 있습니다.※</p>
	    	<span class="write_icon_span"><i class="fas fa-edit"></i></span><input type="button" class="save_button" id="savebutton" value="수정하기" />
		</form>
	</section>
	<script type="text/javascript">
		$(function(){
			var check = "${member.memberLevel}";
			//쓰기 권한과 상관없이 작성자만이 수정가능
		    if(!("${member.nickName}" == "${article.nickName}")){
		    	$(".article_write_section").css("visibility", "hidden");
		    	alert("해당 게시글의 작성자만이 수정할 수 있습니다!");
		    	window.location.href="${contextPath}/member/boardMain.do?boardId=${boardInfo.boardId}";				
		    }
			
		    //전역변수선언
		    var editor_object = [];
		     
		    nhn.husky.EZCreator.createInIFrame({
		        oAppRef: editor_object,
		        elPlaceHolder: "smarteditor",
		        sSkinURI: "${pageContext.request.contextPath}/resources/smarteditor/SmartEditor2Skin.html",
		        htParams : {
		            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseToolbar : true,            
		            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseVerticalResizer : true,    
		            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		            bUseModeChanger : true,
		        }
		    });
		     
		    
		   	$("#savebutton").click(function(){
		        //id가 smarteditor인 textarea에 에디터에서 대입
		        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
		         
		     	// 이부분에 에디터 validation 검증
		        var form = document.write_form;
		        if (form.articleTitle.value == ""){
		        	alert("제목을 입력해주세요!");
		        	return;
		        }
		        
		        if (form.smarteditor.value == "<p>&nbsp;</p>"){
					alert("내용을 입력해주세요!");
					return;
		        }
		         
		        //폼 submit
		        $("#frm").submit();
		    });
		        
		});
		
	   	function addArticleTag(){
			var form = document.write_form;		
			var articleTag = form.tag.value;
			console.log(articleTag);
			if (articleTag =="NONE_TAG"){
				alert("사용할 수 없는 태그입니다!");
				return;
			}
			if (articleTag == ""){
				alert("태그를 먼저 작성해주세요!");
				return;
			}
			var length = document.getElementsByClassName("article_tag_span").length;
			$("#article_tag_div").append("<span id='articleTag"+(length+1)+"' class='article_tag_span'>"+articleTag+"<i style='margin-left:5px; color:red' class='fas fa-times' onClick='deleteArticleTag(this)'></i></span>");
			$(".write_form").append("<input class='article_tag_input' type='hidden' name='articleTag"+(length+1)+"' value='"+articleTag+"'>");
			form.tag.value = "";
		}
	   	
		function deleteArticleTag(obj){
			console.log(obj.parentElement.id);
			document.getElementsByName(obj.parentElement.id)[0].remove();
			obj.parentElement.remove();
			var tag = document.getElementsByClassName("article_tag_input");
			for (var i=0; i<document.getElementsByClassName("article_tag_input").length; i++){
				tag[i].setAttribute("name", "articleTag"+(i+1));
			}
			
			var tag_span = document.getElementsByClassName("article_tag_span");
			for (var i=0; i<document.getElementsByClassName("article_tag_span").length; i++){
				tag_span[i].setAttribute("id", "articleTag"+(i+1));
			}
		}
		
	</script>
