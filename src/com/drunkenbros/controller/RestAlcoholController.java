package com.drunkenbros.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Subcategory;
import com.drunkenbros.model.domain.Topcategory;
import com.drunkenbros.model.service.AlcoholService;
import com.drunkenbros.model.service.SubcategoryService;
import com.drunkenbros.model.service.TopcategoryService;

@RestController
public class RestAlcoholController {
	@Autowired
	private AlcoholService alcoholService;
	@Autowired
	private TopcategoryService topcategoryService;
	@Autowired
	private SubcategoryService subcategoryService;
	
	@RequestMapping(value="/alcohols",method=RequestMethod.POST,produces="application/json")
	public String registAlcohol(Alcohol alcohol,HttpServletRequest request) {
		MultipartFile[] myFiles=alcohol.getMyFiles();
		System.out.println("▶ 원본 파일명 : ");
		System.out.println("▶ 넘어온 Alcohol_SubcategoryId : "+request.getParameter("subcategory_id"));
		System.out.println("▶ 넘어온 Alcohol_name : "+alcohol.getName());
		System.out.println("▶ 넘어온 Alcohol_degree: "+alcohol.getDegree());
		System.out.println("▶ 넘어온 Alcohol_detail: "+alcohol.getDetail());
		
		Subcategory subcategory = new Subcategory();
		subcategory.setSubcategory_id(Integer.parseInt(request.getParameter("subcategory_id")));
		alcohol.setSubcategory(subcategory);
		
		//alcoholService.insert(alcohol);
		
		return "{\"code\":1}";
	}
	
	@RequestMapping(value="/alcohols/topcategory",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	public String registTopcategory(Topcategory topcategory) {
		System.out.println("▶ 넘어온 Topcategory_name : "+topcategory.getName());
		topcategoryService.insert(topcategory);
		
		return "{\"code\":1}";
	}
	
	@RequestMapping(value="/alcohols/topcategory",method=RequestMethod.GET,produces="application/json")	
	public List searchTopcategory() {
		List<Topcategory> topcategoryList = topcategoryService.selectAll();
		System.out.println("▶ TopcategoryList : "+topcategoryList);
		
		return topcategoryList;
	}
	
	@RequestMapping(value="/alcohols/subcategory",method=RequestMethod.POST,produces="application/json;charset=UTF-8")
	public String registSubcategory(Subcategory subcategory,HttpServletRequest request) {
		Topcategory topcategory = new Topcategory();
		topcategory.setTopcategory_id(Integer.parseInt(request.getParameter("topcategory_id")));
		subcategory.setTopcategory(topcategory);
		
		System.out.println("▶ 넘어온 Subcategory_topcategory_id : "+subcategory.getTopcategory().getTopcategory_id());
		System.out.println("▶ 넘어온 Subcategory_name : "+subcategory.getName());
		subcategoryService.insert(subcategory);
		
		return "{\"code\":1}";
	}
	
	@RequestMapping(value="/alcohols/subcategory/{topcategory_id}",method=RequestMethod.GET,produces="application/json")
	public List searchSubcategory(@PathVariable("topcategory_id") int topcategory_id) {
		List<Subcategory> subcategoryList = subcategoryService.selectByTopcategory(topcategory_id);
		System.out.println("▶ SubcategoryList : "+subcategoryList);
		
		return subcategoryList;
	}
	
	@ExceptionHandler(RegistFailException.class)
	@ResponseBody
	public String registFail(RegistFailException e) {
		System.out.println("▶ 넘어온 에러 메세지 : "+e.getMessage());
		return "{\"code\":0}";
	}
	
}
