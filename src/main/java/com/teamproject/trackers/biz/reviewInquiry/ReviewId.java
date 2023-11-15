package com.teamproject.trackers.biz.reviewInquiry;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewId implements Serializable{
	
	private long id;
	private long pid;
}
