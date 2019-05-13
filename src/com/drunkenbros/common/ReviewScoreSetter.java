package com.drunkenbros.common;

import java.util.List;

import com.drunkenbros.model.domain.Review;

public class ReviewScoreSetter {
	private double totalScore;
	//ó���� ����ؼ� ���� ���� �������
	private double plainAverageScore;
	//�Ҽ��� ù°�ڸ��� ���� �ݿø��� �������
	private double roundAverageScore;
	//�Ҽ��� ù��° �ڸ������� ���� ��������� ���ڿ�
	private String averageScore;
	
	public void setScore(List<Review> reviewList) {
		for(int a=0;a<reviewList.size();a++){
			totalScore = totalScore + reviewList.get(a).getScore();
		}
		plainAverageScore = totalScore/reviewList.size();
		averageScore = String.format("%.1f",plainAverageScore);
		roundAverageScore = Math.round(plainAverageScore);
	}
	
	public void initScore() {
		totalScore = 0;
		plainAverageScore = 0;
		roundAverageScore = 0;
		averageScore = "0.0";
	}

	public double getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(double totalScore) {
		this.totalScore = totalScore;
	}

	public double getPlainAverageScore() {
		return plainAverageScore;
	}

	public void setPlainAverageScore(double plainAverageScore) {
		this.plainAverageScore = plainAverageScore;
	}

	public double getRoundAverageScore() {
		return roundAverageScore;
	}

	public void setRoundAverageScore(double roundAverageScore) {
		this.roundAverageScore = roundAverageScore;
	}

	public String getAverageScore() {
		return averageScore;
	}

	public void setAverageScore(String averageScore) {
		this.averageScore = averageScore;
	}
	
}
