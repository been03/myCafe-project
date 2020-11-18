package com.project.mycafe.admin.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.mycafe.admin.member.dao.AdminMemberDAO;
import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.member.vo.MemberVO;

@Service("adminMemberService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminMemberServiceImpl implements AdminMemberService {

	@Autowired
	private AdminMemberDAO adminMemberDAO;
	
	public List<MemberVO> selectMemberList() throws Exception{
		return adminMemberDAO.selectMemberList();
	}
	public List<MemberVO> selectInactiveMemberList() throws Exception{
		return adminMemberDAO.selectInactiveMemberList();
	}

	public List<MemberVO> selectDropMemberList() throws Exception{
		return adminMemberDAO.selectDropMemberList();
	}
	
	public List<MemberVO> selectWaitingMemberList() throws Exception{
		return adminMemberDAO.selectWaitingMemberList();
	}
	
	@Override
	public List<MemberVO> selectPagingMember() throws Exception {
		return adminMemberDAO.selectPagingMember();
	}

	@Override
	public List<MemberVO> memberList() throws Exception {
		return adminMemberDAO.memberList();
	}

	@Override
	public MemberVO selectMemberInfo(String memberId) throws Exception {
		return adminMemberDAO.selectMemberInfo(memberId);
	}

	// 회원 등급의 모든 등급 이름과 등급조건 가져오기
	@Override
	public List<LevelVO> selectLevelList() throws Exception {
		return adminMemberDAO.selectLevelList();
	}

	// 레벨 이름
	@Override
	public String selectLevelName(int memberLevel) throws Exception {
		return adminMemberDAO.selectLevelName(memberLevel);
	}

	@Override
	public MemberVO selectMember(String memberId) throws Exception {
		return adminMemberDAO.selectMember(memberId);
	}

	@Override
	public int selectArticleCnt(String memberId) throws Exception {
		return adminMemberDAO.selectArticleCnt(memberId);
	}

	@Override
	public int selectCommentCnt(String memberId) throws Exception {
		return adminMemberDAO.selectCommentCnt(memberId);
	}

	@Override
	public int selectLoginCnt(String memberId) throws Exception {
		return adminMemberDAO.selectLoginCnt(memberId);
	}

	@Override
	public MemberVO selectLoginTime(String memberId) throws Exception {
		return adminMemberDAO.selectLoginTime(memberId);
	}

	@Override
	public MemberVO selectMemberStatus(String memberId) throws Exception {
		return adminMemberDAO.selectMemberStatus(memberId);
	}

	@Override
	public void deleteMember(String memberId) throws Exception {
		adminMemberDAO.deleteMember(memberId);
	}

	@Override
	public void deleteTblLoginData(String memberId) throws Exception {
		adminMemberDAO.deleteTblLoginData(memberId);
	}

	@Override
	public void updateLevelSet(LevelVO levelVO) throws Exception {
		adminMemberDAO.updateLevelSet(levelVO);
	}

	@Override
	public void updateLevel(MemberVO memberVO) throws Exception {
		adminMemberDAO.updateLevel(memberVO);
	}

	@Override
	public MemberVO selectUpdateStatusDate(String memberId) throws Exception {
		return adminMemberDAO.selectUpdateStatusDate(memberId);
	}

	@Override
	public void updateStatusDrop(String memberId) throws Exception {
		adminMemberDAO.updateStatusDrop(memberId);
	}

	@Override
	public void updateStatusSuspension(String memberId) throws Exception {
		adminMemberDAO.updateStatusSuspension(memberId);
	}

	@Override
	public void updateStatusRelease(String memberId) throws Exception {
		adminMemberDAO.updateStatusRelease(memberId);
	}

	@Override
	public void updateLowLevel(String memberId) throws Exception {
		adminMemberDAO.updateLowLevel(memberId);
	}

	@Override
	public boolean checkPw(String memberId, String memberPwd) {
		return adminMemberDAO.checkPw(memberId, memberPwd);
	}

	// 쪽지 전체 리스트
	@Override
	public List<MessageVO> selectAllMessageList() throws Exception {
		return adminMemberDAO.selectAllMessageList();
	}

	// 쪽지 insert
	@Override
	public void insertMessage(MessageVO messageVO) throws Exception {
		adminMemberDAO.insertMessage(messageVO);
	}

	// 하나의 쪽지
	@Override
	public MessageVO selectOneMessage(int messageNo) throws Exception {
		return adminMemberDAO.selectOneMessage(messageNo);
	}

	// 쪽지 삭제
	@Override
	public void deleteMessage(int messageNo) throws Exception {
		adminMemberDAO.deleteMessage(messageNo);
	}

	@Override
	public void deleteLoginReserved() {
		adminMemberDAO.deleteLoginReserved();
	}

	@Override
	public void deleteMemberReserved() {
		adminMemberDAO.deleteMemberReserved();

	}

	@Override
	public void deleteReadMsgReserved() {
		adminMemberDAO.deleteReadMsgReserved();
	}

	@Override
	public void deleteUnreadMsgReserved() {
		adminMemberDAO.deleteUnreadMsgReserved();

	}

	@Override
	public void deleteLoginWaiting() {
		adminMemberDAO.deleteLoginWaiting();
	}

	@Override
	public List<MemberVO> searchMember(Map<String, String> searchMap) throws Exception {
		return adminMemberDAO.searchMember(searchMap);
	}

	@Override
	public List<MessageVO> searchMessage(Map<String, String> searchMap) throws Exception {
		return adminMemberDAO.searchMessage(searchMap);
	}

}
