package com.drunkenbros.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Subcategory;
import com.drunkenbros.model.repository.SubcategoryDAO;

@Service
public class SubcategoryServiceImpl implements SubcategoryService{
	@Autowired
	private SubcategoryDAO subcategoryDAO;
	
	public void insert(Subcategory subcategory) throws RegistFailException{
		int result = subcategoryDAO.insert(subcategory);
		if(result==0) {
			throw new RegistFailException("▶ Subcategory 등록 실패");
		}
	}

	public Subcategory select(int subcategory_id) {
		return subcategoryDAO.select(subcategory_id);
	}

	public List selectAll() {
		return subcategoryDAO.selectAll();
	}

	public void update(Subcategory subcategory) throws EditFailException{
		int result = subcategoryDAO.update(subcategory);
		if(result==0) {
			throw new EditFailException("수정 실패");
		}
	}

	public void delete(int subcategory_id) throws DeleteFailException{
		int result = subcategoryDAO.delete(subcategory_id);
		if(result==0) {
			throw new DeleteFailException("삭제 실패");
		}
	}

	public List selectByTopcategory(int topcategory_id) {
		return subcategoryDAO.selectByTopcategory(topcategory_id);
	}

}
