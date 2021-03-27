$(function() {
	$("#noticeForm").on("keyup", "textarea", function(e) {
	    $(this).css("height", "auto");
	    $(this).height(this.scrollHeight);
	  });
	
  	$("table").find("textarea").keyup();
  	
  	// 파일 등록시 썸네일 등록
  	document.getElementById('uploadImage').addEventListener('change', function(e) {
  		let elem = e.target;
  		if (validateType(elem.files[0])) {
  			let preview = document.querySelector('.thumb');
  			preview.classList.remove("image-null");
  			preview.src = URL.createObjectURL(elem.files[0]); //파일 객체에서 이미지 데이터 가져옴.
  			preview.classList.add("image-uploaded");
  			document.querySelector('.image-delete-btn').style.display = 'block'; // 이미지 삭제 링크 표시
  			preview.onload = function() {
  				URL.revokeObjectURL(preview.src); //URL 객체 해제
  				document.querySelector('#file-name-box').innerHTML = elem.files[0].name; // 이름 박스에 파일 이름 표시
  				document.querySelector('#isChanged').value = 'true';
  			}
  		} else {
  			console.log('이미지 파일이 아닙니다.');
  		}
  	});

  	// 파일 제거시 썸네일 해제
  	document.querySelector('.image-delete-btn').addEventListener('click', function(e){
  		let delbtn = e.target;
  		let preview = delbtn.previousElementSibling;
  		preview.src = ''; // 썸네일 이미지 src 데이터 해제
  		document.querySelector('.image-delete-btn').style.display = 'none';
  		deleteImageFile();
  	});
  	
});



//이미지 객체 타입으로 이미지 확장자 밸리데이션
var validateType = function(img){
	return (['image/jpeg','image/jpg','image/png'].indexOf(img.type) > -1);
}

var validateName = function(fname) {
	let extensions = [ 'jpeg', 'jpg', 'png' ];
	let fparts = fname.split('.');
	let fext = '';

	if (fparts.length > 1) {
		fext = fparts[fparts.length - 1];
	}

	let validated = false;

	if (fext != '') {
		extensions.forEach(function(ext) {
			if (ext == fext) {
				validated = true;
			}
		});
	}

	return validated;
}

function deleteImageFile() {
	var agent = navigator.userAgent.toLowerCase();
	
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	    $("#uploadImage").replaceWith($("#uploadImage").clone(true));
	}else{
	    $("#uploadImage").val("");
	}
	
	document.querySelector('#file-name-box').innerHTML = '파일 없음'; // file-name-box 초기화
	document.querySelector('#isChanged').value = 'true';
}