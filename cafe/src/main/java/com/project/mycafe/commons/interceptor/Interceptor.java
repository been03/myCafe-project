package com.project.mycafe.commons.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.project.mycafe.member.vo.MemberVO;

public class Interceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		MemberVO member = (MemberVO)request.getSession().getAttribute("member");
		if(member != null) {
			System.out.println(request.getContextPath());
			if (member.getRole().equals("ADMIN")) {
				System.out.println("admin입니다");
				return true;
			}else {
				response.sendRedirect(request.getContextPath()+"/member/loginForm.do");
			}
		}else {
			response.sendRedirect(request.getContextPath()+"/member/loginForm.do");
		}
		return false;
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}

}
