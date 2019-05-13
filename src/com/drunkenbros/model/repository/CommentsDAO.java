package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Comments;

public interface CommentsDAO {
	//모든 댓글 조회
	public List commentsSelectAll(int board_id);
	//댓글 한건 등록
	public int insertComments(Comments comments);
	//댓글 한건 삭제
	public int oneCommentsDel(int comments_id);
	//날짜 조회
	public String getCregdate(int comments_id);
}	
