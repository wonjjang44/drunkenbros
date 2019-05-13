package com.drunkenbros.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Topcategory;
import com.drunkenbros.model.repository.TopcategoryDAO;

@Service
public class TopcategoryServiceImpl implements TopcategoryService{
	@Autowired
	private TopcategoryDAO topcategoryDAO;
	
	public void insert(Topcategory topcategory) throws RegistFailException{
		int result = topcategoryDAO.insert(topcategory);
		//result=0;
		if(result==0) {
			throw new RegistFailException("▶ Topcategory 등록 실패");
		}
	}

	public Topcategory select(int topcategory_id) {
		return topcategoryDAO.select(topcategory_id);
	}

	public List selectAll() {
		return topcategoryDAO.selectAll();
	}

	public void update(Topcategory topcategory) throws EditFailException{
		int result=topcategoryDAO.update(topcategory);
		if(result==0) {
			throw new EditFailException("수정 실패");
		}
	}

	public void delete(int topcategory_id) throws DeleteFailException{
		int result=topcategoryDAO.delete(topcategory_id);
		if(result==0) {
			throw new DeleteFailException("삭제 실패");
		}
	}

	public Topcategory selectWhereReview(int topcategory_id) {
		return topcategoryDAO.selectWhereReview(topcategory_id);
	}

}
