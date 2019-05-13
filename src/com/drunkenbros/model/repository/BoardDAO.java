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
	
	//�˻���� �˻�
	
	//����
	public List search(String searching);
	//����+���� �˻�
	public List search_TC(String searching);
	//���ۼ��� �˻�
	public List search_writer(String searching);
	//��۳��� �˻�
	public List search_content(String searching);
	//����ۼ��� �˻�
	public List search_cWriter(String searching);
}
