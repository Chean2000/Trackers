package com.teamproject.trackers.biz.notice;

import java.sql.Date;

public class NoticeVO {
	private long n_id;
	private long id;
	private String content;
	private Date cre_date;
	

	public long getN_id() {
		return n_id;
	}
	public void setN_id(long n_id) {
		this.n_id = n_id;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCre_date() {
		return cre_date;
	}
	public void setCre_date(Date cre_date) {
		this.cre_date = cre_date;
	}
	
	
}
