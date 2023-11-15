package com.teamproject.trackers.biz.product;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.data.annotation.Immutable;

@Entity
@Immutable 
@Table(name="productlist")
public class ProductListVO {
	
	@Id
	@Column(name="p_id")
	private long pid;
	@Column(name="p_name")
	private String pname;
	private int price;
	private int sale;
	@Column(name = "sale_price")
	private int salePrice;
	private String thumbnail;
	private int rating;
	@Temporal(TemporalType.DATE)
	@Column(name = "cre_date")
	private Date creDate;
	private int popularity;
	
	// 페이지 카테고리
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
	
	// 디자인 카테고리
	private boolean minimal;
	private boolean illustration;
	private boolean photo;
	
	// 크리에이터 id
	private long id;
	
	
	public long getPid() {
		return pid;
	}
	public void setPid(long pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public int getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public Date getCreDate() {
		return creDate;
	}
	public void setCreDate(Date creDate) {
		this.creDate = creDate;
	}
	public int getPopularity() {
		return popularity;
	}
	public void setPopularity(int popularity) {
		this.popularity = popularity;
	}
	public boolean isWholet() {
		return whole;
	}
	public void setWholet(boolean whole) {
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
	public boolean isMinimal() {
		return minimal;
	}
	public void setMinimal(boolean minimal) {
		this.minimal = minimal;
	}
	public boolean isIllustration() {
		return illustration;
	}
	public void setIllustration(boolean illustration) {
		this.illustration = illustration;
	}
	public boolean isPhoto() {
		return photo;
	}
	public void setPhoto(boolean photo) {
		this.photo = photo;
	}
	public boolean isWhole() {
		return whole;
	}
	public void setWhole(boolean whole) {
		this.whole = whole;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
}
