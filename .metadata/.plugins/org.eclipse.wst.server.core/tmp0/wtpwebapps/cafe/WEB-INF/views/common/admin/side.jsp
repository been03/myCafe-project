<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<ul class="ctg_menu_outer_ul" >
	<li class="ctg_menu_outer_li">
		<span><i class="fas fa-scroll" style="margin-right:10px;"></i>카페글</span>
		<ul class="ctg_menu_inner_ul">
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/articleManage.do" title="게시글 관리">
					<span>게시글 관리</span>
				</a>
			</li>
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/articleManageDeleted.do" title="삭제/스팸관리">
					<span>삭제/스팸 관리</span>
				</a>
			</li>
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/articleEventRegister.do" title="이벤트관리">
					<span>이벤트/행사 관리</span>
				</a>
			</li>
		</ul>
	</li>
	<li class="ctg_menu_outer_li">
		<span><i class="fas fa-folder-minus" style="margin-right:10px;"></i>카페메뉴</span>
		<ul class="ctg_menu_inner_ul">
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/categoryManage.do" title="메뉴관리">
					<span>메뉴관리</span>
				</a>
			</li>
		</ul>
	</li>
	<li class="ctg_menu_outer_li">
		<span><i class="fas fa-user-cog" style="margin-right:10px;"></i>카페회원</span>
		<ul class="ctg_menu_inner_ul">
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/memberManage.do" title="전체회원">
					<span>전체회원</span>
				</a>
			</li>
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/memberDataAdmin.do" title="탈퇴/가입제한">
					<span>탈퇴/가입제한</span>
				</a>
			</li>
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/memberLevel.do" title="등급관리">
					<span>등급관리</span>
				</a>
			</li>
			<li class="ctg_menu_inner_li">
				<a href="${contextPath }/admin/messageList.do" title="쪽지관리">
					<span>쪽지관리</span>
				</a>
			</li>
		</ul>
	</li>
</ul>