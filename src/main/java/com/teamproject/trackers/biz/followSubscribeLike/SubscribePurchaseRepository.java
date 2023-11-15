package com.teamproject.trackers.biz.followSubscribeLike;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.teamproject.trackers.biz.userCreator.UserVO;


public interface SubscribePurchaseRepository extends JpaRepository<SubscribePurchaseVO, SubscribePurchaseId> {
	
	SubscribePurchaseVO findBySubscribeIdAndId(long subscribeId, long id);
	
	@Query(value ="SELECT sp.subscribe_id , sp.id, sp.payment FROM subscribepurchase sp WHERE sp.subscribe_id = (SELECT si.subscribe_id FROM subscribeinfo si WHERE si.id = (SELECT u.id FROM user u WHERE u.url = :url)) AND sp.id = :id" , nativeQuery = true)
	public SubscribePurchaseVO subT(@Param("url") String url, @Param("id") long id);
	
	@Query(value = "SELECT ifnull(si.subscribe_id, 0) FROM user u left join subscribeinfo si on u.id=si.id where u.url=:url", nativeQuery = true)
	public long subid(@Param("url") String url);
	
	//@Query(value = "INSERT INTO subscribepurchase(subscribe_id, id, payment, pay_date) VALUES (:sid,:id,1002000111222,now())", nativeQuery = true)
	//public SubscribePurchaseVO Sub();
}
