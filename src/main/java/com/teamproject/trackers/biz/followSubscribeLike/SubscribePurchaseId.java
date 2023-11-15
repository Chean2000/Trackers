package com.teamproject.trackers.biz.followSubscribeLike;

import java.io.Serializable;

import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SubscribePurchaseId implements Serializable {

	private long subscribeId;
	private long id;
	
}
