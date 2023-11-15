package com.teamproject.trackers.biz.followSubscribeLike;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;



@Entity
@Table(name ="follow") 
@IdClass(FollowId.class)
public class FollowVO {
	
	@Id
	@Column(name="from_id")
	private long from_id;
	@Id
	private long to_id;
	
	public long getFrom_id() {
		return from_id;
	}
	public void setFrom_id(long from_id) {
		this.from_id = from_id;
	}
	public long getTo_id() {
		return to_id;
	}
	public void setTo_id(long to_id) {
		this.to_id = to_id;
	}
	
	
}
