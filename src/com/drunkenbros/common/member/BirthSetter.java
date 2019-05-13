package com.drunkenbros.common.member;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

public class BirthSetter {
	private GregorianCalendar calendar; // 생년월일 입력을 위한 부품
	private List<String> yearList;
	private List monthList;
	private List dateList;

	public BirthSetter() {
		//계획 : select 에서 change 이벤트로 년, 월 변경시마다 date가 초기화되도록 만듬
		calendar=new GregorianCalendar(Locale.KOREA);
		yearList = new ArrayList();
		monthList = new ArrayList();
		dateList = new ArrayList();

		for (int i = 0; i < 100; i++) {
			yearList.add(Integer.toString(calendar.getWeekYear() - i));
		}
		for (int i = 1; i <= 12; i++) {
			if (i < 10) {
				monthList.add(0 + Integer.toString(i));
			} else {
				monthList.add(Integer.toString(i));
			}
		}
		setDate(calendar.getWeekYear(), 0);
	}

	// 선택된(넘겨받은) year, month에 따라 date세팅
	public void setDate(int year, int month) {
		dateList.clear();
		calendar.set(year, month - 1, 1);
		for (int i = 1; i <= calendar.getActualMaximum(calendar.DATE); i++) {
			if (i < 10) {
				dateList.add(0 + Integer.toString(i));
			} else {
				dateList.add(Integer.toString(i));
			}
		}
	}
	
	public GregorianCalendar getCalendar() {
		return calendar;
	}

	public void setCalendar(GregorianCalendar calendar) {
		this.calendar = calendar;
	}

	public List getYearList() {
		return yearList;
	}

	public void setYearList(List yearList) {
		this.yearList = yearList;
	}

	public List getMonthList() {
		return monthList;
	}

	public void setMonthList(List monthList) {
		this.monthList = monthList;
	}

	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}
	
	
}
