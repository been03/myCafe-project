package com.project.mycafe.admin.member.service;

import java.util.List;
import java.util.Map;

import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.member.vo.MemberVO;

public interface AdminMemberService {
	
	public List<MemberVO> selectMemberList() throws Exception;

	public List<MemberVO> selectInactiveMemberList() throws Exception;

	public List<MemberVO> selectDropMemberList() throws Exception;
	
	public List<MemberVO> selectWaitingMemberList() throws Exception;
	
	public List<MemberVO> selectPagingMember() throws Exception;

	// 회원 리스트
	public List<MemberVO> memberList() throws Exception;

	// 한명의 회원 조회
	public MemberVO selectMemberInfo(String memberId) throws Exception;

	// 회원 등급의 모든 등급 이름과 등급조건 가져오기
	public List<LevelVO> selectLevelList() throws Exception;

	// 레벨 이름
	public String selectLevelName(int memberLevel) throws Exception;

	// 한명의 회원 조회
	public MemberVO selectMember(String memberId) throws Exception;

	// 한 회원의 총 게시물 수
	public int selectArticleCnt(String memberId) throws Exception;

	// 한 회원의 총 댓글 수
	public int selectCommentCnt(String memberId) throws Exception;

	// 한 회원의 총 방문 일
	public int selectLoginCnt(String memberId) throws Exception;

	// 한 회원의 마지막 방문 일
	public MemberVO selectLoginTime(String memberId) throws Exception;

	// 회원의 상태
	public MemberVO selectMemberStatus(String memberId) throws Exception;

	// 회원 삭제
	public void deleteMember(String memberId) throws Exception;

	// 회원의 tbl_login 데이터 삭제
	public void deleteTblLoginData(String memberId) throws Exception;

	// 등급의 설정 변경 : 등급이름변경, (방문수,댓글수,게시글수)기준변경
	public void updateLevelSet(LevelVO levelVO) throws Exception;

	// 회원 등급 변경
	public void updateLevel(MemberVO memberVO) throws Exception;

	// 회원 활동상태 변경 일 - select
	public MemberVO selectUpdateStatusDate(String memberId) throws Exception;

	// 회원 활동상태 변경 :drop - 강제탈퇴
	public void updateStatusDrop(String memberId) throws Exception;

	// 회원 활동 정지 : inactive로 변경
	public void updateStatusSuspension(String memberId) throws Exception;

	// 회원 활동정지 해제 : active로 변경
	public void updateStatusRelease(String memberId) throws Exception;

	// 회원 등급을 제일 낮게 변경
	public void updateLowLevel(String memberId) throws Exception;

	public boolean checkPw(String memberId, String memberPwd);

	// 쪽지 전체 리스트
	public List<MessageVO> selectAllMessageList() throws Exception;

	// 하나의 쪽지
	public MessageVO selectOneMessage(int messageNo) throws Exception;

	// 쪽지 insert
	public void insertMessage(MessageVO messageVO) throws Exception;

	// 쪽지 삭제
	public void deleteMessage(int messageNo) throws Exception;

	public void deleteLoginReserved();

	public void deleteMemberReserved();

	public void deleteReadMsgReserved();

	public void deleteUnreadMsgReserved();

	public void deleteLoginWaiting();

	public List<MemberVO> searchMember(Map<String, String> searchMap) throws Exception;
	
	public List<MessageVO> searchMessage(Map<String, String> searchMap) throws Exception;

}
