package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Review;

public interface ReviewDAO {
	public List selectAll();
	public List selectByAlcohol(int alcohol_id);
	public Review select(int review_id);
	public int insert(Review review);
	public int update(Review review);
	public int delete(int review_id);
}
