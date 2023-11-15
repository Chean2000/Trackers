		$( document ).ready( function() {
			$( 'button.comment' ).click( function() {
			$( '.divcomment' ).slideToggle();
			} );
		} );
		
		$( document ).ready( function() {
			$( 'button.commentList' ).click( function() {
			$( '.ulcommentList' ).slideToggle();
			} );
		} );
		
		$( document ).ready( function() {
			$( '.insertpost' ).click( function() {
			$( '.submitpost' ).slideToggle();
			} );
		} );
			
		
		/* co-main.do, post.do textarea */
		const DEFAULT_HEIGHT = 31; // textarea 기본 height
	
	    let textarea = document.getElementById('co-textarea');	    
	 	// Textarea 자동 높이 조절
	 	/*
	    textarea.oninput = (event) => {
	      let target = event.target;
	
	      target.style.height = 0;
	      if(target.scrollHeight >51){ //2줄일 때 높이
		      target.style.height = 7 + target.scrollHeight + 'px';  // 마지막 줄 아래 여백생기지 않음  	  
	      }else{
		      target.style.height = DEFAULT_HEIGHT + target.scrollHeight + 'px';  //2줄일 때 높이 유지  	      	  
	      }
	    };
	    */
	    
	    $(textarea).on('input', function(event) {
		    let target = event.target;
		
		    target.style.height = 0;
		    if(target.scrollHeight >51){ //2줄일 때 높이
			    target.style.height = 7 + target.scrollHeight + 'px';  // 마지막 줄 아래 여백생기지 않음  	  
		    }else{
			    target.style.height = DEFAULT_HEIGHT + target.scrollHeight + 'px';  //2줄일 때 높이 유지  	      	  
		    }
	    });
	    
	    
	    
	    function checkPhotoCount(){
	    	

			if(length> maxlength){
				alert("파일 개수가 4개를 초과했습니다.");
				return false;
			}else{
				if(confirm('포스트를 등록하시겠습니까?')){
					document.post.submit();				
				}
			}   	
	    }
	    
	    /*
	    var maxlength =4;
	    var length=0;*/
	    /* 사진 미리보기 */	
	    /*
	function imgPreview(event) {
		length=event.target.files.length;
		// 미리보기 초기화
	    	document.querySelector("div#thumb-preview").replaceChildren();
	    	
console.log(event.target.files.length);	    	
	    for (var image of event.target.files) {    	
	    		var reader = new FileReader();
	    		
	  	      reader.onload = function(event) {
	  	        var img = document.createElement("img");
	  	        img.style.width='200px';
	  	        img.setAttribute("src", event.target.result);
	  	        document.querySelector("div#thumb-preview").appendChild(img);
	  	      };
	  	
	  	      reader.readAsDataURL(image); 
	    	
	    }
	    
	  }
	  */
	  	var maxlength = 4;
		var length = 0;
		
		function imgPreview(event) {
		  
		 
		var uploadFile = event.target.files[0]; // Get the first selected file
		
		// Clear the preview area
		    document.querySelector("div#thumb-preview").replaceChildren();  
		
		if (uploadFile) {
		    length = event.target.files.length;

		for (var image of event.target.files) {
		      var reader = new FileReader();
		
		      reader.onload = function (event) {
		        var img = document.createElement("img");
		        img.style.width = '200px';
		        img.setAttribute("src", event.target.result);
		        document.querySelector("div#thumb-preview").appendChild(img);
		      };
		
		      reader.readAsDataURL(image);
		    }
		  }
		}
	  
	  
	  /* co-main.jsp에 있던 script 옮김 */    
	  
	  
	  /* <footer> 위에 있던 script 코드 */
	  $(document).ready(function() {
				    var contentHeight = $('.post-content-inner').height();
				    var lineHeight = parseFloat($('.post-content-inner').css('line-height'));
				    var maxHeight = 5 * lineHeight;
				    
				    if (contentHeight > maxHeight) {
				      $('.post-content-inner').addClass('collapsed');
				      $('.post-content-inner').css('max-height', maxHeight + 'px');
				      $('.post-content-inner').after('<span class="expand-button">더보기</span>');
				      
				      $('.expand-button').click(function() {
				        $('.post-content-inner').removeClass('collapsed');
				        $('.post-content-inner').css('max-height', 'none');
				        $(this).hide();
				      });
				    }
				  });
	  
	  
	   /* <footer> 아래에 있던 script 코드 */
	   $(document).ready(function() {
				    // 댓글 개수 이모티콘 클릭 이벤트
				    //$(".comment-count").click(function() {
				     // $(this).parent().parent().find(".comment-input").slideToggle('fast');
				    //});
				    // 좋아요 버튼 클릭 이벤트
				    $(".like-icon").on('click', function() {
				    console.log("LIKE");
				      var likeCount = parseInt($(this).parent().find(".like-count-number").text().trim());
				      likeCount++;
				      $(this).parent().find(".like-count-number").text(likeCount);
				    });
				  });
				  
				  
				  
				  
				  
				  
				  
				  /* 댓글 input창 보여주기 */
				  function showCommentInput(elem) { 
						var sessionId = document.getElementById('sessionId').value;				  	 			  	 
					  	if(sessionId != null){ /* 세션에 id있다면 토글 */
					  	
					  		const commentInput = $(elem).closest(".footer").find(".comment-input");
					    	commentInput.slideToggle('fast');
					  	}else{ /* 세션에 id없다면 alert 로그인필요함 알림 */
					  		alert("댓글을 작성하려면 로그인이 필요합니다.");
					  		return false;
					  	}
				     
				  }
				  /* 댓글 추가 */
				  function addComment() {
				    const commentText = $("#comment-text").val();
				    if (commentText.trim() !== "") {
				    //  const commentItem = $("<li>").text(commentText);
				    //  $("#comment-list").append(commentItem);
				    //  $("#comment-text").val("");
				    // 댓글 개수 증가
				    const commentCount = $(".comment-count-number");
				    let count = parseInt(commentCount.text().trim());
				    count++;
				    commentCount.text(count);
				    $("#insertcomment").submit(); 
		
				    
					}
				  }
	  
		
				var postform = $("form[name^='postId_']").get();
				function checkDeletePost(postId) {
					var divId = postId;
			console.log("divId "+divId);
					
					if(confirm('삭제하시겠습니까?')){
						for ( var i = 0; i < postform.length; i++) {
						var formname = postform[i].getAttribute('name');	

						var id = formname.substring(7,formname.length);
										
					        if(id == divId){
					        	postform[i].submit();
					        }
					    }
					}else{						
			        	return false;
					}					
				}
		
	  			
	  			
	  			var commentform = $("form[name^='commentid_']").get();
	  			function checkDeleteComment(commentid) {
	  				
	  				var divId = commentid;
			console.log("divId "+divId);
	  				
	  				if(confirm('삭제하시겠습니까?')){
	  					for ( var i = 0; i < commentform.length; i++) {
						var formname = commentform[i].getAttribute('name');	
	
						var id = formname.substring(10,formname.length);
											
					        if(id == divId){

					        	commentform[i].submit();
					        }
					    }
	  					
	  					
	  				}else{
	  					return false;
	  				}
	  			}
	  		
	
// 이미지 클릭 시 확대해서 모달창에 띄워주기
function showImageModal(e, src) {
	
	e.preventDefault();
	e.stopPropagation();
  
	$("#modal .modal-content").load("/community/image-modal", function() {
		$('.modal img').attr('src', src);
		$("#modal").modal("show");
	});
}







	  
