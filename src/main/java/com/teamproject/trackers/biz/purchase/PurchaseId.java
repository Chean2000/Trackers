package com.teamproject.trackers.biz.purchase;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseId implements Serializable {

	private long id;
	private long bak_p_id;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getBak_p_id() {
		return bak_p_id;
	}
	public void setBak_p_id(long bak_p_id) {
		this.bak_p_id = bak_p_id;
	}
}
