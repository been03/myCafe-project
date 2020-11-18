package com.project.mycafe.member.service;

import java.util.List;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.article.vo.ArticleVO;
import com.project.mycafe.article.vo.CommentVO;
import com.project.mycafe.member.dao.MemberDAO;
import com.project.mycafe.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO memberDAO;

	@Autowired
	private JavaMailSender mailSender;

	public MemberVO selectMemberInfo(String memberId) throws Exception {
		return memberDAO.selectMemberInfo(memberId);
	}
	
	public MemberVO selectMemberInfoNickName(String nickName) throws Exception {
		return memberDAO.selectMemberInfoNickName(nickName);
	}

	// 모든 등급 이름과 등급조건 가져오기
	public List<LevelVO> selectLevelList() throws Exception {
		return memberDAO.selectLevelList();
	}

	// 한등급의 정보 가져오기
	public LevelVO selectLevelOne(int LevelNo) throws Exception {
		return memberDAO.selectLevelOne(LevelNo);
	}

	// 레벨 이름
	public String selectLevelName(int memberLevel) throws Exception {
		return memberDAO.selectLevelName(memberLevel);
	}

	public void updateLevel(MemberVO memberVO) throws Exception {
		memberDAO.updateLevel(memberVO);
	}

	public int selectArticleCnt(String memberId) throws Exception {
		return memberDAO.selectArticleCnt(memberId);
	}

	public int selectCommentCnt(String memberId) throws Exception {
		return memberDAO.selectCommentCnt(memberId);
	}

	public MemberVO selectLoginTime(String memberId) throws Exception {
		return memberDAO.selectLoginTime(memberId);
	}

	public int selectLoginCnt(String memberId) throws Exception {
		return memberDAO.selectLoginCnt(memberId);
	}

	public List<ArticleVO> selectMemberWroteArticle(String memberId) throws Exception {
		return memberDAO.selectMemberWroteArticle(memberId);
	}

	// 한명의 회원이 작성한 게시글 likeCnt 높은순으로 보기
	public List<ArticleVO> selectMemberWroteArticleLikeCnt(String memberId) throws Exception {
		return memberDAO.selectMemberWroteArticleLikeCnt(memberId);
	}

	public List<CommentVO> selectMemberWroteComment(String memberId) throws Exception {
		return memberDAO.selectMemberWroteComment(memberId);
	}

	public MemberVO selectMemberStatus(String memberId) throws Exception {
		return memberDAO.selectMemberStatus(memberId);
	}

	public void updateLoginCnt(MemberVO member) throws Exception {
		memberDAO.updateLoginCnt(member);
	}

	// 아이디 중복 검사(AJAX)
	@Override
	public int checkId(String memberId) throws Exception {
		int result = memberDAO.checkId(memberId);
		return result;
	}

	// 이메일 중복 검사(AJAX)
	public int checkEmail(String email) throws Exception {
		int result = memberDAO.checkEmail(email);
		return result;
	}

	// 닉네임 중복 검사(AJAX)
	@Override
	public int checkNickName(String nickName) throws Exception {
		int result = memberDAO.checkNickName(nickName);
		return result;
	}

	// 회원가입
	@Override
	public void joinMember(MemberVO member) throws Exception {
		memberDAO.joinMember(member);
	}

	// 인증키 생성
	@Override
	public String createKey() throws Exception {
		String key = "";
		Random rd = new Random();
		for (int i = 0; i < 8; i++) {
			key += rd.nextInt(10);
		}
		return key;
	}

	// 이메일 발송
	@Override
	public void sendMail(MemberVO member, String div) throws Exception {
		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "admin@admin.com";
		String fromName = "myCafe";
		String subject = "카페 인증 메일";
		String msg = "";

		if (div.equals("join")) {
			// 회원가입 메일 내용
			subject = "myCafe 회원가입 인증 메일입니다. 메일을 확인하세요";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += member.getMemberId() + "님 회원가입을 환영합니다.</h3>";
			msg += "<div style='font-size: 130%'>";
			msg += "하단의 인증 버튼 클릭 시 정상적으로 회원가입이 완료됩니다.</div><br/>";
			msg += "<form method='post' action='http://localhost:8080/mycafe/member/approvalMember.do'>";
			msg += "<input type='hidden' name='email' value='" + member.getEmail() + "'>";
			msg += "<input type='hidden' name='approval_key' value='" + member.getApproval_key() + "'>";
			msg += "<input type='submit' value='인증'></form><br/></div>";
		} else if (div.equals("find_pw")) {
			subject = "myCafe 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += member.getMemberId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += member.getMemberPwd() + "</p></div>";
		}

		MimeMessage message = mailSender.createMimeMessage();

		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setCc("admin@admin.com"); // 참조
			messageHelper.setFrom(fromEmail, fromName);
			messageHelper.setSubject(subject);
			messageHelper.setTo(member.getEmail());
			messageHelper.setText(msg, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 회원 인증
	@Override
	public int approvalMember(MemberVO member) throws Exception {
		int result = memberDAO.approvalMember(member);
		return result;
	}

	// 로그인
	@Override
	public MemberVO login(MemberVO member) throws Exception {
		member = memberDAO.login(member.getMemberId());
		return member;
	}

	// 아이디 찾기
	@Override
	public String findId(String email) throws Exception {
		String id = memberDAO.findId(email);
		return id;
	}

	// 회원정보 수정
	@Override
	public MemberVO updateMyPage(MemberVO member) throws Exception {
		memberDAO.updateMypage(member);
		return memberDAO.login(member.getMemberId());
	}

	// 비밀번호 변경
	@Override
	public MemberVO updatePw(MemberVO member, String old_pw) throws Exception {
		memberDAO.updatePw(member);
		return memberDAO.login(member.getMemberId());
	}

	// 비밀번호 찾기
	@Override
	public void findPw(MemberVO member) throws Exception {
		memberDAO.updatePw(member);
	}

	public void updateStatusDrop(String memberId) throws Exception {
		memberDAO.updateStatusDrop(memberId);
	}

	// tbl_login에 데이터 삽입
	public void insertLoginData(MemberVO member) throws Exception {
		memberDAO.insertLoginData(member);
	}

	// 글 삭제
	public void deleteArticle(int articleId) throws Exception {
		memberDAO.deleteArticle(articleId);
	}

	// 댓글 삭제
	public void deleteComment(int commentId) throws Exception {
		memberDAO.deleteComment(commentId);
	}

	// 한명의 멤버의 받은 쪽지리스트
	public List<MessageVO> selectMemberMessage(String memberId) throws Exception {
		return memberDAO.selectMemberMessage(memberId);
	}
	
	// 한명의 멤버의 보낸 쪽지리스트
	public List<MessageVO> selectSendMemberMessage(String memberId) throws Exception{
		return memberDAO.selectSendMemberMessage(memberId);
	}
	
	public void updateNickName() throws Exception{
		memberDAO.updateNickName();
	}
	
	public void updateSenderNickName() throws Exception{
		memberDAO.updateSenderNickName();
	}


	// 하나의 쪽지
	public MessageVO selectOneMessage(int messageNo) throws Exception {
		return memberDAO.selectOneMessage(messageNo);
	}

	// 쪽지 읽음으로 상태변경 & 읽은 날짜 넣기
	public void updateMessageStatus(int messageNo) throws Exception {
		memberDAO.updateMessageStatus(messageNo);
	}

	// 로그인 횟수를 보여주는 차트
	@Override
	public List<MemberVO> chartLogin() throws Exception {
		return memberDAO.chartLogin();
	}

	// 가입 횟수를 보여주는 차트
	@Override
	public List<MemberVO> chartRegister() throws Exception {
		return memberDAO.chartRegister();
	}

	// comment하나
	public CommentVO selectOneComment(int commentId) throws Exception {
		return memberDAO.selectOneComment(commentId);
	}
	
	@Override
	public void updateArticleCnt(String memberId) {
		memberDAO.updateArticleCnt(memberId);
	}
	
	@Override
	public void updateCommentCnt(String memberId) {
		memberDAO.updateCommentCnt(memberId);
	}
}