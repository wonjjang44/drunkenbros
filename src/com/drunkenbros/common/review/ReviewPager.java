package com.drunkenbros.common.review;

import javax.servlet.http.HttpServletRequest;

public class ReviewPager {
	private int currentPage=1;	//현재 유저가 보고 있는 페이지
	private int totalRecord;	//DB에 담긴 총 레코드 갯수
	private int pageSize=9;		//페이지당 보여질 레코드 수
	private int totalPage;			//총 페이지 갯수
	private int blockSize=10;	//화면에 표시될 페이지 갯수 ex)[1][2][3]
	private int firstPage;
	private int lastPage;
	private int curPos;			//페이지 첫번째 게시물이 DB에서 몇번째 게시물인지 확인하는 변수
	private int num;			//페이지 첫번째 게시물의 번호
	

	//호출시 마다, 페이징 처리 변수값들의 계산을 함
	public void init(HttpServletRequest request, int totalRecord) {
		//사용자가 페이지 번호를 누르면 그 누른 번호를 현재 페이지로 대체해야함
		if(request.getParameter("currentPage")!=null) {
			currentPage=Integer.parseInt(request.getParameter("currentPage"));	
		}
		this.totalRecord=totalRecord;
		totalPage=(int)Math.ceil((float)totalRecord/pageSize);
		firstPage=currentPage-((currentPage-1)%blockSize);
		lastPage=firstPage+(blockSize-1);
		
		curPos=(currentPage-1)*pageSize;
		num=totalRecord-curPos;
	}


	public int getCurrentPage() {
		return currentPage;
	}


	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}


	public int getTotalRecord() {
		return totalRecord;
	}


	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getTotalPage() {
		return totalPage;
	}


	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}


	public int getBlockSize() {
		return blockSize;
	}


	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}


	public int getFirstPage() {
		return firstPage;
	}


	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}


	public int getLastPage() {
		return lastPage;
	}


	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}


	public int getCurPos() {
		return curPos;
	}


	public void setCurPos(int curPos) {
		this.curPos = curPos;
	}


	public int getNum() {
		return num;
	}


	public void setNum(int num) {
		this.num = num;
	}
	
	
}
