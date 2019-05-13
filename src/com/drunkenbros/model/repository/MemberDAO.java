package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Member;

public interface MemberDAO {
	public List selectAll();
	public List selectClient();
	public List selectManager();
	public Member select(int member_id);
	public Member loginCheck(Member member);
	public String registCheck(String id);
	public int insert(Member member);
	public int update(Member member);
	public int delete(int member_id);
	
	public List searchAllById(String search_Word);
	public List searchAllByName(String search_Word);
	
	public List searchClientById(String search_Word);
	public List searchClientByName(String search_Word);
	
	public List searchManagerById(String search_Word);
	public List searchManagerByName(String search_Word);
	
	//게시판 댓글관련 회원 아이디 가져오기 메서드
	public String cWriterId(int member_id);
}
