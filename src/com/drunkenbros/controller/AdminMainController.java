package com.drunkenbros.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.drunkenbros.common.member.BirthSetter;
import com.drunkenbros.common.member.PassSecurity;
import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.service.MemberService;

@Controller
public class AdminMainController {
	private PassSecurity passSecurity;
	@Autowired
	private MemberService memberService;

	public AdminMainController() {
		passSecurity = new PassSecurity();
	}
	
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public ModelAndView adminGoLoginPage(HttpServletRequest request) {
		ModelAndView mav=new ModelAndView("admin/index");
		return mav;
	}
	
	@RequestMapping(value = "/admin/main", method = RequestMethod.GET)
	public ModelAndView adminMainPage(HttpServletRequest request) {
		ModelAndView mav=new ModelAndView("admin/main/index");
		return mav;
	}

	// ================================================================================================
	// 관리자 페이지에서 로그인
	// ================================================================================================
	@RequestMapping(value = "/admin/login", method = RequestMethod.POST)
	public ModelAndView adminLogin(Member member, HttpSession session, HttpServletRequest request) {
		//System.out.println("AdminMemberController/loginCheck 입력한 회원아이디는 : " + member.getId());
		System.out.println("AdminMemberController/loginCheck 입력한 회원비밀번호는 : " + member.getPass());
		
		// 계획 : id와 pass 비교해서 반환값 있으면 로그인, 없으면
		// sql : select id, pass from member where id=#{id} and pass=#{pass}
		member = passSecurity.setHashPass(member);
		System.out.println("AdminMemberController/loginCheck 입력한 회원비밀번호 암호화 결과는 : " + member.getPass());
		Member loginMember = memberService.loginCheck(member);

		ModelAndView mav = new ModelAndView();
		// 로그인할 유저가 있는지 체크
		if (loginMember == null) {
			// 로그인 실패-json값으로 넘기기
			System.out.println("로그인할 유저 아이디나 비번이 없거나 틀립니다.");
			mav.setViewName("redirect:/admin");
			return mav;
		}

		// 로그인하려는 아이디가 관리자인지 체크
		if (loginMember.getAuth().getAuth_id() == 4) {
			// 로그인 실패-json값으로 넘기기
			System.out.println("로그인 하려는 유저가 관리자가 아닙니다.");
			mav.setViewName("redirect:/admin");
			return mav;
		} else {
			// 로그인 성공
			System.out.println("관리자 로그인 성공");
			session.setAttribute("loginAdmin", loginMember);
			mav.setViewName("admin/main/index");
			return mav;
		}
	}

	// ================================================================================================
	// 관리자 로그아웃
	// ================================================================================================
	@RequestMapping(value = "/admin/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("관리자 로그아웃 성공");
		session.invalidate();
		return "redirect:/admin";
	}
}
