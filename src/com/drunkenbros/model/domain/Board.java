package com.drunkenbros.model.domain;
//°Ô½Ã±Û
public class Board {
	private int board_id;
	private Tag tag_id;
	private Member member;
	private String title;
	private String content;
	private String regdate;
	private int hit;
	private String writer;
	private String searching;
	
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public Tag getTag_id() {
		return tag_id;
	}
	public void setTag_id(Tag tag_id) {
		this.tag_id = tag_id;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSearching() {
		return searching;
	}
	public void setSearching(String searching) {
		this.searching = searching;
	}
	
	
	
	
	
	
	
	
	
}
