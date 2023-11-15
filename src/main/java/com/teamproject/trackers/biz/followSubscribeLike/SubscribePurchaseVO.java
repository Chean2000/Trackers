package com.teamproject.trackers.biz.followSubscribeLike;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="subscribepurchase")
@IdClass(SubscribePurchaseId.class)
public class SubscribePurchaseVO {
	
	@Id
	@Column(name="subscribe_id")
	private long subscribeId;
	@Id
	private long id;
	private String payment;
	
	/*
	@Column(name="pay_date")
	@Temporal(TemporalType.DATE)
	private Date payDate;
	*/
	
	public long getSubscribeId() {
		return subscribeId;
	}
	public void setSubscribeId(long subscribeId) {
		this.subscribeId = subscribeId;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	
	/*
	public Date getPayDate() {
		return payDate;
	}
	
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	
	
	
	
	public String toString() {
		return "subscribeId: "+subscribeId+", id: "+id+", payment: "+payment+", payDate: "+payDate;
	}
	*/
	

}
