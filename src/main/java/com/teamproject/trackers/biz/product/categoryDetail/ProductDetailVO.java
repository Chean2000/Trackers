package com.teamproject.trackers.biz.product.categoryDetail;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "productDetails")
public class ProductDetailVO {
	
	
	@Id
	@Column(name="p_id")
	private long pid;
	private String img;
	
	
	public long getPid() {
		return pid;
	}
	public void setPid(long pid) {
		this.pid = pid;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
}
