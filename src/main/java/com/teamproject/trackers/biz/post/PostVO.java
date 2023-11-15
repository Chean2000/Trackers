package com.teamproject.trackers.biz.post;



import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.data.annotation.CreatedDate;

import com.teamproject.trackers.biz.userCreator.UserVO;
 
@Entity
@Table(name = "post")  
public class PostVO {
 
	@Id
	@Column(name = "post_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long postId;

	@JoinColumn(name = "id")
	private long id; 
	
	//@JoinColumn(name="id")
	@Transient
    private List<UserVO> users = new ArrayList();
	
	
	public List<UserVO> getUsers() {
		return users;
	}
	public void setUsers(List<UserVO> users) {
		this.users = users;
	}
	
	@JoinColumn(columnDefinition="integer", name = "p_id") //외래키
	@Column(name="p_id", nullable = true) //null허용
	private Long pid; // wrapper타입일 때 null로 insert됨

	//@CreatedDate
	@Temporal(TemporalType.TIMESTAMP)
	private Date cre_date = new Date();	

	private String content;
	
	@Transient
	private UserVO userVO;

	
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}
	
	
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
	public Date getCre_date() {
		return cre_date;
	}
	public void setCre_date(Date cre_date) {
		this.cre_date = cre_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
