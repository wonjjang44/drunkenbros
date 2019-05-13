package com.drunkenbros.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.domain.MemberSearchKeyWord;
import com.drunkenbros.model.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	
	//@Qualifier("MybatisMemberDAO")
	@Autowired
	private MemberDAO memberDAO;
	
	public void insert(Member member) throws RegistFailException{
		int result=memberDAO.insert(member);
		if(result==0) {
			throw new RegistFailException("회원 등록에 실패했습니다.");
		}
	}

	public Member select(int member_id) {
		Member member=memberDAO.select(member_id);
		return member;
	}

	public List selectAll() {
		return memberDAO.selectAll();
	}
	
	public List selectClient() {
		return memberDAO.selectClient();
	}
	
	public List selectManager() {
		return memberDAO.selectManager();
	}

	public void update(Member member) throws EditFailException{
		int result=memberDAO.update(member);
		if(result==0) {
			throw new EditFailException("회원정보 수정에 실패하였습니다.");
		}
	}

	public void delete(int member_id) throws DeleteFailException{
		int result=memberDAO.delete(member_id);
		if(result==0) {
			throw new DeleteFailException("회원정보 삭제에 실패하였습니다.");
		}
		
	}

	public Member loginCheck(Member member) {
		return memberDAO.loginCheck(member);
	}
	
	public String registCheck(String id) {
		return memberDAO.registCheck(id);
	}
	
	//검색 조건 세팅 Controller에서 너무 무거워지지 않게 Service 에서 처리함-시도는 좋았던거 같은데 결국 무거워짐 ㅜㅠ
	public List search(MemberSearchKeyWord searchKey) {
		String auth=searchKey.getSearch_Auth();
		String mode=searchKey.getSearch_Mode();
		searchKey.setSearch_Word("%"+searchKey.getSearch_Word()+"%");
		
		System.out.println("검색하려는 키워드의 search_Mode는 : "+searchKey.getSearch_Mode());
		System.out.println("검색하려는 키워드의 search_Auth는 : "+searchKey.getSearch_Auth());
		System.out.println("검색하려는 키워드의 search_Word는 : "+searchKey.getSearch_Word());
		
		List memberList=null;
		if(auth.equals("allMember")) {
			if(mode.equals("id")) {
				memberList=memberDAO.searchAllById(searchKey.getSearch_Word());
			}else if(mode.equals("name")) {
				memberList=memberDAO.searchAllByName(searchKey.getSearch_Word());
			}
		}else if(auth.equals("cliend")) {
			if(mode.equals("id")) {
				memberList=memberDAO.searchClientById(searchKey.getSearch_Word());
			}else if(mode.equals("name")) {
				memberList=memberDAO.searchClientByName(searchKey.getSearch_Word());
			}
		}else if(auth.equals("manager")) {
			if(mode.equals("id")) {
				memberList=memberDAO.searchManagerById(searchKey.getSearch_Word());
			}else if(mode.equals("name")) {
				memberList=memberDAO.searchManagerByName(searchKey.getSearch_Word());
			}
		}
		return memberList;
	}
}
