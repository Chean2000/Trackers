
//모달창 띄우기
const topimgModify = document.querySelector("#my-topimgdiv");
const profileimgModify = document.querySelector("#my-profileimg");
const modalClose = document.querySelector(".modalclose");

  // 배경 이미지
  topimgModify.addEventListener('click', function() {
    $(".modal").css("display", "block");
    $("#folder").val("background");
    $("#uploadbtn").val("배경 이미지 수정");
    
    let src = $("#my-topimgdiv img").attr("src");
    modalClose.addEventListener('click', () => modal_close('my-topimgdiv img', src));
    $('#chooseFile').on('change', () => loadFile('my-topimgdiv img', event))
  });

  // 프로필 이미지
  profileimgModify.addEventListener('click', function() {
    $(".modal").css("display", "block");
    $("#folder").val("profile");
    $("#uploadbtn").val("프로필 이미지 수정");
    
    let src = $("#my-profileimg").attr("src");
    modalClose.addEventListener('click', () => modal_close('my-profileimg', src));
    $('#chooseFile').on('change', () => loadFile('my-profileimg', event))
  });

/*
  modalClose.addEventListener('click', function() {
    $(".modal").css("display", "none");
  });
*/
  
  // 모달 닫는 함수(+ 이미지 초기화)
  function modal_close(id, src){
  	$(".modal").css("display", "none");
	$("#fileName").text("");
  	
	$("#"+id).attr("src", src);
	$("#chooseFile").off("change");				// 이벤트 제거
  }
  




function loadFile(id, event) {
    var file = event.target.files[0];
	console.log(event.target.files.length);
    var name = document.getElementById('fileName');
    name.textContent = file.name;
    
 	var reader = new FileReader(); 
    reader.onload = function(e) {
        $("#"+id).attr("src", e.target.result);
    }
    console.log(id);
    reader.readAsDataURL(file);

	/*
    var newImage = document.createElement("img");
    newImage.setAttribute("class", 'Img');

    newImage.src = URL.createObjectURL(file);   

    newImage.style.width = "70%";
    newImage.style.height = "70%";
    newImage.style.visibility = "hidden";   //버튼을 누르기 전까지는 이미지 숨기기
    newImage.style.objectFit = "contain";
    newImage.style.position = "relative";
    newImage.style.zIndex = 800; 
	
    var container = document.getElementById('image-show');
    container.appendChild(newImage);
    */
};


// 팔로우하기 버튼
function startf(){
	  // 원래 버튼은 display: none으로 감추고
	  document.getElementById("buttonright").style.display = "none";
	  // 바뀔 버튼은 display: block으로 표시
	  document.querySelector("#changef").style.display = "block";
};

// 로그인 안 했을 때 멤버십 가입하기 눌렀을 때
function showLoginAlertSub(){
	alert("로그인이 필요합니다.");
	$('#subModal').modal('hide'); // 모달 숨기기
	
}

function starts(){
	document.querySelector(".sbutton").style.display ="none" ;
	document.getElementById("changesbutton").style.display ="block";
}






