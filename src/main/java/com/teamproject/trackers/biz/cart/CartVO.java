package com.teamproject.trackers.biz.cart;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Entity
@Table(name="cart")
@IdClass(CartId.class)
public class CartVO {
	
	@Id
	private long id;
	@Id
	@Column(name="p_id")
	private long pid;
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getPid() {
		return pid;
	}
	public void setPid(long pid) {
		this.pid = pid;
	}
	
}
