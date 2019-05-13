package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.Board;

@Repository
public class MybatisBoardDAO implements BoardDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	@Override
	public List selectAll() {
		List boardList =sessionTemplate.selectList("Board.selectAll");
		return boardList;
	}

	@Override
	public Board select(int board_id) {
		Board board=sessionTemplate.selectOne("Board.select",board_id);
		return board;
	}

	@Override
	public int insert(Board board) {
		int result=sessionTemplate.insert("Board.insert", board);
		return result;
	}
	
	@Override
	public int update(Board board) {
		int result=sessionTemplate.update("Board.update",board);
		return result;
	}

	@Override
	public int delete(int board_id) {
		int result=sessionTemplate.delete("Board.delete", board_id);
		return result;
	}

	@Override
	public int updateHit(int board_id) {
		int result=sessionTemplate.update("Board.updateHit",board_id);
		return result;
	}

	//검색기능====================================================
	
	//제목 검색
	@Override
	public List search(String searching) {
		List boardList=sessionTemplate.selectList("Board.search",searching);
		return boardList;
	}

	//제목+내용 검색
	@Override
	public List search_TC(String searching) {
		List boardList=sessionTemplate.selectList("Board.search_TC",searching);
		return boardList;
	}

	//글작성자 검색
	@Override
	public List search_writer(String searching) {
		List boardList=sessionTemplate.selectList("Board.search_writer",searching);
		return boardList;
	}

	//댓글내용 검색
	@Override
	public List search_content(String searching) {
		List boardList=sessionTemplate.selectList("Board.search_content",searching);
		return boardList;
	}

	@Override
	//댓글작성자 검색
	public List search_cWriter(String searching) {
		List boardList=sessionTemplate.selectList("Board.search_cWriter",searching);
		return boardList;
	}

	


}
