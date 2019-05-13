package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.Review;

@Repository
public class MybatisReviewDAO implements ReviewDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public List selectAll() {
		return sessionTemplate.selectList("Review.selectAll");
	}
	
	public List selectByAlcohol(int alcohol_id) {
			return sessionTemplate.selectList("Review.selectByAlcohol", alcohol_id);
	}

	public Review select(int review_id) {
		return sessionTemplate.selectOne("Review.select", review_id);
	}

	public int insert(Review review) {
		return sessionTemplate.insert("Review.insert", review);
	}

	public int update(Review review) {
		return sessionTemplate.update("Review.update", review);
	}

	public int delete(int review_id) {
		return sessionTemplate.delete("Review.delete", review_id);
	}

}
