package com.drunkenbros.model.service;

import java.util.List;

import com.drunkenbros.model.domain.Review;

public interface ReviewService {
	public List selectAll();
	public List selectByAlcohol(int alcohol_id);
	public Review select(int review_id);
	public void insert(Review review);
	public void update(Review review);
	public void delete(int review_id);
}
