package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.domain.MemberSearchKeyWord;

@Repository
public class MybatisMemberDAO implements MemberDAO{
	@Autowired
	SqlSessionTemplate sessionTemplate;
	
	public List selectAll() {
		return sessionTemplate.selectList("Member.selectAll");
	}
	
	public List selectClient() {
		return sessionTemplate.selectList("Member.selectClient");
	}
	
	public List selectManager() {
		return sessionTemplate.selectList("Member.selectManager");
	}

	public Member select(int member_id) {
		return sessionTemplate.selectOne("Member.select", member_id);
	}

	public int insert(Member member) {
		return sessionTemplate.insert("Member.insert", member);
	}

	public int update(Member member) {
		return sessionTemplate.update("Member.update", member);
	}

	public int delete(int member_id) {
		return sessionTemplate.delete("Member.delete", member_id);
	}

	public Member loginCheck(Member member) {
		return sessionTemplate.selectOne("Member.loginCheck", member);
	}
	
	public String registCheck(String id) {
		return sessionTemplate.selectOne("Member.registCheck", id);
	}

	public List searchAllById(String search_Word) {
		return sessionTemplate.selectList("Member.searchAllById", search_Word);
	}

	public List searchAllByName(String search_Word) {
		return sessionTemplate.selectList("Member.searchAllByName", search_Word);
	}

	public List searchClientById(String search_Word) {
		return sessionTemplate.selectList("Member.searchClientById", search_Word);
	}

	public List searchClientByName(String search_Word) {
		return sessionTemplate.selectList("Member.searchClientByName", search_Word);
	}

	public List searchManagerById(String search_Word) {
		return sessionTemplate.selectList("Member.searchManagerById", search_Word);
	}

	public List searchManagerByName(String search_Word) {
		return sessionTemplate.selectList("Member.searchManagerByName", search_Word);
	}
	
	public String cWriterId(int member_id) {
		String writer=sessionTemplate.selectOne("Member.writer", member_id);
		return writer;
	}
}
