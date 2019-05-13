package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Subcategory;

public interface AlcoholDAO {
	public List selectAll();
	public Alcohol select(int alcohol_id);
	public Alcohol selectBySubcategory(int subcategory_id);
	public int insert(Alcohol alcohol);
	public int update(Alcohol alcohol);
	public int delete(int alcohol_id);
	public int hitup(int alcohol_id);
	
	public List selectAllByHit();
	public List selectAllByName(String searchWord);

}
