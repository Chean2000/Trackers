package com.teamproject.trackers.biz.customerService;

import java.sql.Date;

public class CustomerServiceVO {
	private long csc_id;
	private long id;
	private Date cre_date;
	private String title;
	private String content;
	private String answer;
	
	
	public long getCsc_id() {
		return csc_id;
	}
	public void setCsc_id(long csc_id) {
		this.csc_id = csc_id;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Date getCre_date() {
		return cre_date;
	}
	public void setCre_date(Date cre_date) {
		this.cre_date = cre_date;
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
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
}
