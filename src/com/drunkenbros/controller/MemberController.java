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
	 * 관리자 페이지
	 **************************************************************************************************/

	// ================================================================================================
	// 관리자(admin) 페이지에서 Member 테이블의 List를 가져오기
	// ================================================================================================
	@RequestMapping(value = "/admin/member", method = RequestMethod.GET)
	public ModelAndView adminGetList(HttpServletRequest request) {
		System.out.println("MemberController/adminGetList()을 호출");

		List<Member> memberList = memberService.selectAll();
		Pager pager = new Pager();

		pager.init(request, memberList.size(), 10, 10);

		// aop에서 proceed() 로 넘어올 때 String형태로 넘어와서 ModelAndView가 아닌 String 형으로 return 하려고
		// 해서 에러가 나는 것!
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/member/member-table"); // 접속할 jsp 주소 등록

		mav.addObject("pager", pager);
		mav.addObject("memberList", memberList);

		return mav;
	}

	// ================================================================================================
	// 관리자(admin) 페이지에서 검색 결과 가져오기
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
		mav.setViewName("admin/member/member-table"); // 접속할 jsp 주소 등록

		mav.addObject("pager", pager);
		mav.addObject("memberList", memberList);

		return mav;
	}

	// ================================================================================================
	// 관리자(admin) 페이지에서 Member 정보 상세 보기
	// ================================================================================================
	@RequestMapping(value = "/admin/member/{member_id}", method = RequestMethod.GET) // 경로 문제로 css 에러남
	public ModelAndView adminGetDetail(@PathVariable("member_id") int member_id, HttpServletRequest request) {
		Member member = memberService.select(member_id);
		BirthSetter birth = new BirthSetter();
		System.out.println("MemberController/adminGetDetail : " + member_id);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/member/member-detail"); // 접속할 jsp 주소 등록
		mav.addObject("member", member); // 저장
		mav.addObject("birth", birth);
		// 반환주소에 /가 하나 더 있어서 css에 접속을 못 함
		return mav;
	}

	// ================================================================================================
	// 관리자(admin) 페이지에서 Member 정보 수정하기
	// ================================================================================================
	@RequestMapping(value = "/admin/member/edit", method = RequestMethod.POST)
	public String editMember(HttpServletRequest request, Member member) {
		System.out.println("MemberController/adminEditMember() 요청");
		member = passSecurity.setHashPass(member);// 비밀번호 암호화
		Auth auth = new Auth();
		auth.setAuth_id(Integer.parseInt(request.getParameter("auth_id")));
		member.setAuth(auth);
		memberService.update(member);
		return "redirect:/admin/member/" + member.getMember_id();
	}

	// ================================================================================================
	// 관리자(admin) 페이지에서 Member 정보 삭제하기
	// ================================================================================================
	@RequestMapping(value = "/admin/member/delete", method = RequestMethod.POST)
	public String deleteMember(int member_id) {
		System.out.println("MemberController/adminDeleteMember() 요청");
		memberService.delete(member_id);
		return "redirect:/admin/member/member-table";
	}

	/**************************************************************************************************
	 * Client 페이지
	 **************************************************************************************************/

	// ================================================================================================
	// 회원가입
	// ================================================================================================
	@RequestMapping(value = "/member/regist", method = RequestMethod.POST)
	@ResponseBody
	public String memberRegist(Member member) {
		System.out.println("MemberController : 회원가입 요청!");

		System.out.println("가입하려는 회원의 ID : " + member.getId());
		System.out.println("가입하려는 회원의 Pass : " + member.getPass());
		System.out.println("가입하려는 회원의 name : " + member.getName());
		System.out.println("가입하려는 회원의 email : " + member.getEmail());
		System.out.println("가입하려는 회원의 birth : " + member.getBirth());
		System.out.println("가입하려는 회원의 phonenum : " + member.getPhonenum());

		// 비밀번호 암호화 : 비밀번호를 암호화해서 DB에 등록하자
		member = passSecurity.setHashPass(member);

		memberService.insert(member);

		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append("\"resultCode\":\"1\",");
		sb.append("\"msg\":\"회원 가입 성공!.\"");
		sb.append("}");
		return sb.toString();
	}

	// ================================================================================================
	// 아이디 중복 체크
	// ================================================================================================
	@RequestMapping(value = "/member/regist/idoverlap", method = RequestMethod.POST)
	@ResponseBody
	public String IdOverlapCheck(String id) {
		System.out.println("MemberController : 아이디 중복체크 요청!");
		String idOverlapChecker = memberService.registCheck(id);

		System.out.println("회원 ID는 : " + id);
		System.out.println("MemberController/idOverlapChecker() 중복되는 아이디가 있는가? : " + idOverlapChecker);

		if (id.equals(idOverlapChecker)) {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			sb.append("\"resultCode\":\"0\",");
			sb.append("\"msg\":\"중복된 아이디 입니다.\"");
			sb.append("}");
			return sb.toString();
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append("{");
			sb.append("\"resultCode\":\"1\",");
			sb.append("\"msg\":\"사용할 수 있는 아이디 입니다.\"");
			sb.append("}");
			return sb.toString();
		}
	}

	// ================================================================================================
	// 이메일 중복 체크
	// ================================================================================================
	// @RequestMapping(value="", method=RequestMethod.POST)
	// @ResponseBody
	// public void emailOverlapCheck() {

	// }

	// ================================================================================================
	// 회원 member-login.jsp 페이지에서 로그인
	// ================================================================================================
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	@ResponseBody
	public String login(Member member, HttpSession session) {
		member = passSecurity.setHashPass(member);// 체크전에 로그인하려는 유저가 입력한 비밀번호도 암호화해서 비교하자
		System.out.println("MemberController/loginCheck 회원아이디는 : " + member.getId());
		System.out.println("MemberController/loginCheck 회원비밀번호는 : " + member.getPass());

		// 계획 : id와 pass 비교해서 반환값 있으면 로그인, 없으면
		// sql : select id, pass from member where id=#{id} and pass=#{pass}
		Member loginMember = memberService.loginCheck(member);

		if (loginMember == null) {
			// 로그인 실패-json값으로 넘기기
			System.out.println("로그인 실패");
			return "{\"resultCode\":0}";
		} else {
			// 로그인 성공
			System.out.println("로그인 성공");
			session.setAttribute("member", loginMember);
			return "{\"resultCode\":1}";
		}
	}

	// ================================================================================================
	// 회원 로그아웃
	// ================================================================================================
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("로그아웃 성공");
		session.invalidate();
		return "redirect:/";
	}

	// ================================================================================================
	// member/mypage 페이지에서 Member 정보 수정하기
	// ================================================================================================
	@RequestMapping(value = "/member/edit", method = RequestMethod.POST)
	public String editMyPage(HttpSession session, Member member) {
		System.out.println("MemberController/editMyPage() 요청");
		member = passSecurity.setHashPass(member);
		Auth auth = new Auth();
		auth.setAuth_id(4);
		member.setAuth(auth);
		memberService.update(member);
		session.setAttribute("member", member);
		return "redirect:/member/member-mypage.jsp";
	}

	// ================================================================================================
	// member-regist.jsp에서 birth의 date select 세팅메서드
	// ================================================================================================
	@RequestMapping(value = "/member-regist/setBirthDate", method = RequestMethod.GET)
	@ResponseBody
	public List setBirthDate(HttpServletRequest request) {
		int year = Integer.parseInt(request.getParameter("year"));
		int month = Integer.parseInt(request.getParameter("month"));
		System.out.println("년" + year);
		System.out.println("월" + month);
		// year와 month 값 받아서 date 세팅하기
		birth.setDate(year, month);
		List dateList = birth.getDateList();

		return dateList;
	}
	
	// ================================================================================================
	// Client 페이지 뷰 매핑
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
