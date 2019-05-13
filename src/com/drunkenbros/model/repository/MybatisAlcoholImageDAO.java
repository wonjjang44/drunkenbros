package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.AlcoholImage;

@Repository
public class MybatisAlcoholImageDAO implements AlcoholImageDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public AlcoholImage select(int alcoholImage_id) {
		return sessionTemplate.selectOne("AlcoholImage.select",alcoholImage_id);
	}

	public List selectByAlcohol(int alcohol_id) {
		return sessionTemplate.selectList("AlcoholImage.selectByAlcohol",alcohol_id);
	}

	public List selectAll() {
		return sessionTemplate.selectList("AlcoholImage.selectAll");
	}

	public int insert(AlcoholImage alcoholImage) {
		return sessionTemplate.insert("AlcoholImage.insert", alcoholImage);
	}

	public int update(AlcoholImage alcoholImage) {
		return sessionTemplate.update("AlcoholImage.update",alcoholImage);
	}

	public int delete(int alcohol_id) {
		return sessionTemplate.delete("AlcoholImage.delete", alcohol_id);
	}
	
}
