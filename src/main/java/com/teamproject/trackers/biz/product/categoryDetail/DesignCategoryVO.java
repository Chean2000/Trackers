package com.teamproject.trackers.biz.product.categoryDetail;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="designCategory")
public class DesignCategoryVO {

	@Id
	@Column(name="p_id")
	private long pid;
	
	private boolean minimal = false;
	private boolean illustration = false;
	private boolean photo = false;
	
	
	public long getPid() {
		return pid;
	}
	public void setPid(long pid) {
		this.pid = pid;
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
	
	
	
}
