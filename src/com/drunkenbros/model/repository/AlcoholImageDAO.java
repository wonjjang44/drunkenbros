package com.drunkenbros.model.repository;

import java.util.List;

import com.drunkenbros.model.domain.AlcoholImage;

public interface AlcoholImageDAO {
	public AlcoholImage select(int alcoholImage_id);
	public List selectByAlcohol(int alcohol_id);
	public List selectAll();
	public int insert(AlcoholImage alcoholImage);
	public int update(AlcoholImage alcoholImage);
	public int delete(int alcohol_id);
	
}
