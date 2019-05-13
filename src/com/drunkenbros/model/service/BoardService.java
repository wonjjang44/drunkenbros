package com.drunkenbros.model.service;

import java.util.List;

import com.drunkenbros.model.domain.Board;
import com.drunkenbros.model.domain.Comments;

public interface BoardService {
	public List selectAll();
	public Board select(int board_id);
	public int insert(Board board);
	public int update(Board board);
	public int delete(int board_id);
	public int updateHit(int board_id);
	public List search(String searching);
	public List search_TC(String searching);
	
	//댓글 전체 조회
	public List commentsSelectAll(int board_id);
	//댓글 한건 등록
	public String insertComments(Comments comments);
	//글작성자 검색
	public List search_writer(String searching);
	//댓글내용 검색
	public List search_content(String searching);
	//댓글작성자 검색
	public List search_cWriter(String searching);
	//댓글 한건 삭제
	public void oneCommenstDel(int comments_id);
	
}
