package com.teamproject.trackers.biz.product;

import java.sql.Date;

public class BakProductVO {
	private long bak_p_id;
	private String store_name;
	private String p_name;
	private String thumbnail;
	private String file;
	
	
	public long getBak_p_id() {
		return bak_p_id;
	}
	public void setBak_p_id(long bak_p_id) {
		this.bak_p_id = bak_p_id;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
}
