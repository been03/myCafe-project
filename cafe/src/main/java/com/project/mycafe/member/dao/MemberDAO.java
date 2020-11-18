package com.project.mycafe.member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.member.vo.MemberVO;

@Repository("memberDAO")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberDAO {

	@Autowired
	SqlSession sqlSession;

	// 한명의 회원 조회 아이디로 : 마이페이지
	public MemberVO selectMemberInfo(String memberId) throws DataAccessException {
		return (MemberVO) sqlSession.selectOne("mappers.member.selectMemberInfo", memberId);
	}
	
	// 한명의 회원 조회 닉네임으로: other마이페이지
	public MemberVO selectMemberInfoNickName(String nickName) throws DataAccessException {
		return (MemberVO) sqlSession.selectOne("mappers.member.selectMemberInfoNickName", nickName);
	}

	// 모든 등급 이름과 등급조건 가져오기
	public List<LevelVO> selectLevelList() throws DataAccessException {
		List<LevelVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectLevelList");
		return list;
	}

	// 한등급의 정보 가져오기
	public LevelVO selectLevelOne(int LevelNo) throws DataAccessException {
		return sqlSession.selectOne("mappers.member.selectLevelOne", LevelNo);
	}

	// 회원의 레벨 변경
	public void updateLevel(MemberVO memberVO) throws DataAccessException {
		sqlSession.update("mappers.member.updateLevel", memberVO);
	}

	// 레벨 이름
	public String selectLevelName(int memberLevel) throws DataAccessException {
		return sqlSession.selectOne("mappers.member.selectLevelName", memberLevel);
	}

	// 한명의 회원이 작성한 게시글들 보기
	public List<ArticleVO> selectMemberWroteArticle(String memberId) throws DataAccessException {
		List<ArticleVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectMemberWroteArticle", memberId);
		return list;
	}

	// 한명의 회원이 작성한 게시글 likeCnt 높은순으로 보기
	public List<ArticleVO> selectMemberWroteArticleLikeCnt(String memberId) throws DataAccessException {
		List<ArticleVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectMemberWroteArticleLikeCnt",
				memberId);
		return list;
	}

	// 한명의 회원이 작성힌 댓글들 보기
	public List<CommentVO> selectMemberWroteComment(String memberId) throws DataAccessException {
		List<CommentVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectMemberWroteComment", memberId);
		return list;
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

	// 회원의 활동 상태 보기
	public MemberVO selectMemberStatus(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		return sqlSession.selectOne("mappers.member.selectMemberStatus", memberId);
	}

	// 한 회원의 마지막 방문 일
	public MemberVO selectLoginTime(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		return sqlSession.selectOne("mappers.member.loginTime", map);
	}

	// 로그인시 loginCnt++
	public void updateLoginCnt(MemberVO member) throws DataAccessException {
		Map map = new HashMap();
		map.put("memberId", member.getMemberId());
		map.put("loginCnt", member.getLoginCnt());
		sqlSession.update("mappers.member.updateLoginCnt", map);
	}

	// 아이디 중복 검사
	public int checkId(String memberId) throws Exception {
		return sqlSession.selectOne("mappers.member.checkId", memberId);
	}

	// 이메일 중복 검사
	public int checkEmail(String email) throws Exception {
		return sqlSession.selectOne("mappers.member.checkEmail", email);
	}

	// 닉네임 중복 검사
	public int checkNickName(String nickName) throws Exception {
		return sqlSession.selectOne("mappers.member.checkNickName", nickName);
	}

	// 회원가입
	@Transactional
	public int joinMember(MemberVO member) throws Exception {
		return sqlSession.insert("mappers.member.joinMember", member);
	}

	// tbl_login에 데이터 삽입
	public void insertLoginData(MemberVO member) throws Exception {
		sqlSession.update("mappers.member.insertLoginData", member);
	}

	// 이메일 인증
	@Transactional
	public int approvalMember(MemberVO member) throws Exception {
		return sqlSession.update("mappers.member.approvalMember", member);
	}

	// 로그인 검사
	public MemberVO login(String memberId) throws Exception {
		return sqlSession.selectOne("mappers.member.login", memberId);
	}

	// 아이디 찾기
	public String findId(String email) throws Exception {
		return sqlSession.selectOne("mappers.member.findId", email);
	}

	// 마이페이지
	@Transactional
	public int updateMypage(MemberVO member) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberName", member.getMemberName());
		map.put("nickName", member.getNickName());
		map.put("telNum", member.getTelNum());
		map.put("imageId", member.getImageId());
		map.put("memberId", member.getMemberId());
		return sqlSession.update("mappers.member.updateMypage", map);
	}

	// 비밀번호 변경
	@Transactional
	public int updatePw(MemberVO member) throws Exception {
		return sqlSession.update("mappers.member.updatePw", member);
	}

	// 회원 활동상태 변경 :drop - 탈퇴시
	public void updateStatusDrop(String memberId) throws DataAccessException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("status", "drop");
		System.out.println("drop");
		sqlSession.update("mappers.member.updateStatusDrop", map);
	}

	// 글 삭제
	public void deleteArticle(int articleId) throws DataAccessException {
		sqlSession.delete("mappers.member.deleteArticle", articleId);
	}

	// 댓글 삭제
	public void deleteComment(int commentId) throws DataAccessException {
		sqlSession.delete("mappers.member.deleteComment", commentId);
	}

	// 한명의 멤버의 받은 쪽지리스트
	public List<MessageVO> selectMemberMessage(String memberId) throws DataAccessException {
		List<MessageVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectMemberMessage", memberId);
		return list;
	}

	// 한명의 멤버의 보낸 쪽지리스트
	public List<MessageVO> selectSendMemberMessage(String memberId) throws DataAccessException {
		List<MessageVO> list = (ArrayList) sqlSession.selectList("mappers.member.selectSendMemberMessage", memberId);
		return list;
	}

	// 닉네임 바꾸기
	public void updateNickName() throws DataAccessException {
		sqlSession.update("mappers.member.updateNickName");
	}

	// 보낸사람 닉네임 바꾸기
	public void updateSenderNickName() throws DataAccessException {
		sqlSession.update("mappers.member.updateNickName");
	}

	// 하나의 쪽지
	public MessageVO selectOneMessage(int messageNo) throws DataAccessException {
		return sqlSession.selectOne("mappers.member.selectOneMessage", messageNo);
	}

	// 쪽지 읽음으로 상태변경 & 읽은 날짜 넣기
	public void updateMessageStatus(int messageNo) throws DataAccessException {
		sqlSession.update("mappers.member.updateMessageStatus", messageNo);
	}

	public List<MemberVO> chartLogin() {
		List<MemberVO> member = (ArrayList) sqlSession.selectList("mappers.member.chartCnt");
		return member;
	}

	public List<MemberVO> chartRegister() {
		List<MemberVO> member = (ArrayList) sqlSession.selectList("mappers.member.newloginCnt");
		return member;
	}

	// comment하나
	public CommentVO selectOneComment(int commentId) throws DataAccessException {
		CommentVO Comment = (CommentVO) sqlSession.selectOne("mappers.member.selectOneComment", commentId);
		return Comment;
	}

	public void updateArticleCnt(String memberId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		sqlSession.update("mappers.member.updateArticleCnt", map);
	}

	public void updateCommentCnt(String memberId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		sqlSession.update("mappers.member.updateCommentCnt", map);
	}

}