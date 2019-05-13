package com.drunkenbros.controller;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.drunkenbros.common.Pager;
import com.drunkenbros.common.ReviewScoreSetter;
import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.io.FileManager;
import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.AlcoholImage;
import com.drunkenbros.model.domain.Review;
import com.drunkenbros.model.domain.Subcategory;
import com.drunkenbros.model.domain.Topcategory;
import com.drunkenbros.model.service.AlcoholImageService;
import com.drunkenbros.model.service.AlcoholService;
import com.drunkenbros.model.service.ReviewService;
import com.drunkenbros.model.service.SubcategoryService;
import com.drunkenbros.model.service.TopcategoryService;

@Controller
public class AlcoholController {
	@Autowired
	private TopcategoryService topcategoryService;
	@Autowired
	private SubcategoryService subcategoryService;
	@Autowired
	private AlcoholService alcoholService;
	@Autowired
	private AlcoholImageService alcoholImageService;
	@Autowired
	private ReviewService reviewService;
	
	/***************************************************************
	 * 페이지 매핑
	 ***************************************************************/
	@RequestMapping(value = "/admin/alcohol/regist", method = RequestMethod.GET)
	public ModelAndView goAboutUs() {
		ModelAndView mav=new ModelAndView("admin/alcohol/alcohol-regist");
		return mav;
	}
	
	/***************************************************************
	 * For Topcategory *
	 ***************************************************************/
	// ● 탑카테고리 한건 등록
	@RequestMapping(value = "/admin/topcategories", method = RequestMethod.POST)
	public String addTopcategory(Topcategory topcategory) {
		topcategoryService.insert(topcategory);
		String viewName = "redirect:/admin/topcategories";

		return viewName;
	}

	// ● 탑카테고리 불러오기
	@RequestMapping(value = "/admin/topcategories", method = RequestMethod.GET)
	public ModelAndView adminGetTopcategoryList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		List<Topcategory> topList = topcategoryService.selectAll();
		Pager pager = new Pager();

		int totalRecord = topList.size();
		int pageSize = 10;
		int blockSize = 10;
		pager.init(request, totalRecord, pageSize, blockSize);

		mav.addObject("topList", topList);
		mav.addObject("pager", pager);
		mav.setViewName("admin/category/category-top-table");

		return mav;
	}

	// ● 탑카테고리 한건 수정
	@RequestMapping(value = "/admin/topcategories/edit", method = RequestMethod.POST)
	public String editTopcategory(Topcategory topcategory) {
		topcategoryService.update(topcategory);

		return "redirect:/admin/topcategories";
	}

	// ● 탑카테고리 한건 삭제
	@RequestMapping(value = "/admin/topcategories/delete/{topcategory_id}", method = RequestMethod.POST)
	public String deleteTopcategory(@PathVariable("topcategory_id") int topcategory_id) {
		topcategoryService.delete(topcategory_id);

		return "redirect:/admin/topcategories";
	}

	/***************************************************************
	 * For Subcategory *
	 ***************************************************************/
	// ● 서브카테고리 한건 등록
	@RequestMapping(value = "/admin/subcategories", method = RequestMethod.POST)
	public String addSubcategory(Subcategory subcategory, HttpServletRequest request) {
		Topcategory topcategory = new Topcategory();
		topcategory.setTopcategory_id(Integer.parseInt(request.getParameter("topcategory_id")));

		subcategory.setTopcategory(topcategory);
		subcategoryService.insert(subcategory);

		String viewName = "redirect:/admin/subcategories";

		return viewName;
	}

	// ● 서브카테고리 불러오기
	@RequestMapping(value = "/admin/subcategories", method = RequestMethod.GET)
	public ModelAndView adminGetSubcategoryList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		List<Subcategory> subList = subcategoryService.selectAll();
		Pager pager = new Pager();

		int totalRecord = subList.size();
		int pageSize = 10;
		int blockSize = 10;
		pager.init(request, totalRecord, pageSize, blockSize);

		mav.addObject("subList", subList);
		mav.addObject("pager", pager);
		mav.setViewName("admin/category/category-sub-table");

		return mav;
	}

	// ● 서브카테고리 한건 수정하기
	@RequestMapping(value = "/admin/subcategories/edit", method = RequestMethod.POST)
	public String editSubcategory(Subcategory subcategory, HttpServletRequest request) {
		Topcategory topcategory = new Topcategory();
		topcategory.setTopcategory_id(Integer.parseInt(request.getParameter("topcategory_id")));
		subcategory.setTopcategory(topcategory);

		subcategoryService.update(subcategory);

		return "redirect:/admin/subcategories";
	}

	// ● 서브카테고리 한건 삭제하기
	@RequestMapping(value = "/admin/subcategories/delete/{subcategory_id}", method = RequestMethod.POST)
	public ModelAndView deleteSubcategory(@PathVariable("subcategory_id") int subcategory_id) {
		ModelAndView mav = new ModelAndView();
		Alcohol alcohol = alcoholService.selectBySubcategory(subcategory_id);
		if (alcohol != null) {
			String msg = "삭제 실패 ( CODE : 333 ) 현 카테고리 하위에 제품이 등록 되어 있습니다. 제품 먼저 삭제 해주세요.";
			mav.addObject("msg", msg);
			mav.setViewName("error/fkerror");
		} else {
			subcategoryService.delete(subcategory_id);
			mav.setViewName("redirect:/admin/subcategories");
		}

		return mav;
	}

	/**********************************************************************
	 * For Alcohol *
	 ***********************************************************************/
	// ● 술 한건 등록
	@RequestMapping(value = "/admin/alcohols", method = RequestMethod.POST)
	public String registAlcohol(Alcohol alcohol, HttpServletRequest request) {
		MultipartFile[] myFiles = alcohol.getMyFiles();
		String path = request.getServletContext().getRealPath("/data");

		// AlcoholDTO에 subcategory 담기
		Subcategory subcategory = new Subcategory();
		subcategory.setSubcategory_id(Integer.parseInt(request.getParameter("subcategory_id")));
		alcohol.setSubcategory(subcategory);
		alcoholService.insert(alcohol, path, myFiles);

		return "redirect:/admin/alcohols";
	}

	// ● 술 전체 불러오기
	@RequestMapping(value = "/admin/alcohols", method = RequestMethod.GET)
	public ModelAndView adminGetAlcoholList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		List<Alcohol> alcoholList = alcoholService.selectAll();
		Pager pager = new Pager();
		int totalRecord = alcoholList.size();
		int pageSize = 10;
		int blockSize = 10;
		pager.init(request, totalRecord, pageSize, blockSize);

		mav.addObject("alcoholList", alcoholList);
		mav.addObject("pager", pager);
		mav.setViewName("admin/alcohol/alcohol-table");

		return mav;
	}

	// ● 술 한건 불러오기
	@RequestMapping(value = "/admin/alcohols/{alcohol_id}", method = RequestMethod.GET)
	public ModelAndView adminGetAlcohol(@PathVariable("alcohol_id") int alcohol_id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Alcohol alcohol = alcoholService.select(alcohol_id);
		List<AlcoholImage> imageList = alcoholImageService.selectByAlcohol(alcohol_id);
		mav.addObject("alcohol", alcohol);
		mav.addObject("imageList", imageList);
		mav.setViewName("admin/alcohol/alcohol-detail");

		return mav;
	}

	// ● 술 한건 수정하기
	@RequestMapping(value = "/admin/alcohols/edit/{alcohol_id}", method = RequestMethod.POST)
	public String editAlcohol(@PathVariable("alcohol_id") int alcohol_id, Alcohol alcohol, HttpServletRequest request) {
		MultipartFile[] myFiles = alcohol.getMyFiles();
		String realPath = request.getServletContext().getRealPath("data");

		Subcategory subcategory = new Subcategory();
		subcategory.setSubcategory_id(Integer.parseInt(request.getParameter("subcategory_id")));
		alcohol.setSubcategory(subcategory);

		alcoholService.update(alcohol, realPath, myFiles);

		return "redirect:/admin/alcohols";
	}

	// ● 술 한건 삭제하기
	@RequestMapping(value = "/admin/alcohols/delete/{alcohol_id}", method = RequestMethod.POST)
	public String deleteAlcohol(@PathVariable("alcohol_id") int alcohol_id, HttpServletRequest request) {
		FileManager fileManager = null;

		List<AlcoholImage> imgList = alcoholImageService.selectByAlcohol(alcohol_id);
		boolean flag = imgList.isEmpty();

		if (!flag) {
			fileManager = new FileManager();
			alcoholImageService.delete(alcohol_id);

			String filename = null;
			String path = request.getServletContext().getRealPath("data");
			for (int i = 0; i < imgList.size(); i++) {
				filename = imgList.get(i).getFilename();
				fileManager.deleteFile(path + "/" + filename);
			}
		}
		alcoholService.delete(alcohol_id);

		return "redirect:/admin/alcohols";
	}

	/***************************************************************
	 * Client Review Page *
	 ***************************************************************/
	// ● 술 전체 불러오기
	@RequestMapping(value = "/alcohols", method = RequestMethod.GET)
	public ModelAndView getAlcoholReviewList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		// Alcohol 모든 정보 가져오기
		List<Alcohol> alcoholList = alcoholService.selectAll();
		
		String score=null;
		List<Review> reviews=null;
		ReviewScoreSetter scoreSetter = new ReviewScoreSetter();
		//여기서 알콜 하나하나에 reviewList 넣어줘야됨 - 왜? 평점 구해야되니까
		for(int i=0;i<alcoholList.size();i++) {
			Alcohol alcohol = alcoholList.get(i);
			//System.out.println("★ 스코어 대입전 : "+alcohol.getScore());
			reviews = reviewService.selectByAlcohol(alcohol.getAlcohol_id());
			if(reviews.size()>0) {
				scoreSetter.setScore(reviews);
				score = scoreSetter.getAverageScore();
				alcohol.setScore(score);
			}else {
				score="0.0";
				alcohol.setScore(score);
			}
			scoreSetter.initScore();
			
			//System.out.println("★ 스코어 대입후 : "+alcohol.getScore());
		}
		// 리뷰 페이지에서 쓰일 Pager 설정
		Pager pager = new Pager();
		int totalRecord = alcoholList.size();
		int pageSize = 9;
		int blockSize = 10;
		pager.init(request, totalRecord, pageSize, blockSize);

		mav.addObject("alcoholList", alcoholList);
		mav.addObject("pager", pager);
		mav.setViewName("review/review");

		return mav;
	}

	// ● 한건 불러오기
	@RequestMapping(value = "/alcohols/{alcohol_id}", method = RequestMethod.GET)
	public ModelAndView getAlcoholReview(@PathVariable("alcohol_id") int alcohol_id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Alcohol alcohol = alcoholService.select(alcohol_id);
		List reviewList = reviewService.selectByAlcohol(alcohol_id);

		Pager pager = new Pager();
		int totalRecord = reviewList.size();
		int pageSize = 5;
		int blockSize = 5;
		pager.init(request, totalRecord, pageSize, blockSize);

		alcoholService.hitup(alcohol_id);
		mav.addObject("alcohol", alcohol);
		mav.addObject("reviewList", reviewList);
		mav.addObject("pager", pager);
		mav.setViewName("review/review-detail");

		return mav;
	}

	// ● 술이름 검색하기
	@RequestMapping(value = "/alcohols/search", method = RequestMethod.GET)
	public ModelAndView searchAlcoholReviewList(HttpServletRequest request, String searchWord) {
		ModelAndView mav = new ModelAndView();
		System.out.println("AlcoholController/searchAlcoholReviewList 호출!");
		System.out.println("검색하려는 술의 이름은 : " + searchWord);

		searchWord = "%" + searchWord + "%";
		List<Alcohol> alcoholList = alcoholService.selectAllByName(searchWord);

		// 리뷰 페이지에서 쓰일 Pager 설정
		Pager pager = new Pager();
		int totalRecord = alcoholList.size();
		int pageSize = 9;
		int blockSize = 10;
		pager.init(request, totalRecord, pageSize, blockSize);

		mav.addObject("alcoholList", alcoholList);
		mav.addObject("pager", pager);
		mav.setViewName("review/review");

		return mav;
	}

	// ● Review 페이지에서 Topcategory 눌렀을 때 리스트 가져오기
	@RequestMapping(value = "/alcohols/review/top", method = RequestMethod.GET)
	public ModelAndView getAlcoholListByTopCategory(HttpServletRequest request, int topcategory_id) {
		ModelAndView mav = new ModelAndView();
		System.out.println("AlcoholController/getAlcoholListByTopCategory 호출!");
		System.out.println("AlcoholController/getAlcoholListByTopCategory 반환받은 top_id는 : "+topcategory_id);
		
		//탑카테고리 먼저 가져옴 <- sub랑 alcohol 다 가지고 있게 만듬
		Topcategory top=topcategoryService.selectWhereReview(topcategory_id);
		
		//alcohol만 추출해서 alcoholList에 담아줌
		System.out.println("AlcoholController/getAlcoholListByTopCategory() 호출 : name은 : "+top.getName());
		
		System.out.println("AlcoholController/getAlcoholListByTopCategory() 호출 sub_c_id는 : "+top.getSubcategoryList().get(0).getSubcategory_id());
		System.out.println("AlcoholController/getAlcoholListByTopCategory() 호출 sub_c_namedms : "+top.getSubcategoryList().get(0).getName());
		
		List subList=top.getSubcategoryList();
		
		
		String score=null;
		List<Review> reviews=null;
		ReviewScoreSetter scoreSetter = new ReviewScoreSetter();
		//sub에 들어있는거 다 꺼내와야됨!
		List alcoholList=new ArrayList();
		for(int i=0; i<subList.size();i++) {
			//subList에서 하나씩 꺼내옴. 왜? 서브카테고리가 가지고 있는 AlcoholList 가져오려고
			Subcategory sub=(Subcategory)subList.get(i);
			List al_List=sub.getAlcoholList();
			for(int k=0; k<al_List.size(); k++) {
				
					Alcohol alcohol = (Alcohol) al_List.get(k);
					System.out.println("★ 스코어 대입전 : "+alcohol.getScore());
					reviews = reviewService.selectByAlcohol(alcohol.getAlcohol_id());
					if(reviews.size()>0) {
						scoreSetter.setScore(reviews);
						score = scoreSetter.getAverageScore();
						alcohol.setScore(score);
					}else {
						score="0.0";
						alcohol.setScore(score);
						System.out.println("★ 스코어 대입후 : "+alcohol.getScore());
					}
				scoreSetter.initScore();
				alcoholList.add(al_List.get(k));
			}
		}

		// 리뷰 페이지에서 쓰일 Pager 설정
		Pager pager = new Pager();
		int totalRecord = alcoholList.size();
		int pageSize = 9;
		int blockSize = 10;
		pager.init(request, totalRecord, pageSize, blockSize);

		mav.addObject("alcoholList", alcoholList);
		mav.addObject("pager", pager);
		mav.setViewName("review/review-category");

		return mav;
	}

	/***************************************************************
	 * Client Main Page *
	 ***************************************************************/
	// ● 메인페이지에 표시할 술 정보들 불러오기
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getMainAlcoholList() {
		System.out.println("AlcoholController/getMainAlcoholList() 호출");
		// 조회수 높은 순으로 가져오기
		List<Alcohol> alcoholListByHit = alcoholService.selectAllByHit();
		System.out.println(alcoholListByHit.get(0).getName());
		// 최근에 리뷰가 등록된 정보도 가져오게 하기
		ModelAndView mav = new ModelAndView();
		mav.addObject("alcoholListByHit", alcoholListByHit);
		mav.setViewName("index");
		return mav;
	}

	/***************************************************************
	 * Handling Exception *
	 ***************************************************************/
	@ExceptionHandler(RegistFailException.class)
	public ModelAndView handleRegistFail(RegistFailException e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("err", e);

		return mav;
	}

	@ExceptionHandler(EditFailException.class)
	public ModelAndView handleEditFail(EditFailException e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("err", e);

		return mav;
	}

	@ExceptionHandler(DeleteFailException.class)
	public ModelAndView handleDeleteFail(DeleteFailException e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("err", e);

		return mav;
	}

	@ExceptionHandler(SQLIntegrityConstraintViolationException.class)
	public ModelAndView handleSqlFkException(SQLIntegrityConstraintViolationException e) {
		e.printStackTrace();

		ModelAndView mav = new ModelAndView("error/error");
		DeleteFailException msg = new DeleteFailException(
				"삭제 실패 ( CODE : 333 ) 현 카테고리 하위에 제품이 등록 되어 있습니다. 제품 먼저 삭제 해주세요.");
		mav.addObject("err", msg);

		return mav;
	}
	///// 예외 핸들링/////
}
