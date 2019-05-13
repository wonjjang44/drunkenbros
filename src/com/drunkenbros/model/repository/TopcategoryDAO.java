package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Topcategory;

public interface TopcategoryDAO {
	public List selectAll();
	public Topcategory select(int topcategory_id);
	public int insert(Topcategory topcategory);
	public int update(Topcategory topcategory);
	public int delete(int topcategory_id);
	
	public Topcategory selectWhereReview(int topcategory_id);
}
