package com.drunkenbros.model.domain;

public class Reply {
	private int reply_id;
	private Review review;
	private Member member;
	private String detail;
	private String regdate;
	
	protected int getReply_id() {
		return reply_id;
	}
	protected void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	protected Review getReview() {
		return review;
	}
	protected void setReview(Review review) {
		this.review = review;
	}
	protected Member getMember() {
		return member;
	}
	protected void setMember(Member member) {
		this.member = member;
	}
	protected String getDetail() {
		return detail;
	}
	protected void setDetail(String detail) {
		this.detail = detail;
	}
	protected String getRegdate() {
		return regdate;
	}
	protected void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
