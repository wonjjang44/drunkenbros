package com.drunkenbros.model.service;

import java.util.List;

import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Topcategory;

public interface TopcategoryService {
	public void insert(Topcategory topcategory);
	public Topcategory select(int topcategory_id);
	public List selectAll();
	public void update(Topcategory topcategory);
	public void delete(int topcategory_id);

	public Topcategory selectWhereReview(int topcategory_id);
}
