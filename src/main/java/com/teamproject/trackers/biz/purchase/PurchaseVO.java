package com.teamproject.trackers.biz.purchase;


import java.util.Date;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="purchase")
@IdClass(PurchaseId.class)
public class PurchaseVO {
	
	@Id
	private long id;
	@Id
	private long bak_p_id;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date cre_date;
	private long c_id;
	private int price;
	
	
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
	
	

	public Date getCre_date() {
		return cre_date;
	}
	public void setCre_date(Date cre_date) {
		this.cre_date = cre_date;
	}
	public long getC_id() {
		return c_id;
	}
	public void setC_id(long c_id) {
		this.c_id = c_id;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
}
