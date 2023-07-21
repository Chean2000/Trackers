

//contact.html 불러오기 
/*
async function fetchHtmlAsText(url) {
    return await (await fetch(url)).text();
};

async function importPage(target) {
    document.querySelector('#' + target).innerHTML = await fetchHtmlAsText(target + '.do');
};
importPage('st-main');
*/



//애니메이션
$(()=>{
	tabActive();
	
    $('#tab div').bind('click',function(e){
		
        let tab = e.target.getAttribute('id');
        if(tab=='co-tab'){
	        e.preventDefault();
	        $('#st-tab').removeClass();
	        $(this).addClass('active').addClass('stretchRight');
	   
	   		// URI 변경 - 임시
	   		//history.pushState('', '', '/community/posts');
	   
		    // 탭+헤더 애니메이션 디자인
	        // 프로필, 회원정보 수정인 경우
	        let path = $(location).attr('pathname');
			let path_name = path.substr(1, path.indexOf('.')-1);
	    	
	    	console.log(path);
	    	console.log(path_name);
	    	if(path_name == 'profile' || path_name.includes('user-')){
				$('#tab .active').css('background', '#fff');
				$('#header-back-color').css('width', '100%').css('background-color', '#fff').css('right', '0');
				$('#body-back-color').css('width', '100%').css('background-color', '#fff').css('right', '0');
			}else{
				$('#tab .active').css('background', '#f2f2f6'); 
				$('#header-back-color').css('width', '100%').css('background-color', '#f2f2f6').css('right', '0');
				$('#body-back-color').css('width', '100%').css('background-color', '#f2f2f6').css('right', '0');
			}
	
	        $('#st-tab').css('background', '#dce0e3');
	       
	        //$(this).removeClass('stretchRight');
			//$('#co-main').show();
	        //$('#st-main').hide();
	    }
	    else if(tab=='st-tab'){
	        e.preventDefault();
	        $('#co-tab').removeClass();
	        $(this).addClass('active').addClass('stretchLeft');
	         
	        // URI 변경 - 임시
	   		//history.pushState('', '', '/store/main');
	   		
	        // 탭+헤더 애니메이션 디자인
	        $('#tab .active').css('background', '#fff'); 
	        $('#co-tab').css('background', '#dce0e3');  
	        $('#header-back-color').css('width', '0%').css('left', '0');
	        $('#body-back-color').css('width', '0%').css('left', '0');
	        $('body').css('background-color', '#fff');
	        //$(this).removeClass('stretcLeft');
	        //$('#st-main').show();
	        //$('#co-main').hide(); 
		}
    	
    	
        setTimeout(function(){
        	if(tab == 'co-tab'){
        		location.href="/community/posts?page=0";
	        }
	        else if(tab=='st-tab'){
	        	location.href="/store/main";        
	        }
	    }, 500);
        
        
    });
});


function tabActive(){
	let path = $(location).attr('pathname');
	let search = $(location).attr('search');
	
	if(path.includes('community')){
		$('#co-tab').addClass("active").css('background', '#f2f2f6');
		$('#header-back-color').css('width', '100%').css('right', '0');
		$('#body-back-color').css('width', '100%').css('right', '0');
	}
	else if(path.includes('/profiles') || (path.includes('users')&&search.includes('?path'))){
		$('#co-tab').addClass("active").css('background', '#fff');
	}
	else{
		$('#st-tab').addClass("active").css('background', '#fff');
		  
        $('#header-back-color').css('width', '0%').css('left', '0');
        $('#body-back-color').css('width', '0%').css('left', '0');
		

	}
}

