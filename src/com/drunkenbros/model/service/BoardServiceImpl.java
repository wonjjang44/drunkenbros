package com.drunkenbros.model.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.model.domain.Board;
import com.drunkenbros.model.domain.Comments;
import com.drunkenbros.model.repository.BoardDAO;
import com.drunkenbros.model.repository.CommentsDAO;
import com.drunkenbros.model.repository.MemberDAO;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private CommentsDAO commentsDAO;
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public List selectAll() {
		List boardList=boardDAO.selectAll();
		return boardList;
	}
	@Override
	public Board select(int board_id) {
		Board board=boardDAO.select(board_id);
		return board;
	}
	@Override
	public int insert(Board board) {
		int result=boardDAO.insert(board);
		if(result==0) {
			throw new RegistFailException("등록에 실패하셨습니다.");
		}
		return result;
	}
	
	@Override
	public int update(Board board) {
		int result=boardDAO.update(board);
		return result;
	}
	
	@Override
	public int delete(int board_id) {
		int result=boardDAO.delete(board_id);
		return result;
	}
	
	@Override
	public int updateHit(int board_id) {
		int result=boardDAO.updateHit(board_id);
		return result;
	}
	//검색기능
	//================================================================
	//================================================================
	@Override
	public List search(String searching) {
		List boardList=boardDAO.search(searching);
		return boardList;
	}
	
	@Override
	public List search_TC(String searching) {
		List boardList=boardDAO.search_TC(searching);
		return boardList;
	}
	
	@Override
	public List search_writer(String searching) {
		List boardList=boardDAO.search_writer(searching);
		return boardList;
	}
	
	@Override
	public List search_content(String searching) {
		List boardList=boardDAO.search_content(searching);
		return boardList;
	}
	
	@Override
	public List search_cWriter(String searching) {
		List boardList=boardDAO.search_cWriter(searching);
		return boardList;
	}
	
	//==========================================================
	//==========================================================
	
	//댓글 전체 조회
	@Override
	public List commentsSelectAll(int board_id) {
		System.out.println("댓글관련service 넘어왔니..?"+board_id);
		return commentsDAO.commentsSelectAll(board_id);
	}
	
	//댓글한건 삭제
	@Override
	public void oneCommenstDel(int comments_id) {
		System.out.println("댓글 한건 삭제 서비스 넘어왔니..?");
		commentsDAO.oneCommentsDel(comments_id);
	}
	
	//한건 등록(날짜 가져오기  및 작성자 가져오기)
	@Override
	public String insertComments(Comments comments) {
		int result=commentsDAO.insertComments(comments);
		String cRegdate=commentsDAO.getCregdate(comments.getComments_id());
		String writer= memberDAO.cWriterId(comments.getMember().getMember_id());
		JSONObject json=new JSONObject();
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"cRegdate\":\""+cRegdate+"\",");
		sb.append("\"writer\":\""+writer+"\"");
		sb.append("}");
		
		System.out.println("내가 보낼 제이슨 : "+sb.toString());
		
		return sb.toString();

	}
	
	
	

}
