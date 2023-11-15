package com.teamproject.trackers.biz.drive;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.json.GoogleJsonResponseException;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
import com.google.api.services.drive.model.File;
import com.google.api.services.drive.model.FileList;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.nio.file.Files;
import java.security.GeneralSecurityException;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Repository;

/* class to demonstrate use of Drive files list API */
@Repository
public class DriveService {
	/**
	 * Application name.
	*/
	private static final String APPLICATION_NAME = "Trackers";
	/**
	* Global instance of the JSON factory.
	*/
	private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();
	/**
	* Directory to store authorization tokens for this application.
	*/
	private static final String TOKENS_DIRECTORY_PATH = "tokens";
  
	// 업로드 드라이브 위치
	private static final List<String> path = List.of("");		// 위치 필수!

	/**
	* Global instance of the scopes required by this quickstart.
	* If modifying these scopes, delete your previously saved tokens/ folder.
	* 
	* 여기 권한을 수정해야 파일 읽기만 할건지 쓰기말한거지 등등을 결정할 수 있고,
	* 매번 토큰 새로 처리하는게 아니라 StoredToken이 저장되기 때문에 tokens폴더에 있는 StoredCredential를 삭제해줘야함
	* 
	*/
	private static final List<String> SCOPES = Collections.singletonList(DriveScopes.DRIVE);		// DRIVE_METADATA_READONLY
	private static final String CREDENTIALS_FILE_PATH = "/credentials.json";

	/**
	* Creates an authorized Credential object.
	*
	* @param HTTP_TRANSPORT The network HTTP Transport.
	* @return An authorized Credential object.
	* @throws IOException If the credentials.json file cannot be found.
	*/
	private static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws IOException {
		// Load client secrets.
		InputStream in = DriveService.class.getResourceAsStream(CREDENTIALS_FILE_PATH);
		if (in == null) {
			throw new FileNotFoundException("Resource not found: " + CREDENTIALS_FILE_PATH);
		}
		GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

		// Build flow and trigger user authorization request.
		GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
					HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
					.setDataStoreFactory(new FileDataStoreFactory(new java.io.File(TOKENS_DIRECTORY_PATH)))
					.setAccessType("offline")
					.build();
		LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
		Credential credential = new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");
		//returns an authorized Credential object.
		return credential;
	}
/*
	public static void main(String... args) throws IOException, GeneralSecurityException {
		// Build a new authorized API client service.
		Drive service = createService();
    
		// 파일 업로드
		fileUpload(service);
    
		// 파일 수정
		//fileUpdate(service);

		// 파일 삭제
		//fileDelete(service);
	}
	*/
	
	// api 서비스 구축
	private static Drive createService() throws GeneralSecurityException, IOException {
		final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
		Drive service = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
				.setApplicationName(APPLICATION_NAME)
				.build();
		
		return service;
	}
  
	// 파일 업로드
	public String fileUpload(String fileName, java.io.File uploadFile) throws IOException, GeneralSecurityException {
	    
		Drive service = createService();
		
		System.out.println("\n\n업로드 시작..");
	    
	    File fileMetaData = new File();
	    fileMetaData.setName(fileName).setParents(path); // 업로드할 파일 이름(크리에이터id_상품id_상품이름)
	    
	    //java.io.File f = new java.io.File(uploadFile);	// 올릴 파일 위치

	    // 따로 정해진 타입이 없으면 application/octet-stream (바이너리 데이터)
	    String mimeType = Files.probeContentType(uploadFile.toPath());
	    FileContent fileContent = new FileContent(mimeType, uploadFile);	
	    
	    // 업로드
	    File file = service.files().create(fileMetaData,fileContent).execute();

	    System.out.println("\n\n업로드 종료..");
	    	
	    String fileId = file.getId();
	    System.out.println("id: "+ fileId);//https://drive.google.com/file/d/{fileId} -> 다운로드 링크	
	    
	    return fileId;
	}
  
	// 파일 수정
	public void fileUpdate(String id) throws GeneralSecurityException, IOException {
		
		Drive service = createService();
		
		System.out.println("\n\n수정 시작..");
	    try {
	    	File fileMetaData = new File();
	        fileMetaData.setName("test_modify.pdf"); // 수정할 파일 이름
	        
	        java.io.File f = new java.io.File("src/main/img/test.pdf");	// 수정 파일
	        // 따로 정해진 타입이 없으면 application/octet-stream (바이너리 데이터)
	        FileContent fileContent = new FileContent("application/pdf",f);		// image/jpeg로 올려도 다운로드 받으면 pdf로 들어오긴 함
	        
	        // 파일 수정
	        service.files().update(id, fileMetaData, fileContent).execute();
	        
	        System.out.println("\n\n 수정 완료.."); 
	    }catch (IOException e) {
	        e.printStackTrace();
	    }
	}
  
  
	// 파일 삭제
	public void fileDelete(String id) throws GeneralSecurityException, IOException {
		
		Drive service = createService();
		
		System.out.println("\n\n삭제 시작..");
	    try {
	        service.files().delete(id).execute();
	        System.out.println("\n\n삭제 완료..");
	    }catch (IOException e) {
	        e.printStackTrace();
	    }
	}
}