package com.drunkenbros.model.service;

import java.util.List;

import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Subcategory;

public interface SubcategoryService {
	public void insert(Subcategory subcategory);
	public Subcategory select(int subcategory_id);
	public List selectAll();
	public List selectByTopcategory(int topcategory_id);
	public void update(Subcategory subcategory);
	public void delete(int subcategory_id);
}
