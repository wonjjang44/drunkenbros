package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Subcategory;
import com.drunkenbros.model.domain.Topcategory;

public interface SubcategoryDAO {
	public List selectAll();
	public Subcategory select(int subcategory_id);
	public List selectByTopcategory(int topcategory_id);
	public int insert(Subcategory subcategory);
	public int update(Subcategory subcategory);
	public int delete(int subcategory_id);
}
