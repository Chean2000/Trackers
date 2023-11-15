package com.teamproject.trackers.biz.followSubscribeLike;

import java.sql.Date;

public class SubscribeVO {
	private long subscibe_id;
	private long id;
	private Date subscibe_date;
	
	
	public long getSubscibe_id() {
		return subscibe_id;
	}
	public void setSubscibe_id(long subscibe_id) {
		this.subscibe_id = subscibe_id;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Date getSubscibe_date() {
		return subscibe_date;
	}
	public void setSubscibe_date(Date subscibe_date) {
		this.subscibe_date = subscibe_date;
	}

	
}
