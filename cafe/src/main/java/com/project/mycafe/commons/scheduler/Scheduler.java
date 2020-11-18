package com.project.mycafe.commons.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.mycafe.admin.member.service.AdminMemberService;

@Component
public class Scheduler {
	@Autowired
	AdminMemberService adminMemberService;

	@Scheduled(cron = "0 00 16 * * *")
					   // 초 분 시
	public void cronTest1() {
		System.out.println("오후 16:00:00에 호출이 됩니다 ");
		adminMemberService.deleteLoginReserved();
		adminMemberService.deleteMemberReserved();
		adminMemberService.deleteReadMsgReserved();
		adminMemberService.deleteUnreadMsgReserved();
		adminMemberService.deleteLoginWaiting();
	}

}
