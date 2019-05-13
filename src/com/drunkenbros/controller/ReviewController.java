package com.drunkenbros.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.drunkenbros.common.Pager;
import com.drunkenbros.exception.DeleteFailException;
import com.drunkenbros.exception.EditFailException;
import com.drunkenbros.exception.RegistFailException;
import com.drunkenbros.model.domain.Alcohol;
import com.drunkenbros.model.domain.Member;
import com.drunkenbros.model.domain.Review;
import com.drunkenbros.model.service.ReviewService;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService reviewService;

	/***************************************************************
	 * Admin
	 ***************************************************************/
	// 리뷰 정보 전부 가져오기
	@RequestMapping(value = "/admin/reviews", method = RequestMethod.GET)
	public ModelAndView adminGetReviewList(HttpServletRequest request) {
		System.out.println("ReviewController/adminGetReviewList()을 호출");

		List<Review> reviewList = reviewService.selectAll();
		Pager pager = new Pager();

		pager.init(request, reviewList.size(), 10, 10);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/review/review-table"); // 접속할 jsp 주소 등록

		mav.addObject("pager", pager);
		mav.addObject("reviewList", reviewList);

		return mav;
	}

	// 리뷰 한건 삭제하기
	@RequestMapping(value = "/admin/review/delete", method = RequestMethod.GET)
	public String adminDeleteMember(int review_id) {
		System.out.println("ReviewController/adminDeleteMember() 요청");
		reviewService.delete(review_id);
		return "redirect:/admin/reviews";
	}

	/***************************************************************
	 * Client
	 ***************************************************************/
	// 리뷰 등록
	@RequestMapping(value = "/review/regist", method = RequestMethod.POST)
	public String registReview(HttpServletRequest request, Review review) {
		Alcohol alcohol = new Alcohol();
		alcohol.setAlcohol_id(Integer.parseInt(request.getParameter("alcohol_id")));
		Member member = (Member) request.getSession().getAttribute("member");

		System.out.println("▶ ReviewController.registReview() ==> member_id : " + member.getMember_id());
		System.out.println("▶ ReviewController.registReview() ==> alcohol_id : " + alcohol.getAlcohol_id());

		review.setAlcohol(alcohol);
		review.setMember(member);

		reviewService.insert(review);

		System.out.println("▶ ReviewController.registReview() ==> 리뷰 작성 완료");
		System.out.println("▶ ReviewController.registReview() ==> review_id : " + review.getReview_id());
		System.out.println("▶ ReviewController.registReview() ==> 작성자 ID : " + review.getMember().getId());
		System.out.println("▶ ReviewController.registReview() ==> review.Score : " + review.getScore());

		return "redirect:/alcohols/" + alcohol.getAlcohol_id();
	}

	@RequestMapping(value = "/review/delete/{alcohol_id}", method = RequestMethod.POST)
	public String deleteReview(@PathVariable("alcohol_id") int alcohol_id, int review_id) {

		System.out.println("▶ ReviewController.deleteReview() ==> 삭제할 리뷰 review_id : " + review_id);
		System.out.println("▶ ReviewController.deleteReview() ==> 삭제할 리뷰가 있는 alcohol_id : " + alcohol_id);
		reviewService.delete(review_id);

		return "redirect:/alcohols/" + alcohol_id;
	}

	// 신고창 띄우기
	@RequestMapping("/report")
	public ModelAndView goReport() {
		ModelAndView mav = new ModelAndView("review/report");
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
}