package com.drunkenbros.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.service.MemberService;

@RestController
@RequestMapping("/rest")
public class RestMemberController {
	@Autowired
	private MemberService memberService;
	
	
}
