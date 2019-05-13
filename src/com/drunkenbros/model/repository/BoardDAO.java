package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Board;

public interface BoardDAO {
	public List selectAll();
	public Board select(int board_id);
	public int insert(Board board);
	public int update(Board board);
	public int delete(int board_id);
	public int updateHit(int board_id);
	
	//검색기능 검색
	
	//제목
	public List search(String searching);
	//제목+내용 검색
	public List search_TC(String searching);
	//글작성자 검색
	public List search_writer(String searching);
	//댓글내용 검색
	public List search_content(String searching);
	//댓글작성자 검색
	public List search_cWriter(String searching);
}
