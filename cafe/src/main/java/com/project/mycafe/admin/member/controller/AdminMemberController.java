package com.project.mycafe.admin.member.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.mycafe.admin.member.service.AdminMemberService;
import com.project.mycafe.admin.member.vo.LevelVO;
import com.project.mycafe.admin.member.vo.MessageVO;
import com.project.mycafe.member.vo.MemberVO;

@Controller("adminMemberController")
public class AdminMemberController {

	@Autowired
	private AdminMemberService adminMemberService;

	
	@RequestMapping(value = "/admin/messageForm.do")
	public String messageForm(HttpSession session, Model model) throws Exception {
		System.out.println("messageForm");
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		model.addAttribute("loginMember",loginMember);
		return "/admin/member/messageForm";
	}

	@RequestMapping(value = "/admin/messageSend.do", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String messageSend(@RequestParam(required = false) Map<String, String> message, HttpSession session) throws Exception {
		System.out.println("messageSend");
		System.out.println(message);
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		String result = "0"; // 로그인이 안되어 있을 떄 작동하지 않게 하기 위한 변수
		String member = message.get("member");
		String title = message.get("title");
		String content = message.get("content");
		String[] memberList = {};
		if (member.contains(",")) {
			memberList = member.split(",");
		}else {
			memberList = member.split(" ");
		}
		for (int i = 0; i < memberList.length; i++) {
			String s = memberList[i];
			MemberVO m = adminMemberService.selectMemberInfo(s);
			MessageVO messageVO = new MessageVO();
			messageVO.setMemberId(s);
			messageVO.setNickName(m.getNickName());
			messageVO.setMessageTitle(title);
			messageVO.setMessageContent(content);
			messageVO.setSenderNickName(loginMember.getNickName());
			messageVO.setSenderMemberId(loginMember.getMemberId());
			System.out.println("messageVO = " + messageVO);
			adminMemberService.insertMessage(messageVO);
		}
		result = "1";
		return result;
	}

	@RequestMapping(value = "/admin/messageList.do")
	public String messageList(@RequestParam(required = false) Map<String, String> searchMap, Model model,
			HttpSession session, @RequestParam(defaultValue = "15") Integer sortNum, @RequestParam(defaultValue = "0") Integer pageNum) throws Exception {
		System.out.println("admin/messageList");
		List<LevelVO> level = adminMemberService.selectLevelList();
		List<MessageVO> message = adminMemberService.selectAllMessageList();
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		List<MessageVO> msg = new ArrayList<MessageVO>();
		System.out.println(message);
		System.out.println("loginMember = " + loginMember);

		System.out.println("searchMap = " + searchMap);
		System.out.println(searchMap.toString());
		System.out.println("check" + searchMap.containsKey("searchCondition"));
		if (searchMap.containsKey("searchCondition") && !searchMap.get("searchCondition").equals("")) {
			System.out.println("not null searchCondition");
			model.addAttribute("searchCondition", searchMap.get("searchCondition"));
		}

		if (searchMap.containsKey("searchInput") && !searchMap.get("searchInput").equals("")) {
			System.out.println("not null searchInput");
			if (searchMap.get("searchInput") != null) {
				message.clear();
				msg = adminMemberService.searchMessage(searchMap);
				System.out.println("msg" + msg);
				for (int i = 0; i < msg.size(); i++) {
					MessageVO m = adminMemberService.selectOneMessage(msg.get(i).getMessageNo());
					MemberVO member = adminMemberService.selectMemberInfo(m.getMemberId());
					if(searchMap.get("selectStandard").equals("all")) {
						message.add(m);
					}  else { 
						String selectStandard = searchMap.get("selectStandard");
						if (selectStandard.equals("level2")) {
							if (member.getMemberLevel() == 2) {
								message.add(m);
							}
						} else if (selectStandard.equals("level3")){
							if (member.getMemberLevel() == 3) {
								message.add(m);
							}
						} else if (selectStandard.equals("level4")){
							if (member.getMemberLevel() == 4) {
								message.add(m);
							}
						} else if (selectStandard.equals("level5")){
							if (member.getMemberLevel() == 5) {
								message.add(m);
							}
						} else if (selectStandard.equals("level6")){
							if (member.getMemberLevel() == 6) {
								message.add(m);
							}
						}
					}
				}
			}
			model.addAttribute("selectStandard", searchMap.get("selectStandard"));
			model.addAttribute("searchInput", searchMap.get("searchInput"));
		}
		
		int start = 0, end = sortNum, totalCnt = message.size();
		int pageCount = totalCnt / sortNum;

		if (totalCnt % sortNum > 0) {
			pageCount++;
		}

		if (pageNum != null) {
			pageCount = pageNum / sortNum;
			if (pageNum % sortNum > 0) {
				pageCount++;
			}
			for (int i = 0; i <= pageCount; i++) {
				if (pageNum == i * sortNum) {
					start += i * sortNum;
					end = end + start;
					model.addAttribute("curPage", i);
				}
			}
		}
		System.out.println(totalCnt + " " + "start" + start + "end" + end);

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("totalNum", totalCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sortNum", sortNum);

		model.addAttribute("message", message);
		model.addAttribute("level", level);
		model.addAttribute("loginMember", loginMember);
		return "/admin/member/messageList";
	}

	// 쪽지 삭제
	@RequestMapping(value = "/admin/deleteMessage.do", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String deleteMessage(@RequestParam(value = "chbox[]", required = false) List<Integer> chArr)
			throws Exception {
		System.out.println("deleteMessage");
		System.out.println(chArr);
		String result = "0";

		if (chArr != null) {
			for (int i : chArr) {
				MessageVO messageVO = adminMemberService.selectOneMessage(i);
				System.out.println(messageVO);
				System.out.println("읽은 쪽지인지 확인");
				if (messageVO.getMessageStatus().equals("read")) {
					result = "2";
				}
			}
			if (result != "2") {
				for (int i : chArr) {
					MessageVO messageVO = adminMemberService.selectOneMessage(i);
					System.out.println(messageVO);
					System.out.println("안 읽은 쪽지 삭제");
					adminMemberService.deleteMessage(messageVO.getMessageNo());
				}
				result = "1";
			}
		}
		System.out.println("result = " + result);
		return result;
	}

	@RequestMapping(value = "/admin/messageDetail.do")
	public String messageDetail(@RequestParam(required = false) int messageNo, Model model, HttpSession session)
			throws Exception {
		System.out.println("쪽지 자세히 보기");
		MessageVO messageVO = adminMemberService.selectOneMessage(messageNo);
		MemberVO loginMember = (MemberVO) session.getAttribute("member");
		System.out.println(messageVO);
		System.out.println("loginMember = " + loginMember);
		model.addAttribute("msg", messageVO);
		model.addAttribute("loginMember", loginMember);
		return "/admin/member/messageForm";
	}

	@RequestMapping(value = "/admin/memberView.do")
	public String memberView(@RequestParam(required = false) String memberId, Model model) throws Exception {
		System.out.println("/admin/memberView.do");
		System.out.println("memberId=" + memberId);
		MemberVO member = adminMemberService.selectMemberInfo(memberId);
		MemberVO m = adminMemberService.selectMemberStatus(memberId);
		String str = adminMemberService.selectLevelName(m.getMemberLevel());
		m.setLevelName(str);
		member.setStatus(m.getStatus());
		System.out.println("member = " + member.toString());
		model.addAttribute("member", member);
		return "/admin/member/memberView";
	}

	// 전체회원리스트/ 활동중회원 리스트
	@RequestMapping(value = "/admin/memberManage.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String memberManage(@RequestParam(defaultValue = "1") int tabNum,
			@RequestParam(required = false) Map<String, String> searchMap, Model model,
			@RequestParam(defaultValue = "15") Integer sortNum, @RequestParam(defaultValue = "0") Integer pageNum)
			throws Exception {
		List<LevelVO> level = adminMemberService.selectLevelList();
		String lowLevelName = adminMemberService.selectLevelName(2);
		List<MemberVO> mem = new ArrayList<MemberVO>();
		List<MemberVO> member = new ArrayList<MemberVO>();

		System.out.println("searchMap = " + searchMap);
		System.out.println(searchMap.toString());

		System.out.println("tabNum" + tabNum);
		int memberCnt = 0;
		if (tabNum == 1) {
			mem = adminMemberService.selectMemberList();
			memberCnt = mem.size();
			System.out.println("인원수 =" + memberCnt);
			System.out.println(mem.toString());
		} else if (tabNum == 2) {
			mem = adminMemberService.selectInactiveMemberList();
			memberCnt = mem.size();
			System.out.println(mem.toString());
		}

		System.out.println("searchMap = " + searchMap);
		System.out.println(searchMap.toString());
		if (searchMap.containsKey("searchCondition") && !searchMap.get("searchCondition").equals("")) {
			System.out.println("not null searchCondition");
			model.addAttribute("searchCondition", searchMap.get("searchCondition"));
		}
		if (searchMap.containsKey("searchInput") && !searchMap.get("searchInput").equals("")) {
			System.out.println("not null searchInput");
			String str = "";
			int n = 0;
			if (searchMap.get("searchInput") != null) {
				mem.clear();
				member = adminMemberService.searchMember(searchMap);
				System.out.println("member.size = " + member.size());
				System.out.println("member = " + member);
				if (tabNum == 1) {
					for (int i = 0; i < member.size(); i++) {
						MemberVO m = adminMemberService.selectMember(member.get(i).getMemberId());
						System.out.println("member.get(0) = " + member.get(0));
						System.out.println("member.get(0) = " + member.get(1));
						System.out.println("m = "+ m);
						System.out.println("m.getStatus() = " + m.getStatus());
						if(!m.getRole().equals("ADMIN")) {
							if (m.getStatus().equals("active") || m.getStatus().equals("inactive")) {
								str = adminMemberService.selectLevelName(m.getMemberLevel());
								m.setLevelName(str);
								n = adminMemberService.selectLoginCnt(m.getMemberId());
								m.setLoginCnt(n);
								n = adminMemberService.selectArticleCnt(m.getMemberId());
								m.setArticleCnt(n);
								n = adminMemberService.selectCommentCnt(m.getMemberId());
								m.setCommentCnt(n);
								MemberVO memberVO = adminMemberService.selectLoginTime(m.getMemberId());
								m.setLoginTime(memberVO.getLoginTime());
								if(searchMap.get("selectStandard").equals("all")) {
									mem.add(m);
								} else { 
									String selectStandard = searchMap.get("selectStandard");
									if (selectStandard.equals("level2")) {
										if (m.getMemberLevel() == 2) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level3")){
										if (m.getMemberLevel() == 3) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level4")){
										if (m.getMemberLevel() == 4) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level5")){
										if (m.getMemberLevel() == 5) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level6")){
										if (m.getMemberLevel() == 6) {
											mem.add(m);
										}
									}
								}
							}
						}
					}
					memberCnt = mem.size();
					tabNum = 1;
				} else {
					for (int i = 0; i < member.size(); i++) {
						MemberVO m = adminMemberService.selectMember(member.get(i).getMemberId());
						if(!m.getRole().equals("ADMIN")) {
							if (m.getStatus().equals("inactive")) {
								str = adminMemberService.selectLevelName(m.getMemberLevel());
								m.setLevelName(str);
								n = adminMemberService.selectLoginCnt(m.getMemberId());
								m.setLoginCnt(n);
								n = adminMemberService.selectArticleCnt(m.getMemberId());
								m.setArticleCnt(n);
								n = adminMemberService.selectCommentCnt(m.getMemberId());
								m.setCommentCnt(n);
								//loginTime = adminMemberService.selectLoginTime(m.getMemberId());
								MemberVO memberVO = adminMemberService.selectUpdateStatusDate(m.getMemberId());
								m.setUpdateStatusDate(memberVO.getUpdateStatusDate());
								if(searchMap.get("selectStandard").equals("all")) {
									mem.add(m);
								} else { 
									String selectStandard = searchMap.get("selectStandard");
									if (selectStandard.equals("level2")) {
										if (m.getMemberLevel() == 2) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level3")){
										if (m.getMemberLevel() == 3) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level4")){
										if (m.getMemberLevel() == 4) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level5")){
										if (m.getMemberLevel() == 5) {
											mem.add(m);
										}
									} else if (selectStandard.equals("level6")){
										if (m.getMemberLevel() == 6) {
											mem.add(m);
										}
									}
								}
							}
						}
					}
					memberCnt = mem.size();
					tabNum = 2;
				}
			}
			model.addAttribute("selectStandard", searchMap.get("selectStandard"));
			model.addAttribute("searchInput", searchMap.get("searchInput"));
		}

		int start = 0, end = sortNum, totalCnt = mem.size();
		int pageCount = totalCnt / sortNum;

		if (totalCnt % sortNum > 0) {
			pageCount++;
		}

		if (pageNum != null) {
			pageCount = pageNum / sortNum;
			if (pageNum % sortNum > 0) {
				pageCount++;
			}
			for (int i = 0; i <= pageCount; i++) {
				if (pageNum == i * sortNum) {
					start += i * sortNum;
					end = end + start;
					model.addAttribute("curPage", i);
				}
			}
		}
		System.out.println(totalCnt + " " + "start" + start + "end" + end);

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("totalNum", totalCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sortNum", sortNum);

		model.addAttribute("level",level);
		model.addAttribute("mem", mem);
		model.addAttribute("tabNum", tabNum);
		model.addAttribute("memberCnt", memberCnt);
		model.addAttribute("lowLevelName", lowLevelName);

		return "/admin/member/memberManage";
	}

	// 회원 자동등업 조건 설정 & 등급명 설정페이지
	@RequestMapping(value = "/admin/memberLevel.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String memberLevel(Model model) throws Exception {
		System.out.println("등급이름 &자동등업조건 설정페이지");
		List<LevelVO> level = adminMemberService.selectLevelList();
		model.addAttribute("level", level);
		return "/admin/member/memberLevel";
	}

	// 등급이름,자동등업조건 변경
	@RequestMapping(value = "/admin/levelManage.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String levelAdmin(@RequestParam(required = false) Map<String, String> level) throws Exception {
		System.out.println("등급이름,자동등업조건 변경");
		List<LevelVO> levelAll = adminMemberService.selectLevelList();
		System.out.println(level.toString());

		for (LevelVO l : levelAll) {
			int i = l.getLevelNo();
			String levels = "";
			String[] lv;
			if (i == 2) {
				levels = level.get("level2");
				lv = levels.split(",");
				l.setLevelName(lv[0]);
				adminMemberService.updateLevelSet(l);
			} else if (i == 3) {
				levels = level.get("level3");
				lv = levels.split(",");
				l.setLevelName(lv[0]);
				l.setArticleCnt(Integer.parseInt(lv[1]));
				l.setCommentCnt(Integer.parseInt(lv[2]));
				l.setVisitCnt(Integer.parseInt(lv[3]));
				adminMemberService.updateLevelSet(l);
			} else if (i == 4) {
				levels = level.get("level4");
				lv = levels.split(",");
				l.setLevelName(lv[0]);
				l.setArticleCnt(Integer.parseInt(lv[1]));
				l.setCommentCnt(Integer.parseInt(lv[2]));
				l.setVisitCnt(Integer.parseInt(lv[3]));
				adminMemberService.updateLevelSet(l);
			} else if (i == 5) {
				levels = level.get("level5");
				lv = levels.split(",");
				l.setLevelName(lv[0]);
				l.setArticleCnt(Integer.parseInt(lv[1]));
				l.setCommentCnt(Integer.parseInt(lv[2]));
				l.setVisitCnt(Integer.parseInt(lv[3]));
				adminMemberService.updateLevelSet(l);
			} else if (i == 6) {
				levels = level.get("level6");
				lv = levels.split(",");
				l.setLevelName(lv[0]);
				l.setArticleCnt(Integer.parseInt(lv[1]));
				l.setCommentCnt(Integer.parseInt(lv[2]));
				l.setVisitCnt(Integer.parseInt(lv[3]));
				adminMemberService.updateLevelSet(l);
			}
		}

		return "/admin/member/memberLevel";
	}

	// 회원 강제탈퇴
	@RequestMapping(value = "/admin/updateStatusDrop.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateStatusDrop(@RequestParam(value = "chbox[]") List<String> chArr) throws Exception {
		System.out.println("deleteMember");
		String result = "0"; // 로그인이 안되어 있을 떄 작동하지 않게 하기 위한 변수
		if (chArr != null) {
			for (String i : chArr) {
				adminMemberService.updateStatusDrop(i);
			}
			result = "1";
		}
		return result;
	}

	// 회원 등급 변경
	@RequestMapping(value = "/admin/updateLevel.do", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String updateLevel(@RequestParam(value = "chbox[]", required = false) List<String> chArr,
			@RequestParam(value = "level", defaultValue = "1") Integer level) throws Exception {
		System.out.println("updateLevel");
		System.out.println("level=" + level);
		System.out.println(chArr.toString());

		String result = "0";

		if (chArr != null) {
			for (String i : chArr) {
				MemberVO member = adminMemberService.selectMember(i);
				member.setMemberLevel(level);
				System.out.println(member.toString());
				adminMemberService.updateLevel(member);
			}
			result = "1";
		}
		return result;
	}

	// 회원 활동정지 처리
	@RequestMapping(value = "/admin/updateStatusSuspension.do", method = { RequestMethod.POST,
			RequestMethod.GET }, produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String updateStatusSuspension(@RequestParam("chbox[]") List<String> chArr, HttpServletResponse response)
			throws Exception {
		System.out.println("updateStatusSuspension");
		System.out.println(chArr.toString());

		MemberVO member = new MemberVO();
		String result = "0";
		String status = "";
		if (chArr != null) {
			for (String i : chArr) {
				member = adminMemberService.selectMember(i);
				status = member.getStatus();
				if (status.equals("inactive")) {
					result = "2";
				}
			}
			if (!result.equals("2")) {
				for (String i : chArr) {
					adminMemberService.updateStatusSuspension(i);
				}
				result = "1";
			}
		}
		return result;
	}

	// 회원 활동정지 해제
	@RequestMapping("/admin/updateStatusRelease.do")
	@ResponseBody
	public String updateStatusRelease(@RequestParam(value = "chbox[]") List<String> chArr) throws Exception {
		System.out.println("updateStatusRelease");
		System.out.println(chArr.toString());

		String result = "0";
		if (chArr != null) {
			for (String i : chArr) {
				System.out.println("i=" + i);
				adminMemberService.updateStatusRelease(i);
				adminMemberService.updateLowLevel(i);
			}
			result = "1";
		}
		return result;
	}

	// 탈퇴회원 가입제한 / 가입승인 대기 목록
	@RequestMapping(value = "/admin/memberDataAdmin.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String memberDataAdmin(@RequestParam(defaultValue = "1") int tabNum, Model model,
			@RequestParam(required = false) Map<String, String> searchMap,
			@RequestParam(defaultValue = "15") Integer sortNum, @RequestParam(defaultValue = "0") Integer pageNum)
			throws Exception {
		List<MemberVO> member = new ArrayList<MemberVO>();
		List<MemberVO> mem = new ArrayList<MemberVO>();
		System.out.println(member.toString());
		System.out.println("tabNum" + tabNum);
		int memberCnt = 0;
		
		if(tabNum == 1) {
			member = adminMemberService.selectDropMemberList();
			memberCnt = member.size();
		} else if(tabNum == 2) {
			member = adminMemberService.selectWaitingMemberList();
			memberCnt = member.size();
		}

		System.out.println("searchMap = " + searchMap);
		System.out.println(searchMap.toString());
		System.out.println("check" + searchMap.containsKey("searchCondition"));
		if (searchMap.containsKey("searchCondition") && !searchMap.get("searchCondition").equals("")) {
			System.out.println("not null searchCondition");
			model.addAttribute("searchCondition", searchMap.get("searchCondition"));
		}

		if (searchMap.containsKey("searchInput") && !searchMap.get("searchInput").equals("")) {
			System.out.println("not null searchInput");
			if (searchMap.get("searchInput") != null) {
				member.clear();
				mem = adminMemberService.searchMember(searchMap);
				String str = "";
				if (tabNum == 1) {
					for (int i = 0; i < mem.size(); i++) {
						MemberVO m = adminMemberService.selectMember(mem.get(i).getMemberId());
						if (m.getStatus().equals("drop")) {
							str = adminMemberService.selectLevelName(m.getMemberLevel());
							m.setLevelName(str);
							MemberVO memberVO = adminMemberService.selectUpdateStatusDate(m.getMemberId());
							m.setUpdateStatusDate(memberVO.getUpdateStatusDate());
							member.add(m);
						}
					}
					tabNum = 1;
				} else {
					for (int i = 0; i < mem.size(); i++) {
						MemberVO m = adminMemberService.selectMember(mem.get(i).getMemberId());
						if (m.getStatus().equals("waiting")) {
							member.add(m);
							System.out.println("m=" + m);
						}
					}
					tabNum = 2;
				}
			}
			model.addAttribute("searchInput", searchMap.get("searchInput"));
		}

		int start = 0, end = sortNum, totalCnt = member.size();
		int pageCount = totalCnt / sortNum;

		if (totalCnt % sortNum > 0) {
			pageCount++;
		}

		if (pageNum != null) {
			pageCount = pageNum / sortNum;
			if (pageNum % sortNum > 0) {
				pageCount++;
			}
			for (int i = 0; i <= pageCount; i++) {
				if (pageNum == i * sortNum) {
					start += i * sortNum;
					end = end + start;
					model.addAttribute("curPage", i);
				}
			}
		}

		model.addAttribute("begin", start);
		model.addAttribute("end", end);
		model.addAttribute("totalNum", totalCnt);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sortNum", sortNum);

		model.addAttribute("member", member);
		model.addAttribute("tabNum", tabNum);
		model.addAttribute("memberCnt", memberCnt);

		return "/admin/member/memberDataAdmin";
	}

	// 탈퇴회원 데이터 삭제 && 가입 거절
	@RequestMapping(value = "/admin/deleteDropDate.do", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String deleteDropDate(@RequestParam(value = "chbox[]") List<String> chArr) throws Exception {
		System.out.println("deleteDropDate");
		String result = "0";
		if (chArr != null) {
			for (String i : chArr) {
				System.out.println(i);
				adminMemberService.deleteMember(i);
				adminMemberService.deleteTblLoginData(i.toString());
			}
			result = "1";
		}
		return result;
	}

	// 가입 수락
	@RequestMapping(value = "/admin/joinAccept.do", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String joinAccept(@RequestParam(value = "chbox[]") List<String> chArr) throws Exception {
		System.out.println("가입수락");
		String result = "0";
		if (chArr != null) {
			for (String i : chArr) {
				// 회원 Status = active로 변경
				adminMemberService.updateStatusRelease(i);
			}
			result = "1";
		}
		return result;
	}

}
