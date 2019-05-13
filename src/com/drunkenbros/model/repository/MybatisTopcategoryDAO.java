package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.Topcategory;

@Repository
public class MybatisTopcategoryDAO implements TopcategoryDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public List selectAll() {
		return sessionTemplate.selectList("Topcategory.selectAll");
	}

	public Topcategory select(int topcategory_id) {
		return sessionTemplate.selectOne("Topcategory.select", topcategory_id);
	}

	public int insert(Topcategory topcategory) {
		return sessionTemplate.insert("Topcategory.insert",topcategory);
	}

	public int update(Topcategory topcategory) {
		return sessionTemplate.update("Topcategory.update", topcategory);
	}

	public int delete(int topcategory_id) {
		return sessionTemplate.delete("Topcategory.delete", topcategory_id);
	}

	public Topcategory selectWhereReview(int topcategory_id) {
		return sessionTemplate.selectOne("Topcategory.selectWhereReview", topcategory_id);
	}

}
