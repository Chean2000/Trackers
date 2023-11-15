package com.teamproject.trackers.biz.purchase;

public class WebhookVO {
	
	private String imp_uid;
	private String merchant_uid;
	private String status;
	
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String toString() {
		return "imp_uid: "+imp_uid+", merchant_uid: "+merchant_uid+", status: "+status;
	}
	
	

}
