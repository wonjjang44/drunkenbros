package com.drunkenbros.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.drunkenbros.model.domain.Alcohol;

public interface AlcoholService {
	public void insert(Alcohol alcohol,String path,MultipartFile[] myFiles);
	public Alcohol select(int alcohol_id);
	public Alcohol selectBySubcategory(int subcategory_id);
	public List selectAll();
	public void update(Alcohol alcohol,String path,MultipartFile[] myFiles);
	public void delete(int alcohol_id);
	public void hitup(int alcohol_id);
	
	public List selectAllByHit();
	public List selectAllByName(String searchWord);
}
