package com.drunkenbros.model.domain;

import java.util.List;

public class Subcategory {
	private int subcategory_id;
	private Topcategory topcategory;
	private String name;
	private List<Alcohol> alcoholList;
	
	public int getSubcategory_id() {
		return subcategory_id;
	}
	public void setSubcategory_id(int subcategory_id) {
		this.subcategory_id = subcategory_id;
	}
	public Topcategory getTopcategory() {
		return topcategory;
	}
	public void setTopcategory(Topcategory topcategory) {
		this.topcategory = topcategory;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Alcohol> getAlcoholList() {
		return alcoholList;
	}
	public void setAlcoholList(List<Alcohol> alcoholList) {
		this.alcoholList = alcoholList;
	}
}
