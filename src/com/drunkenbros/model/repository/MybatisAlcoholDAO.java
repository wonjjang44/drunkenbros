package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Subcategory;

@Repository
public class MybatisAlcoholDAO implements AlcoholDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public List selectAll() {
		return sessionTemplate.selectList("Alcohol.selectAll");
	}

	public Alcohol select(int alcohol_id) {
		return sessionTemplate.selectOne("Alcohol.select", alcohol_id);
	}
	
	public Alcohol selectBySubcategory(int subcategory_id) {
			return sessionTemplate.selectOne("Alcohol.selectBySubcategory", subcategory_id);
	}
	
	public int insert(Alcohol alcohol) {
		return sessionTemplate.insert("Alcohol.insert", alcohol);
	}

	public int update(Alcohol alcohol) {
		return sessionTemplate.update("Alcohol.update", alcohol);
	}

	public int delete(int alcohol_id) {
		return sessionTemplate.delete("Alcohol.delete", alcohol_id);
	}
	
	public int hitup(int alcohol_id) {
		return sessionTemplate.update("Alcohol.hitup", alcohol_id);
	}

	public List selectAllByHit() {
		return sessionTemplate.selectList("Alcohol.selectAllByHit");
	}

	public List selectAllByName(String searchWord) {
		return sessionTemplate.selectList("Alcohol.selectAllByName", searchWord);
	}
}
