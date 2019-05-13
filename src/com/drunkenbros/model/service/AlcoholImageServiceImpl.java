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
			throw new RegistFailException("������ ��ϵ��� �ʾҽ��ϴ�.");
		}
	}

	public void update(AlcoholImage alcoholImage) throws EditFailException{
		int result=alcoholImageDAO.update(alcoholImage);
		if(result==0) {
			throw new EditFailException("������ �������� �ʾҽ��ϴ�.");
		}
	}

	public void delete(int alcohol_id) throws DeleteFailException{
		int result=alcoholImageDAO.delete(alcohol_id);
		if(result==0) {
			throw new DeleteFailException("������ �������� �ʾҽ��ϴ�.");
		}
	}

}
