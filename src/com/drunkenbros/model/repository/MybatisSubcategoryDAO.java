package com.drunkenbros.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.drunkenbros.model.domain.Subcategory;
import com.drunkenbros.model.domain.Topcategory;

@Repository
public class MybatisSubcategoryDAO implements SubcategoryDAO{
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public List selectAll() {
		return sessionTemplate.selectList("Subcategory.selectAll");
	}

	public Subcategory select(int subcategory_id) {
		return sessionTemplate.selectOne("Subcategory.select", subcategory_id);
	}

	public List selectByTopcategory(int topcategory_id) {
		return sessionTemplate.selectList("Subcategory.selectByTopcategory", topcategory_id);
	}
	
	public int insert(Subcategory subcategory) {
		return sessionTemplate.insert("Subcategory.insert", subcategory);
	}

	public int update(Subcategory subcategory) {
		return sessionTemplate.update("Subcategory.update", subcategory);
	}

	public int delete(int subcategory_id) {
		return sessionTemplate.delete("Subcategory.delete", subcategory_id);
	}

}
