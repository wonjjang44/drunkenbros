package com.drunkenbros.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.io.FileManager;
import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.AlcoholImage;
import com.drunkenbros.model.repository.AlcoholDAO;
import com.drunkenbros.model.repository.AlcoholImageDAO;

@Service
public class AlcoholServiceImpl implements AlcoholService{
	@Autowired
	private AlcoholDAO alcoholDAO;
	@Autowired
	private AlcoholImageDAO alcoholImageDAO;
	
	@Transactional
	public void insert(Alcohol alcohol,String path,MultipartFile[] myFiles) throws RegistFailException{
		int result = alcoholDAO.insert(alcohol);
		//result=0;
		if(result == 0) {
			throw new RegistFailException("등록 실패");
		}else {
			FileManager fileManager = new FileManager();
			
			for (int i = 0; i < myFiles.length; i++) {
				AlcoholImage alcoholImage = new AlcoholImage();
				String oriFilename = myFiles[i].getOriginalFilename();

				String filename = fileManager.uploadWithNameChanging(oriFilename, path, myFiles[i]);

				alcoholImage.setAlcohol(alcohol);
				alcoholImage.setFilename(filename);
				alcoholImageDAO.insert(alcoholImage);
			}
		}
		System.out.println("▶ AlcoholService().insert() Complete ◀");
	}

	public Alcohol select(int alcohol_id) {
		return alcoholDAO.select(alcohol_id);
	}
	
	public Alcohol selectBySubcategory(int subcategory_id) {
		return alcoholDAO.selectBySubcategory(subcategory_id);
	}

	public List selectAll() {
		return alcoholDAO.selectAll();
	}
	
	@Transactional
	public void update(Alcohol alcohol,String path,MultipartFile[] myFiles) throws EditFailException{
		FileManager fileManager = new FileManager();
		int alcohol_id = alcohol.getAlcohol_id();
		List<AlcoholImage> imageList = alcoholImageDAO.selectByAlcohol(alcohol_id);
		
		int result = alcoholDAO.update(alcohol);
		
		if(result==0) {
			throw new EditFailException("수정 실패");
		}
		String oriFilename=null;
		
		if(!myFiles[0].isEmpty()) {
			for(int i=0;i<imageList.size();i++) {
				oriFilename=imageList.get(i).getFilename();
				boolean deleteResult = fileManager.deleteFile(path+"/"+oriFilename);
				System.out.println("▶ FileDelete  ==> "+deleteResult);
			}
			int result2 = alcoholImageDAO.delete(alcohol_id);
			if(result2!=0) {
				for(int k=0;k<myFiles.length;k++) {
					AlcoholImage alcoholImage = new AlcoholImage();
					String filename = fileManager.uploadWithNameChanging(myFiles[k].getOriginalFilename(), path, myFiles[k]);
					alcoholImage.setFilename(filename);
					alcoholImage.setAlcohol(alcohol);
					alcoholImageDAO.insert(alcoholImage);
				}
			}
		}
		
		alcoholDAO.update(alcohol);
		System.out.println("▶ AlcoholService().update() Complete ◀");
	}

	public void delete(int alcohol_id) throws DeleteFailException{
		int result = alcoholDAO.delete(alcohol_id);
		if(result==0) {
			throw new DeleteFailException("삭제 실패");
		}
	}

	public void hitup(int alcohol_id) throws EditFailException{
		int result = alcoholDAO.hitup(alcohol_id);
		if(result==0) {
			throw new EditFailException("수정 실패");
		}
		System.out.println("▶ AlcoholService().hitup() Complete ◀");
	}

	public List selectAllByHit() {
		return alcoholDAO.selectAllByHit();
	}

	public List selectAllByName(String searchWord) {
		return alcoholDAO.selectAllByName(searchWord);
	}

	
}
