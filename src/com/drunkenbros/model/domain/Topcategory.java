package com.drunkenbros.model.domain;

import java.util.List;

public class Topcategory {
	private int topcategory_id;
	private String name;
	private List<Subcategory> subcategoryList;
	
	public int getTopcategory_id() {
		return topcategory_id;
	}
	public void setTopcategory_id(int topcategory_id) {
		this.topcategory_id = topcategory_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Subcategory> getSubcategoryList() {
		return subcategoryList;
	}
	public void setSubcategoryList(List<Subcategory> subcategoryList) {
		this.subcategoryList = subcategoryList;
	}
}
