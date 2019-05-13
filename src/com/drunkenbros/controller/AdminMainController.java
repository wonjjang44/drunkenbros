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
	// ������ ���������� �α���
	// ================================================================================================
	@RequestMapping(value = "/admin/login", method = RequestMethod.POST)
	public ModelAndView adminLogin(Member member, HttpSession session, HttpServletRequest request) {
		//System.out.println("AdminMemberController/loginCheck �Է��� ȸ�����̵�� : " + member.getId());
		System.out.println("AdminMemberController/loginCheck �Է��� ȸ����й�ȣ�� : " + member.getPass());
		
		// ��ȹ : id�� pass ���ؼ� ��ȯ�� ������ �α���, ������
		// sql : select id, pass from member where id=#{id} and pass=#{pass}
		member = passSecurity.setHashPass(member);
		System.out.println("AdminMemberController/loginCheck �Է��� ȸ����й�ȣ ��ȣȭ ����� : " + member.getPass());
		Member loginMember = memberService.loginCheck(member);

		ModelAndView mav = new ModelAndView();
		// �α����� ������ �ִ��� üũ
		if (loginMember == null) {
			// �α��� ����-json������ �ѱ��
			System.out.println("�α����� ���� ���̵� ����� ���ų� Ʋ���ϴ�.");
			mav.setViewName("redirect:/admin");
			return mav;
		}

		// �α����Ϸ��� ���̵� ���������� üũ
		if (loginMember.getAuth().getAuth_id() == 4) {
			// �α��� ����-json������ �ѱ��
			System.out.println("�α��� �Ϸ��� ������ �����ڰ� �ƴմϴ�.");
			mav.setViewName("redirect:/admin");
			return mav;
		} else {
			// �α��� ����
			System.out.println("������ �α��� ����");
			session.setAttribute("loginAdmin", loginMember);
			mav.setViewName("admin/main/index");
			return mav;
		}
	}

	// ================================================================================================
	// ������ �α׾ƿ�
	// ================================================================================================
	@RequestMapping(value = "/admin/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("������ �α׾ƿ� ����");
		session.invalidate();
		return "redirect:/admin";
	}
}
