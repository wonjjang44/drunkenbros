package com.drunkenbros.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.drunkenbros.common.Pager;
import com.drunkenbros.common.member.BirthSetter;
import com.drunkenbros.common.member.PassSecurity;
import com.drunkenbros.model.domain.Auth;
import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.domain.MemberSearchKeyWord;
import com.drunkenbros.model.service.MemberService;

@Controller
public class MemberController {
	private BirthSetter birth;

	private PassSecurity passSecurity;
	@Autowired
	private MemberService memberService;

	public MemberController() {
		birth = new BirthSetter();
		passSecurity = new PassSecurity();
	}

	/**************************************************************************************************
	 * ������ ������
	 **************************************************************************************************/

	// ================================================================================================
	// ������(admin) ���������� Member ���̺��� List�� ��������
	// ================================================================================================
	@RequestMapping(value = "/admin/member", method = RequestMethod.GET)
	public ModelAndView adminGetList(HttpServletRequest request) {
		System.out.println("MemberController/adminGetList()�� ȣ��");

		List<Member> memberList = memberService.selectAll();
		Pager pager = new Pager();

		pager.init(request, memberList.size(), 10, 10);

		// aop���� proceed() �� �Ѿ�� �� String���·� �Ѿ�ͼ� ModelAndView�� �ƴ� String ������ return �Ϸ���
		// �ؼ� ������ ���� ��!
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/member/member-table"); // ������ jsp �ּ� ���

		mav.addObject("pager", pager);
		mav.addObject("memberList", memberList);

		return mav;
	}

	// ================================================================================================
	// ������(admin) ���������� �˻� ��� ��������
	// ================================================================================================
	@RequestMapping(value = "/admin/member/search", method = RequestMethod.POST)	
	public ModelAndView adminSearchList(HttpServletRequest request, MemberSearchKeyWord searchKey) {
		System.out.println("MemberController/adminSearchList() search_Mode :"+searchKey.getSearch_Mode());
		System.out.println("MemberController/adminSearchList() search_Auth :"+searchKey.getSearch_Auth());
		System.out.println("MemberController/adminSearchList() search_Word :"+searchKey.getSearch_Word());
		
		List memberList=memberService.search(searchKey);

		Pager pager = new Pager();
		pager.init(request, memberList.size(), 10, 10);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/member/member-table"); // ������ jsp �ּ� ���

		mav.addObject("pager", pager);
		mav.addObject("memberList", memberList);

		return mav;
	}

	// ================================================================================================
	// ������(admin) ���������� Member ���� �� ����
	// ================================================================================================
	@RequestMapping(value = "/admin/member/{member_id}", method = RequestMethod.GET) // ��� ������ css ������
	public ModelAndView adminGetDetail(@PathVariable("member_id") int member_id, HttpServletRequest request) {
		Member member = memberService.select(member_id);
		BirthSetter birth = new BirthSetter();
		System.out.println("MemberController/adminGetDetail : " + member_id);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/member/member-detail"); // ������ jsp �ּ� ���
		mav.addObject("member", member); // ����
		mav.addObject("birth", birth);
		// ��ȯ�ּҿ� /�� �ϳ� �� �־ css�� ������ �� ��
		return mav;
	}

	// ================================================================================================
	// ������(admin) ���������� Member ���� �����ϱ�
	// ================================================================================================
	@RequestMapping(value = "/admin/member/edit", method = RequestMethod.POST)
	public String editMember(HttpServletRequest request, Member member) {
		System.out.println("MemberController/adminEditMember() ��û");
		member = passSecurity.setHashPass(member);// ��й�ȣ ��ȣȭ
		Auth auth = new Auth();
		auth.setAuth_id(Integer.parseInt(request.getParameter("auth_id")));
		member.setAuth(auth);
		memberService.update(member);
		return "redirect:/admin/member/" + member.getMember_id();
	}

	// ================================================================================================
	// ������(admin) ���������� Member ���� �����ϱ�
	// ================================================================================================
	@RequestMapping(value = "/admin/member/delete", method = RequestMethod.POST)
	public String deleteMember(int member_id) {
		System.out.println("MemberController/adminDeleteMember() ��û");
		memberService.delete(member_id);
		return "redirect:/admin/member/member-table";
	}

	/**************************************************************************************************
	 * Client ������
	 **************************************************************************************************/

	// ================================================================================================
	// ȸ������
	// ================================================================================================
	@RequestMapping(value = "/member/regist", method = RequestMethod.POST)
	@ResponseBody
	public String memberRegist(Member member) {
		System.out.println("MemberController : ȸ������ ��û!");

		System.out.println("�����Ϸ��� ȸ���� ID : " + member.getId());
		System.out.println("�����Ϸ��� ȸ���� Pass : " + member.getPass());
		System.out.println("�����Ϸ��� ȸ���� name : " + member.getName());
		System.out.println("�����Ϸ��� ȸ���� email : " + member.getEmail());
		System.out.println("�����Ϸ��� ȸ���� birth : " + member.getBirth());
		System.out.println("�����Ϸ��� ȸ���� phonenum : " + member.getPhonenum());

		// ��й�ȣ ��ȣȭ : ��й�ȣ�� ��ȣȭ�ؼ� DB�� �������
		member = passSecurity.setHashPass(member);

		memberService.insert(member);

		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append("\"resultCode\":\"1\",");
		sb.append("\"msg\":\"ȸ�� ���� ����!.\"");
		sb.append("}");
		return sb.toString();
	}

	// ================================================================================================
	// ���̵� �ߺ� üũ
	// ================================================================================================
	@RequestMapping(value = "/member/regist/idoverlap", method = RequestMethod.POST)
	@ResponseBody
	public String IdOverlapCheck(String id) {
		System.out.println("MemberController : ���̵� �ߺ�üũ ��û!");
		String idOverlapChecker = memberService.registCheck(id);

		System.out.println("ȸ�� ID�� : " + id);
		System.out.println("MemberController/idOverlapChecker() �ߺ��Ǵ� ���̵� �ִ°�? : " + idOverlapChecker);

		if (id.equals(idOverlapChecker)) {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			sb.append("\"resultCode\":\"0\",");
			sb.append("\"msg\":\"�ߺ��� ���̵� �Դϴ�.\"");
			sb.append("}");
			return sb.toString();
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			sb.append("\"resultCode\":\"1\",");
			sb.append("\"msg\":\"����� �� �ִ� ���̵� �Դϴ�.\"");
			sb.append("}");
			return sb.toString();
		}
	}

	// ================================================================================================
	// �̸��� �ߺ� üũ
	// ================================================================================================
	// @RequestMapping(value="", method=RequestMethod.POST)
	// @ResponseBody
	// public void emailOverlapCheck() {

	// }

	// ================================================================================================
	// ȸ�� member-login.jsp ���������� �α���
	// ================================================================================================
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	@ResponseBody
	public String login(Member member, HttpSession session) {
		member = passSecurity.setHashPass(member);// üũ���� �α����Ϸ��� ������ �Է��� ��й�ȣ�� ��ȣȭ�ؼ� ������
		System.out.println("MemberController/loginCheck ȸ�����̵�� : " + member.getId());
		System.out.println("MemberController/loginCheck ȸ����й�ȣ�� : " + member.getPass());

		// ��ȹ : id�� pass ���ؼ� ��ȯ�� ������ �α���, ������
		// sql : select id, pass from member where id=#{id} and pass=#{pass}
		Member loginMember = memberService.loginCheck(member);

		if (loginMember == null) {
			// �α��� ����-json������ �ѱ��
			System.out.println("�α��� ����");
			return "{\"resultCode\":0}";
		} else {
			// �α��� ����
			System.out.println("�α��� ����");
			session.setAttribute("member", loginMember);
			return "{\"resultCode\":1}";
		}
	}

	// ================================================================================================
	// ȸ�� �α׾ƿ�
	// ================================================================================================
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("�α׾ƿ� ����");
		session.invalidate();
		return "redirect:/";
	}

	// ================================================================================================
	// member/mypage ���������� Member ���� �����ϱ�
	// ================================================================================================
	@RequestMapping(value = "/member/edit", method = RequestMethod.POST)
	public String editMyPage(HttpSession session, Member member) {
		System.out.println("MemberController/editMyPage() ��û");
		member = passSecurity.setHashPass(member);
		Auth auth = new Auth();
		auth.setAuth_id(4);
		member.setAuth(auth);
		memberService.update(member);
		session.setAttribute("member", member);
		return "redirect:/member/member-mypage.jsp";
	}

	// ================================================================================================
	// member-regist.jsp���� birth�� date select ���ø޼���
	// ================================================================================================
	@RequestMapping(value = "/member-regist/setBirthDate", method = RequestMethod.GET)
	@ResponseBody
	public List setBirthDate(HttpServletRequest request) {
		int year = Integer.parseInt(request.getParameter("year"));
		int month = Integer.parseInt(request.getParameter("month"));
		System.out.println("��" + year);
		System.out.println("��" + month);
		// year�� month �� �޾Ƽ� date �����ϱ�
		birth.setDate(year, month);
		List dateList = birth.getDateList();

		return dateList;
	}
	
	// ================================================================================================
	// Client ������ �� ����
	// ================================================================================================
	@RequestMapping(value = "/member/member-login", method = RequestMethod.GET)
	public ModelAndView goLoginPage() {
		ModelAndView mav=new ModelAndView("member/member-login");
		return mav;
	}
	
	@RequestMapping(value = "/member/member-regist", method = RequestMethod.GET)
	public ModelAndView goRegistPage() {
		ModelAndView mav=new ModelAndView("member/member-regist");
		return mav;
	}
	
	@RequestMapping(value = "/member/member-mypage", method = RequestMethod.GET)
	public ModelAndView goMyPage() {
		ModelAndView mav=new ModelAndView("member/member-mypage");
		return mav;
	}
	
	@RequestMapping(value = "/aboutUs", method = RequestMethod.GET)
	public ModelAndView goAboutUs() {
		ModelAndView mav=new ModelAndView("aboutUs/aboutUs");
		return mav;
	}
	
	@RequestMapping(value = "/member/welcome", method = RequestMethod.GET)
	public ModelAndView goWelcome() {
		ModelAndView mav=new ModelAndView("member/member-welcome");
		return mav;
	}
}
