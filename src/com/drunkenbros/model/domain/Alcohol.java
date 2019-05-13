package com.drunkenbros.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Alcohol {
	private int alcohol_id;
	private Subcategory subcategory;
	private String name;
	private double degree;
	private String detail;
	private MultipartFile[] myFiles;
	private int hit;
	private List<AlcoholImage> alcoholImageList;
	private String score;
	
	public int getAlcohol_id() {
		return alcohol_id;
	}
	public void setAlcohol_id(int alcohol_id) {
		this.alcohol_id = alcohol_id;
	}
	public Subcategory getSubcategory() {
		return subcategory;
	}
	public void setSubcategory(Subcategory subcategory) {
		this.subcategory = subcategory;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getDegree() {
		return degree;
	}
	public void setDegree(double degree) {
		this.degree = degree;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public MultipartFile[] getMyFiles() {
		return myFiles;
	}
	public void setMyFiles(MultipartFile[] myFiles) {
		this.myFiles = myFiles;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public List<AlcoholImage> getAlcoholImageList() {
		return alcoholImageList;
	}
	public void setAlcoholImageList(List<AlcoholImage> alcoholImageList) {
		this.alcoholImageList = alcoholImageList;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	
}
