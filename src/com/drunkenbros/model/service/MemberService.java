package com.drunkenbros.model.service;

import java.util.List;

import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.domain.MemberSearchKeyWord;

public interface MemberService {
	public void insert(Member member);
	public List selectAll();
	public List selectClient();
	public List selectManager();
	public Member select(int member_id);
	public String registCheck(String id);
	public Member loginCheck(Member member);
	public void update(Member member);
	public void delete(int member_id);
	public List search(MemberSearchKeyWord searchKey);
}
