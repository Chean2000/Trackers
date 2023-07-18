package com.teamproject.trackers.biz.product;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pageCategory")
public class PageCategoryVO {
	
	@Id
	@Column(name="p_id")
	private long pid;
	
	private boolean whole;
	private boolean monthly;
	private boolean weekly;
	private boolean habit;
	private boolean mood;
	private boolean reading;
	private boolean expense;
	private boolean study;
	private boolean sticker;
	private boolean etc;
	
	
	public long getPid() {
		return pid;
	}
	public void setPid(long pid) {
		this.pid = pid;
	}
	public boolean isWhole() {
		return whole;
	}
	public void setWhole(boolean whole) {
		this.whole = whole;
	}
	public boolean isMonthly() {
		return monthly;
	}
	public void setMonthly(boolean monthly) {
		this.monthly = monthly;
	}
	public boolean isWeekly() {
		return weekly;
	}
	public void setWeekly(boolean weekly) {
		this.weekly = weekly;
	}
	public boolean isHabit() {
		return habit;
	}
	public void setHabit(boolean habit) {
		this.habit = habit;
	}
	public boolean isMood() {
		return mood;
	}
	public void setMood(boolean mood) {
		this.mood = mood;
	}
	public boolean isReading() {
		return reading;
	}
	public void setReading(boolean reading) {
		this.reading = reading;
	}
	public boolean isExpense() {
		return expense;
	}
	public void setExpense(boolean expense) {
		this.expense = expense;
	}
	public boolean isStudy() {
		return study;
	}
	public void setStudy(boolean study) {
		this.study = study;
	}
	public boolean isSticker() {
		return sticker;
	}
	public void setSticker(boolean sticker) {
		this.sticker = sticker;
	}
	public boolean isEtc() {
		return etc;
	}
	public void setEtc(boolean etc) {
		this.etc = etc;
	}
	

}
