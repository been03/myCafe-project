package com.project.mycafe.admin.member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.member.vo.MemberVO;

@Repository("adminMemberDAO")
public class AdminMemberDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public List<MemberVO> selectMemberList() throws DataAccessException {
		List<MemberVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectMemberList");
		return list;
	}
	
	public List<MemberVO> selectDropMemberList() throws DataAccessException {
		List<MemberVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectDropMemberList");
		return list;
	}
	
	public List<MemberVO> selectWaitingMemberList() throws DataAccessException {
		List<MemberVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectWaitingMemberList");
		return list;
	}
	
	public List<MemberVO> selectInactiveMemberList() throws DataAccessException {
		List<MemberVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectInactiveMemberList");
		return list;
	}

	public List<MemberVO> selectPagingMember() throws DataAccessException {
		List<MemberVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectPagingMember");
		return list;
	}

	// 회원 리스트
	public List<MemberVO> memberList() throws DataAccessException {
		List<MemberVO> list = (ArrayList) sqlSession.selectList("mappers.member.memberList");
		return list;
	}

	// 한명의 회원 조회
	public MemberVO selectMemberInfo(String memberId) throws DataAccessException {
		return (MemberVO) sqlSession.selectOne("mappers.member.selectMemberInfo", memberId);
	}

	// 회원 등급의 모든 등급 이름과 등급조건 가져오기
	public List<LevelVO> selectLevelList() throws DataAccessException {
		List<LevelVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectLevelList");
		return list;
	}

	// 레벨 이름
	public String selectLevelName(int memberLevel) throws DataAccessException {
		return sqlSession.selectOne("mappers.member.selectLevelName", memberLevel);
	}

	// 한명의 회원 조회
	public MemberVO selectMember(String memberId) throws DataAccessException {
		return (MemberVO) sqlSession.selectOne("mappers.member.selectMember", memberId);
	}

	// 한 회원의 총게시물 수
	public int selectArticleCnt(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		return sqlSession.selectOne("mappers.member.articleCnt", map);
	}

	// 한 회원의 총 코멘트 수
	public int selectCommentCnt(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		return sqlSession.selectOne("mappers.member.commentCnt", map);
	}

	// 한 회원의 총 방문 수
	public int selectLoginCnt(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		int count = (int) sqlSession.selectOne("mappers.member.loginCnt", map);
		return count;
	}

	// 한 회원의 마지막 방문 일
	public MemberVO selectLoginTime(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		return sqlSession.selectOne("mappers.member.loginTime", map);
	}

	// 회원의 활동 상태 보기
	public MemberVO selectMemberStatus(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		return sqlSession.selectOne("mappers.member.selectMemberStatus", memberId);
	}

	// 회원 활동상태 변경 일 - select
	public MemberVO selectUpdateStatusDate(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		return sqlSession.selectOne("mappers.member.selectUpdateStatusDate", map);
	}

	// 회원 삭제
	public void deleteMember(String memberId) throws DataAccessException {
		sqlSession.delete("mappers.member.forceDeleteMember", memberId);
	}

	// 회원의 tbl_login 데이터 삭제
	public void deleteTblLoginData(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		System.out.println(map.get("memberId"));
		sqlSession.delete("mappers.member.deleteTblLoginData", map);
	}

	// 등급의 설정 변경 : 등급이름변경, (방문수,댓글수,게시글수)기준변경
	public void updateLevelSet(LevelVO levelVO) throws DataAccessException {
		sqlSession.update("mappers.member.updateLevelSet", levelVO);
	}

	// 회원의 레벨 변경
	public void updateLevel(MemberVO memberVO) throws DataAccessException {
		sqlSession.update("mappers.member.updateLevel", memberVO);
	}

	// 회원 활동상태 변경 :drop - 강제탈퇴
	public void updateStatusDrop(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("status", "drop");
		System.out.println("drop");
		sqlSession.update("mappers.member.updateStatusDrop", map);
	}

	// 회원 활동 정지 :상태 inactive로 변경
	public void updateStatusSuspension(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("status", "inactive");
		System.out.println("inactive");
		sqlSession.update("mappers.member.updateStatusSuspension", map);
	}

	// 회원 활동정지 해제 :상태 active로 변경
	public void updateStatusRelease(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("status", "active");
		System.out.println("active");
		sqlSession.update("mappers.member.updateStatusRelease", map);
	}

	// 회원 등급을 제일 낮게 변경
	public void updateLowLevel(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		sqlSession.update("mappers.member.updateLowLevel", map);
	}

	public boolean checkPw(String memberId, String memberPwd) {
		boolean result = false;

		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("memberPwd", memberPwd);

		int count = sqlSession.selectOne("mappers.member.checkPw", map);
		if (count == 1) {
			result = true;
		}
		return result;
	}

	// 쪽지 전체 리스트
	public List<MessageVO> selectAllMessageList() throws DataAccessException {
		List<MessageVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectAllMessageList");
		return list;
	}

	// 쪽지 insert
	public void insertMessage(MessageVO messageVO) throws DataAccessException {
		sqlSession.insert("mappers.member.insertMessage", messageVO);
	}

	// 하나의 쪽지
	public MessageVO selectOneMessage(int messageNo) throws DataAccessException {
		return sqlSession.selectOne("mappers.member.selectOneMessage", messageNo);
	}

	// 쪽지 삭제
	public void deleteMessage(int messageNo) throws DataAccessException {
		sqlSession.delete("mappers.member.deleteMessage", messageNo);
	}

	// scheduler -- 탈퇴된 회원은 30일 후 자동 삭제
	public void deleteLoginReserved() {
		sqlSession.delete("mappers.member.deleteLoginReserved");
	}

	// scheduler -- 탈퇴된 회원은 30일 후 자동 삭제
	public void deleteMemberReserved() {
		sqlSession.delete("mappers.member.deleteMemberReserved");
	}

	// scheduler -- 읽은 쪽지는 15일 후 자동 삭제
	public void deleteReadMsgReserved() {
		sqlSession.delete("mappers.member.deleteReadMsgReserved");
	}

	// scheduler -- 안 읽은 쪽지는 30일 후 자동 삭제
	public void deleteUnreadMsgReserved() {
		sqlSession.delete("mappers.member.deleteUnreadMsgReserved");
	}

	// scheduler -- 회원가입 신청 후 1일 지난 계정 삭제
	public void deleteLoginWaiting() {
		sqlSession.delete("mappers.member.deleteLoginWaiting");
	}

	public List<MemberVO> searchMember(Map<String, String> searchMap) {
		List<MemberVO> list = (ArrayList) sqlSession.selectList("mappers.member.searchMember", searchMap);
		System.out.println("검색 조회");
		return list;
	}

	// 쪽지 검색
	public List<MessageVO> searchMessage(Map<String, String> searchMap) {
		List<MessageVO> list = (ArrayList) sqlSession.selectList("mappers.member.searchMessage", searchMap);
		return list;
	}

}
