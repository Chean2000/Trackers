package com.teamproject.trackers.biz.popup;

import java.sql.Date;

public class PopUpVO {
	private long pop_id;
	private Date start_date;
	private Date end_date;
	private String title;
	private String img;
	
	
	public long getPop_id() {
		return pop_id;
	}
	public void setPop_id(long pop_id) {
		this.pop_id = pop_id;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	
}
