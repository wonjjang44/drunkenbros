package com.drunkenbros.model.domain;

public class AlcoholImage {
	private int alcoholImage_id;
	private Alcohol alcohol;
	private String filename;
	
	public int getAlcoholImage_id() {
		return alcoholImage_id;
	}
	public void setAlcoholImage_id(int alcoholImage_id) {
		this.alcoholImage_id = alcoholImage_id;
	}
	public Alcohol getAlcohol() {
		return alcohol;
	}
	public void setAlcohol(Alcohol alcohol) {
		this.alcohol = alcohol;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
}
