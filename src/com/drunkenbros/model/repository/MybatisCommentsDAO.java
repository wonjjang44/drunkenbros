package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.Comments;

@Repository
public class MybatisCommentsDAO implements CommentsDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	@Override
	public List commentsSelectAll(int board_id) {
		return sessionTemplate.selectList("Comments.commentsSelectAll",board_id);
	}

	@Override
	public int oneCommentsDel(int comments_id) {
		return sessionTemplate.delete("Comments.oneCommentsDel",comments_id);
	}

	@Override
	public int insertComments(Comments comments) {
		return sessionTemplate.insert("Comments.insertComments",comments);
	}

	@Override
	public String getCregdate(int comments_id) {
		return sessionTemplate.selectOne("Comments.cregdate",comments_id);
	}


	
}
