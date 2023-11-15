package com.teamproject.trackers.biz.followSubscribeLike;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.data.annotation.Transient;
import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name="subscribeinfo")
public class SubscribeInfoVO {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "subscribe_id")
	private long subscribeId;
	private long id;
	private String file;
	private String content;
	private int price;
	
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
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
}
