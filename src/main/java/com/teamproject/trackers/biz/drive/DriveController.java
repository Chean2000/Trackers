package com.teamproject.trackers.biz.drive;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.google.gson.JsonObject;
import com.teamproject.trackers.biz.followSubscribeLike.SubscribeInfoVO;

@Controller
public class DriveController {
	

	@Autowired
	private DriveService driveService;
	@Autowired
	private HttpServletRequest req;
	
	private String tmpPath = null;
	private String filePath = null;
	
	
	/* 구독 파일 저장 */
	public String SubscribeUpload(SubscribeInfoVO vo, MultipartFile mfile) throws Exception {
	
		tmpPath = req.getServletContext().getRealPath("/resources/tmpfile/");		// 위치 생각해 볼 것
        
		if (!mfile.isEmpty()) {
			int month = Calendar.getInstance().get(Calendar.MONTH)+1;
			String productName = month+"월 구독 상품";
			String originalName = mfile.getOriginalFilename();
			String type = originalName.substring(originalName.indexOf('.'));
			
			String fileName = vo.getId()+"_"+productName+type;		// 저장되는 파일 이름
			
			File uploadFile = new File(tmpPath+fileName);
			
			// 임시 폴더에 파일 올리기
			mfile.transferTo(uploadFile);
			System.out.println("임시 업로드 성공");
			
			// 드라이브에 업로드
			filePath = driveService.fileUpload(fileName, uploadFile);
			System.out.println("드라이브 업로드 성공");
			
			// 임시폴더에 올린 파일 삭제
			uploadFile.delete();
			System.out.println("임시 삭제 성공");
			
		}
		System.out.println("상품 등록 완료");
		
		return filePath;
	}
	
	/* 구독 파일 삭제 */
	public void SubscribeDelete(SubscribeInfoVO vo) throws Exception {
        
        driveService.fileDelete(vo.getFile());
        
		System.out.println("상품 삭제 완료");
	}
	
	
	
	/* 상품 파일 저장 */
	public String uploadProductFile(MultipartFile mfile) throws Exception {
		
		tmpPath = req.getServletContext().getRealPath("/resources/tmpfile/");		// 위치 생각해 볼 것
        
		if (!mfile.isEmpty()) {
			String originalName = mfile.getOriginalFilename(); 
	        long now = System.currentTimeMillis(); 
	        String fileName = now+"-"+originalName;		// 저장되는 파일 이름	
	        
			File uploadFile = new File(tmpPath+fileName);

			// 임시 폴더에 파일 올리기
			mfile.transferTo(uploadFile);
			System.out.println("임시 업로드 성공");
			
			// 드라이브에 업로드
			filePath = driveService.fileUpload(fileName, uploadFile);
			System.out.println("드라이브 업로드 성공");
			
			// 임시폴더에 올린 파일 삭제
			uploadFile.delete();
			System.out.println("임시 삭제 성공");
			
		}
		System.out.println("상품 등록 완료");
		
		return filePath;
	}
	
	
}
