package com.drunkenbros.io;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

public class FileManager {
	public String getExt(String oriName) {
		int dotIndex = oriName.indexOf(".");
		int lastIndex = oriName.length();
		
		String ext = oriName.substring(dotIndex+1,lastIndex);
		
		return ext;
	}
	
	public boolean deleteFile(String filename) {
		File file = new File(filename);
		boolean result = file.delete();
		
		return result;
	}
	
	public String nameChange(String oriName) {		
		String ext = getExt(oriName);
		String filename = System.currentTimeMillis()+"."+ext;
		
		return filename;
	}
	
	public String uploadWithNameChanging(String oriName,String path,MultipartFile myFile) {
		String ext = getExt(oriName);
		String filename = System.currentTimeMillis()+"."+ext;
		
		File file=new File(path+"/"+filename);
		try {
			myFile.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("�� ���� Ȯ���� : " + ext);
		System.out.println("�� �ٲ� �̸� : " + System.currentTimeMillis());
		System.out.println("�� ����� ���ϸ� : " + filename);
		System.out.println("�� ���� ��� : " + path);
		System.out.println("�� ���� ���ϸ� : " + oriName);
		
		return filename;
	}
}
