package com.drunkenbros.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drunkenbros.model.domain.Board;
import com.drunkenbros.model.domain.Comments;
import com.drunkenbros.model.repository.CommentsDAO;

@Service
public class CommentsServiceImpl implements CommentsService{
	@Autowired
	private CommentsDAO commentsDAO;
	@Override
	public Board select(int board_id) {
		//commentsDAO.select(board_id);
		return null;
	}
	
}
