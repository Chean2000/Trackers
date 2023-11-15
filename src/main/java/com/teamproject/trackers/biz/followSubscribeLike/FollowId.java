package com.teamproject.trackers.biz.followSubscribeLike;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class FollowId implements Serializable{
	
	private long from_id;
	private long to_id;
}
