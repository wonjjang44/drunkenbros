package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Comments;

public interface CommentsDAO {
	//��� ��� ��ȸ
	public List commentsSelectAll(int board_id);
	//��� �Ѱ� ���
	public int insertComments(Comments comments);
	//��� �Ѱ� ����
	public int oneCommentsDel(int comments_id);
	//��¥ ��ȸ
	public String getCregdate(int comments_id);
}	
