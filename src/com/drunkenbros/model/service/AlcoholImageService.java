package com.drunkenbros.model.service;

import java.util.List;

import com.drunkenbros.model.domain.AlcoholImage;

public interface AlcoholImageService {
	public AlcoholImage select(int alcoholImage_id);
	public List selectByAlcohol(int alcohol_id);
	public List selectAll();
	public void insert(AlcoholImage alcoholImage);
	public void update(AlcoholImage alcoholImage);
	public void delete(int alcohol_id);
	
}
