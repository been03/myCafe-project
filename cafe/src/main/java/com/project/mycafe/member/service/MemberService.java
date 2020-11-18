package com.project.mycafe.member.service;

import java.util.List;

import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.member.vo.MemberVO;

public interface MemberService {
	
	// 한명의 회원 조회 아이디로 : 마이페이지
	public MemberVO selectMemberInfo(String memberId) throws Exception;
	
	// 한명의 회원 조회 닉네임으로: other마이페이지
	public MemberVO selectMemberInfoNickName(String nickName) throws Exception;

	// 모든 등급 이름과 등급조건 가져오기
	public List<LevelVO> selectLevelList() throws Exception;

	// 한등급의 정보 가져오기
	public LevelVO selectLevelOne(int LevelNo) throws Exception;

	// 레벨 이름
	public String selectLevelName(int memberLevel) throws Exception;

	// 회원 등급 변경
	public void updateLevel(MemberVO memberVO) throws Exception;

	// 한명의 회원이 작성한 게시글들 보기
	public List<ArticleVO> selectMemberWroteArticle(String memberId) throws Exception;

	// 한명의 회원이 작성한 게시글 likeCnt 높은순으로 보기
	public List<ArticleVO> selectMemberWroteArticleLikeCnt(String memberId) throws Exception;

	// 한명의 회원이 작성힌 댓글들 보기
	public List<CommentVO> selectMemberWroteComment(String memberId) throws Exception;

	// 한 회원의 총 게시물 수
	public int selectArticleCnt(String memberId) throws Exception;

	// 한 회원의 총 댓글 수
	public int selectCommentCnt(String memberId) throws Exception;

	// 한 회원의 총 방문 일
	public int selectLoginCnt(String memberId) throws Exception;

	// 회원의 상태
	public MemberVO selectMemberStatus(String memberId) throws Exception;

	// 한 회원의 마지막 방문 일
	public MemberVO selectLoginTime(String memberId) throws Exception;

	// 로그인시 loginCnt++
	public void updateLoginCnt(MemberVO member) throws Exception;

	// 닉네임 중복 확인
	public int checkNickName(String nickName) throws Exception;

	public int checkId(String memberId) throws Exception;

	public int checkEmail(String email) throws Exception;

	public void joinMember(MemberVO member) throws Exception;

	public String createKey() throws Exception;

	public void sendMail(MemberVO member, String div) throws Exception;

	public int approvalMember(MemberVO member) throws Exception;

	public MemberVO login(MemberVO member) throws Exception;
	
	public String findId(String email) throws Exception;

	public void findPw(MemberVO member) throws Exception;

	public MemberVO updateMyPage(MemberVO member) throws Exception;

	public MemberVO updatePw(MemberVO member, String old_pw) throws Exception;

	// 회원 활동상태 변경 :drop - 탈퇴시
	public void updateStatusDrop(String memberId) throws Exception;

	// tbl_login에 데이터 삽입
	public void insertLoginData(MemberVO member) throws Exception;

	// 글 삭제
	public void deleteArticle(int articleId) throws Exception;

	// 댓글 삭제
	public void deleteComment(int commentId) throws Exception;

	// 한명의 멤버의 받은 쪽지리스트
	public List<MessageVO> selectMemberMessage(String memberId) throws Exception;
	
	// 한명의 멤버의 보낸 쪽지리스트
	public List<MessageVO> selectSendMemberMessage(String memberId) throws Exception;
	
	public void updateNickName() throws Exception;
	
	public void updateSenderNickName() throws Exception;

	// 하나의 쪽지
	public MessageVO selectOneMessage(int messageNo) throws Exception;

	// 쪽지 읽음으로 상태변경 & 읽은 날짜 넣기
	public void updateMessageStatus(int messageNo) throws Exception;

	public List<MemberVO> chartLogin() throws Exception;

	public List<MemberVO> chartRegister() throws Exception;

	// comment하나
	public CommentVO selectOneComment(int commentId) throws Exception;
	
	public void updateArticleCnt(String memberId);

	public void updateCommentCnt(String memberId);
}