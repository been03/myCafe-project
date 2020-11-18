package com.project.mycafe.commons.chatting;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.mycafe.member.vo.MemberVO;

@Controller
public class ChatController {
	
	@RequestMapping(value = "/chatForm", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
		
		MemberVO member = new MemberVO();
		if ((MemberVO)session.getAttribute("member") != null) {
			member = (MemberVO)session.getAttribute("member");
		}else {
			member.setMemberId("guest");
			member.setNickName("익명의 사용자");
		}
		model.addAttribute("member", member);
		
		return "/common/chatForm";
	}
	
}
