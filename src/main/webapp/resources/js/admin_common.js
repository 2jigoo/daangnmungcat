$(function(){
    $(".history_back_btn").click(function(){
    	window.history.back();
    })
    
    $(".admin_product_img p.view").click(function(){
    	$(this).toggleClass("on")
    })
    
    $(".admin_product_img p.delete").click(function(){
    	$(this).closest("div").hide()
    	$(this).closest("div").prev().val("")
    	
    	$("#isChanged").val("true")
    })
    
    $(".admin_pdt_image").change(function(){
    	ext = $(this).val().split('.').pop().toLowerCase();
    	
    	if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $(this).prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $(this).next().children("img").attr('src', blobURL);
            $(this).next().show()
        }
    	
    	$("#isChanged").val("true")
    })
})