package com.drunkenbros.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.model.domain.Review;
import com.drunkenbros.model.repository.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	private ReviewDAO reviewDAO;
	
	public List selectAll() {
		return reviewDAO.selectAll();
	}
	
	public List selectByAlcohol(int alcohol_id) {
			return reviewDAO.selectByAlcohol(alcohol_id);
	}

	public Review select(int review_id) {
		return reviewDAO.select(review_id);
	}

	public void insert(Review review) throws RegistFailException{
		int result=reviewDAO.insert(review);
		if(result==0) {
			throw new RegistFailException("리뷰 등록 실패");
		}
	}

	public void update(Review review) throws EditFailException{
		int result=reviewDAO.update(review);
		if(result==0) {
			throw new EditFailException("리뷰 수정 실패");
		}
	}

	public void delete(int review_id) throws DeleteFailException{
		int result=reviewDAO.delete(review_id);
		if(result==0) {
			throw new DeleteFailException("리뷰 삭제 실패");
		}
	}
	
}
