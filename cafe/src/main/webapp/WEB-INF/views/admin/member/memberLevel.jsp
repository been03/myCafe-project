<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  /> 
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
		.member_level_wrap{
		    width: 920px;
    		margin: 50px auto;
		}
		.member_level_wrap h2{
		    font-size: 30px;
		}
		.member_level_form{
		    width: 850px;
    		margin: 0 auto;
		}
		.member_level_form table{
			width: 100%;
    		border-collapse: collapse;
		}
		.member_level_table thead > tr{
		    border-bottom: 3px solid #ef962d;
    		border-top: 3px solid #ef962d;
    		line-height: 30px;
    		background: antiquewhite;
		}
		.member_level_table tbody tr{
		    line-height: 30px;
    		text-align: center;
		}
		.member_level_table input {
			border:none;
			font-weight:bold;
			font-family: 'Poor Story', cursive !important;
			text-align: center;
		}
		
		.member_level_form input[type=submit], .member_level_form input[type=reset]{
			font-weight:bold;
			font-family: 'Poor Story', cursive !important;
			border: 1px solid #ef962d;
			background: #ef962d;
			padding: 5px 15px;
		}
		.member_level_btns_wrap{
			text-align:right;
			margin-top:20px;
		}
	</style>
	<div class="member_level_wrap">
	<h2>회원등급 관리</h2>
		<form id="memberLevel_form" name="memberLevel_form" class="member_level_form" method="post">
			<table class="member_level_table">
				<thead>
					<tr>
						<th>등급명</th>
						<th colspan="7">등업조건 설정</th>
					</tr>
				<thead>
				<tbody>
					<c:forEach var="level" items="${level }" varStatus="status">
						<c:if test="${level.levelNo == 2}">
							<tr>
								<td><input type="text" value="${level.levelName}" name="levelName" id="levevlName" title="등급이름을 작성해주세요. 최대 8자입니다."></td>
								<td colspan="7" style="text-align:center;">가입 후 기본 등급</td>
							</tr>
						</c:if>
						<c:if test="${level.levelNo > 2}">
						<tr>
							<td><input type="text" value="${level.levelName }" name="levelName_${level.levelNo}" id="levelName" maxLength="8" title="등급이름을 작성해주세요. 최대 8자입니다."></td>
							<td>게시글</td>
							<td><input type="number" value="${level.articleCnt }" min="0" max="100" name="articleCnt_${level.levelNo}" id="articleCnt" title="등급조건을 정해주세요. 최소 0 최대 100입니다."></td>
							<td>개, 댓글</td>
							<td><input type="number" value="${level.commentCnt }" min="0" max="100" name="commentCnt_${level.levelNo}" id="commentCnt" title="등급조건을 정해주세요. 최소 0 최대 100입니다."></td>
							<td>개, 방문</td>
							<td><input type="number" value="${level.visitCnt }" min="0" max="100" name="visitCnt_${level.levelNo}" id="visitCnt" title="등급조건을 정해주세요. 최소 0 최대 100입니다."></td>
							<td>회</td>
						</tr>
						</c:if>
					</c:forEach>
				</tbody>	
			</table>
			<div class="member_level_btns_wrap">
				<input type="submit" value="저장" name="save">
				<input type="reset" value="취소">
			</div>
		</form>
	</div>
	<script>
		$("input[name=save]").click(function(e){
			e.preventDefault();
			var confirm_val = confirm("설정을 저장하시겠습니까?");
			//var formData = new FormData($("#memberLevel_form")[0]);
			var formData = new FormData();
			var array1 = new Array();
			array1.push($("input[name=levelName]").val());
			formData.append("level2",array1);
			 
			var array2 = new Array();
			array2.push($("input[name=levelName_3]").val());
			array2.push($("input[name=articleCnt_3]").val());
			array2.push($("input[name=commentCnt_3]").val());
			array2.push($("input[name=visitCnt_3]").val());
			formData.append("level3",array2);
			 
			var array3 = new Array();
			array3.push($("input[name=levelName_4]").val());
			array3.push($("input[name=articleCnt_4]").val());
			array3.push($("input[name=commentCnt_4]").val());
			array3.push($("input[name=visitCnt_4]").val());
			formData.append("level4",array3);
			 
			var array4 = new Array();
			array4.push($("input[name=levelName_5]").val());
			array4.push($("input[name=articleCnt_5]").val());
			array4.push($("input[name=commentCnt_5]").val());
			array4.push($("input[name=visitCnt_5]").val());
			formData.append("level5",array4);
			 
			var array5 = new Array();
			array5.push($("input[name=levelName_6]").val());
			array5.push($("input[name=articleCnt_6]").val());
			array5.push($("input[name=commentCnt_6]").val());
			array5.push($("input[name=visitCnt_6]").val());
			formData.append("level6",array5);
			 
			//alert(formData);
			$.ajax({
				url : "levelManage.do",
				type : 'POST',
			    contentType:false,
			    processData:false,
			    cache:false,
			    data : formData,
			    success : function(data){
					alert("등급설정저장을 성공했습니다.");
			    	location.href = "memberLevel.do";
			     },
				error : function() {
					alert("등급설정저장에 실패했습니다.");
			    }
			});
		});
	</script>
<!-- </body>
</html> -->