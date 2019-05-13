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
	
	//��� ��ü ��ȸ
	public List commentsSelectAll(int board_id);
	//��� �Ѱ� ���
	public String insertComments(Comments comments);
	//���ۼ��� �˻�
	public List search_writer(String searching);
	//��۳��� �˻�
	public List search_content(String searching);
	//����ۼ��� �˻�
	public List search_cWriter(String searching);
	//��� �Ѱ� ����
	public void oneCommenstDel(int comments_id);
	
}
