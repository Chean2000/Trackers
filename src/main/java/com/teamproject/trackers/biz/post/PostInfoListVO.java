package com.teamproject.trackers.biz.post;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.data.annotation.Immutable;

@Entity
@Immutable 
@Table(name = "postinfolist")
public class PostInfoListVO {
 
	@Id
	@Column(name = "post_id")
	private long postId;
	
	private long id;
	
	@Column(name="p_id", nullable = true)
	private Long pid;
	private String p_name;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="cre_date")
	private Date creDate = new Date();	

	private String content;
	private String name;
	private String url;
	private String profile_img;
	private long c_count;
	private long t_count;
	
	
	public long getPostId() {
		return postId;
	}
	public void setPostId(long postId) {
		this.postId = postId;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public Date getCreDate() {
		return creDate;
	}
	public void setCreDate(Date creDate) {
		this.creDate = creDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public long getC_count() {
		return c_count;
	}
	public void setC_count(long c_count) {
		this.c_count = c_count;
	}
	public long getT_count() {
		return t_count;
	}
	public void setT_count(long t_count) {
		this.t_count = t_count;
	}
	
}
