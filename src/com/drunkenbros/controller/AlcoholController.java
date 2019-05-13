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
	 * ������ ����
	 ***************************************************************/
	@RequestMapping(value = "/admin/alcohol/regist", method = RequestMethod.GET)
	public ModelAndView goAboutUs() {
		ModelAndView mav=new ModelAndView("admin/alcohol/alcohol-regist");
		return mav;
	}
	
	/***************************************************************
	 * For Topcategory *
	 ***************************************************************/
	// �� žī�װ� �Ѱ� ���
	@RequestMapping(value = "/admin/topcategories", method = RequestMethod.POST)
	public String addTopcategory(Topcategory topcategory) {
		topcategoryService.insert(topcategory);
		String viewName = "redirect:/admin/topcategories";

		return viewName;
	}

	// �� žī�װ� �ҷ�����
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

	// �� žī�װ� �Ѱ� ����
	@RequestMapping(value = "/admin/topcategories/edit", method = RequestMethod.POST)
	public String editTopcategory(Topcategory topcategory) {
		topcategoryService.update(topcategory);

		return "redirect:/admin/topcategories";
	}

	// �� žī�װ� �Ѱ� ����
	@RequestMapping(value = "/admin/topcategories/delete/{topcategory_id}", method = RequestMethod.POST)
	public String deleteTopcategory(@PathVariable("topcategory_id") int topcategory_id) {
		topcategoryService.delete(topcategory_id);

		return "redirect:/admin/topcategories";
	}

	/***************************************************************
	 * For Subcategory *
	 ***************************************************************/
	// �� ����ī�װ� �Ѱ� ���
	@RequestMapping(value = "/admin/subcategories", method = RequestMethod.POST)
	public String addSubcategory(Subcategory subcategory, HttpServletRequest request) {
		Topcategory topcategory = new Topcategory();
		topcategory.setTopcategory_id(Integer.parseInt(request.getParameter("topcategory_id")));

		subcategory.setTopcategory(topcategory);
		subcategoryService.insert(subcategory);

		String viewName = "redirect:/admin/subcategories";

		return viewName;
	}

	// �� ����ī�װ� �ҷ�����
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

	// �� ����ī�װ� �Ѱ� �����ϱ�
	@RequestMapping(value = "/admin/subcategories/edit", method = RequestMethod.POST)
	public String editSubcategory(Subcategory subcategory, HttpServletRequest request) {
		Topcategory topcategory = new Topcategory();
		topcategory.setTopcategory_id(Integer.parseInt(request.getParameter("topcategory_id")));
		subcategory.setTopcategory(topcategory);

		subcategoryService.update(subcategory);

		return "redirect:/admin/subcategories";
	}

	// �� ����ī�װ� �Ѱ� �����ϱ�
	@RequestMapping(value = "/admin/subcategories/delete/{subcategory_id}", method = RequestMethod.POST)
	public ModelAndView deleteSubcategory(@PathVariable("subcategory_id") int subcategory_id) {
		ModelAndView mav = new ModelAndView();
		Alcohol alcohol = alcoholService.selectBySubcategory(subcategory_id);
		if (alcohol != null) {
			String msg = "���� ���� ( CODE : 333 ) �� ī�װ� ������ ��ǰ�� ��� �Ǿ� �ֽ��ϴ�. ��ǰ ���� ���� ���ּ���.";
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
	// �� �� �Ѱ� ���
	@RequestMapping(value = "/admin/alcohols", method = RequestMethod.POST)
	public String registAlcohol(Alcohol alcohol, HttpServletRequest request) {
		MultipartFile[] myFiles = alcohol.getMyFiles();
		String path = request.getServletContext().getRealPath("/data");

		// AlcoholDTO�� subcategory ���
		Subcategory subcategory = new Subcategory();
		subcategory.setSubcategory_id(Integer.parseInt(request.getParameter("subcategory_id")));
		alcohol.setSubcategory(subcategory);
		alcoholService.insert(alcohol, path, myFiles);

		return "redirect:/admin/alcohols";
	}

	// �� �� ��ü �ҷ�����
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

	// �� �� �Ѱ� �ҷ�����
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

	// �� �� �Ѱ� �����ϱ�
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

	// �� �� �Ѱ� �����ϱ�
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
	// �� �� ��ü �ҷ�����
	@RequestMapping(value = "/alcohols", method = RequestMethod.GET)
	public ModelAndView getAlcoholReviewList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		// Alcohol ��� ���� ��������
		List<Alcohol> alcoholList = alcoholService.selectAll();
		
		String score=null;
		List<Review> reviews=null;
		ReviewScoreSetter scoreSetter = new ReviewScoreSetter();
		//���⼭ ���� �ϳ��ϳ��� reviewList �־���ߵ� - ��? ���� ���ؾߵǴϱ�
		for(int i=0;i<alcoholList.size();i++) {
			Alcohol alcohol = alcoholList.get(i);
			//System.out.println("�� ���ھ� ������ : "+alcohol.getScore());
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
			
			//System.out.println("�� ���ھ� ������ : "+alcohol.getScore());
		}
		// ���� ���������� ���� Pager ����
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

	// �� �Ѱ� �ҷ�����
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

	// �� ���̸� �˻��ϱ�
	@RequestMapping(value = "/alcohols/search", method = RequestMethod.GET)
	public ModelAndView searchAlcoholReviewList(HttpServletRequest request, String searchWord) {
		ModelAndView mav = new ModelAndView();
		System.out.println("AlcoholController/searchAlcoholReviewList ȣ��!");
		System.out.println("�˻��Ϸ��� ���� �̸��� : " + searchWord);

		searchWord = "%" + searchWord + "%";
		List<Alcohol> alcoholList = alcoholService.selectAllByName(searchWord);

		// ���� ���������� ���� Pager ����
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

	// �� Review ���������� Topcategory ������ �� ����Ʈ ��������
	@RequestMapping(value = "/alcohols/review/top", method = RequestMethod.GET)
	public ModelAndView getAlcoholListByTopCategory(HttpServletRequest request, int topcategory_id) {
		ModelAndView mav = new ModelAndView();
		System.out.println("AlcoholController/getAlcoholListByTopCategory ȣ��!");
		System.out.println("AlcoholController/getAlcoholListByTopCategory ��ȯ���� top_id�� : "+topcategory_id);
		
		//žī�װ� ���� ������ <- sub�� alcohol �� ������ �ְ� ����
		Topcategory top=topcategoryService.selectWhereReview(topcategory_id);
		
		//alcohol�� �����ؼ� alcoholList�� �����
		System.out.println("AlcoholController/getAlcoholListByTopCategory() ȣ�� : name�� : "+top.getName());
		
		System.out.println("AlcoholController/getAlcoholListByTopCategory() ȣ�� sub_c_id�� : "+top.getSubcategoryList().get(0).getSubcategory_id());
		System.out.println("AlcoholController/getAlcoholListByTopCategory() ȣ�� sub_c_namedms : "+top.getSubcategoryList().get(0).getName());
		
		List subList=top.getSubcategoryList();
		
		
		String score=null;
		List<Review> reviews=null;
		ReviewScoreSetter scoreSetter = new ReviewScoreSetter();
		//sub�� ����ִ°� �� �����;ߵ�!
		List alcoholList=new ArrayList();
		for(int i=0; i<subList.size();i++) {
			//subList���� �ϳ��� ������. ��? ����ī�װ��� ������ �ִ� AlcoholList ����������
			Subcategory sub=(Subcategory)subList.get(i);
			List al_List=sub.getAlcoholList();
			for(int k=0; k<al_List.size(); k++) {
				
					Alcohol alcohol = (Alcohol) al_List.get(k);
					System.out.println("�� ���ھ� ������ : "+alcohol.getScore());
					reviews = reviewService.selectByAlcohol(alcohol.getAlcohol_id());
					if(reviews.size()>0) {
						scoreSetter.setScore(reviews);
						score = scoreSetter.getAverageScore();
						alcohol.setScore(score);
					}else {
						score="0.0";
						alcohol.setScore(score);
						System.out.println("�� ���ھ� ������ : "+alcohol.getScore());
					}
				scoreSetter.initScore();
				alcoholList.add(al_List.get(k));
			}
		}

		// ���� ���������� ���� Pager ����
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
	// �� ������������ ǥ���� �� ������ �ҷ�����
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getMainAlcoholList() {
		System.out.println("AlcoholController/getMainAlcoholList() ȣ��");
		// ��ȸ�� ���� ������ ��������
		List<Alcohol> alcoholListByHit = alcoholService.selectAllByHit();
		System.out.println(alcoholListByHit.get(0).getName());
		// �ֱٿ� ���䰡 ��ϵ� ������ �������� �ϱ�
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
				"���� ���� ( CODE : 333 ) �� ī�װ� ������ ��ǰ�� ��� �Ǿ� �ֽ��ϴ�. ��ǰ ���� ���� ���ּ���.");
		mav.addObject("err", msg);

		return mav;
	}
	///// ���� �ڵ鸵/////
}
