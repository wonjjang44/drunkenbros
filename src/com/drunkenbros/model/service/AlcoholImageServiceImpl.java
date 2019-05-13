package com.drunkenbros.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.io.FileManager;
import com.drunkenbros.model.domain.AlcoholImage;
import com.drunkenbros.model.repository.AlcoholImageDAO;

@Service
public class AlcoholImageServiceImpl implements AlcoholImageService{
	@Autowired
	private AlcoholImageDAO alcoholImageDAO;

	public AlcoholImage select(int alcoholImage_id) {
		return alcoholImageDAO.select(alcoholImage_id);
	}

	public List selectByAlcohol(int alcohol_id) {
		return alcoholImageDAO.selectByAlcohol(alcohol_id);
	}

	public List selectAll() {
		return alcoholImageDAO.selectAll();
	}

	public void insert(AlcoholImage alcoholImage) throws RegistFailException{
		int result=alcoholImageDAO.insert(alcoholImage);
		if(result==0) {
			throw new RegistFailException("사진이 등록되지 않았습니다.");
		}
	}

	public void update(AlcoholImage alcoholImage) throws EditFailException{
		int result=alcoholImageDAO.update(alcoholImage);
		if(result==0) {
			throw new EditFailException("사진이 수정되지 않았습니다.");
		}
	}

	public void delete(int alcohol_id) throws DeleteFailException{
		int result=alcoholImageDAO.delete(alcohol_id);
		if(result==0) {
			throw new DeleteFailException("사진이 삭제되지 않았습니다.");
		}
	}

}
