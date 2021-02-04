$(document).ready(function(){
	$("#header .h_search_btn").click(function(){
        $("#header .h_search").toggleClass("on")
    })

    $("#gnb > ul > li.depth2 > a").click(function(){
        if($(window).width() < 1024){
            $("#gnb > ul > li.depth2 > ul").stop().slideUp()
            $(this).parent("li").children("ul").stop().slideToggle()

            return false;
        }
    })

    $("#menuToggle").click(function(){
        $("#header").toggleClass("on")
    })

    $(window).resize(function(){
        if($(window).width() > 1024){
            $("#gnb > ul > li.depth2 > ul").hide()
        }
    })
    
    $(".history_back_btn").click(function(){
    	window.history.back();
    })
    
    // 상품 detail
    var price = $(".product_detail .detail_info .txt_box .totalPrice p:last span").text().replace(",","");
    $(".product_detail .detail_info .txt_box .length div p.up").click(function(){
        var num = $(".product_detail .detail_info .txt_box .length div input").val();

        if (num == 9999){
            alert("최대 구매수량은 9999 입니다.")
            return false;
        }

        $(".product_detail .detail_info .txt_box .length div input").val(++num);
        var totalPrice = price * num;
        $(".product_detail .detail_info .txt_box .totalPrice p:last span").text(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    })

    $(".product_detail .detail_info .txt_box .length div p.down").click(function(){
        var num = $(".product_detail .detail_info .txt_box .length div input").val();

        if (num == 1){
            alert("최소 구매수량은 1 입니다.")
            return false;
        }

        $(".product_detail .detail_info .txt_box .length div input").val(--num);
        var totalPrice = price * num;
        $(".product_detail .detail_info .txt_box .totalPrice p:last span").text(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    })

    $(".product_detail .detail_info .txt_box .length div input").keyup(function(event){
        $(this).val( $(this).val().replace(/[^0-9]/gi,"") );
        if ($(this).val() < 1 || $(this).val() > 9999){
            alert("수량은 1에서 9999 사이의 값으로 입력해 주세요.")
            $(this).val("1")
            $(".product_detail .detail_info .txt_box .totalPrice p:last span").text(price)
            return false;
        }

        var num = $(this).val();
        var totalPrice = price * num;
        $(".product_detail .detail_info .txt_box .totalPrice p:last span").text(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    })
    
    $(".star_box .star").click(function(){
		$(".star_box .star").removeClass("on")
		for (var i = 0; i <= $(this).index(); i++){
			$(".star_box .star:eq("+ i +")").addClass("on")
		}
	})
})

//현재 시간이랑 글 쓴 시간 비교
// writeNow: Date. 글 쓴 시각
// lastTime: String. 비교 시간 표시할 클래스 이름.
function timeBefore(writeNow) {
	
	//현재 시간가져오기
	var now = new Date();
	var minus;
	var timeBeforeStr;
	
	if(now.getFullYear() > writeNow.getFullYear()){
		minus = now.getFullYear() - writeNow.getFullYear();
		timeBeforeStr = minus+"년 전";
	}else if(now.getMonth() > writeNow.getMonth()){
        //년도가 같을 경우 달을 비교해서 출력
        minus= now.getMonth()-writeNow.getMonth();
        timeBeforeStr = minus+"달 전";
    }else if(now.getDate() > writeNow.getDate()){
   	//같은 달일 경우 일을 계산
        minus= now.getDate()-writeNow.getDate();
        timeBeforeStr = minus+"일 전";
    }else if(now.getDate() == writeNow.getDate()){
    //당일인 경우에는 
        var nowTime = now.getTime();
        var writeTime = writeNow.getTime();
        if(nowTime>writeTime){
        //시간을 비교
            sec = parseInt(nowTime - writeTime) / 1000;
            day  = parseInt(sec/60/60/24);
            sec = (sec - (day * 60 * 60 * 24));
            hour = parseInt(sec/60/60);
            sec = (sec - (hour*60*60));
            min = parseInt(sec/60);
            sec = parseInt(sec-(min*60));
            if(hour>0){
            //몇시간전인지
            	timeBeforeStr = hour+"시간 전";
            }else if(min>0){
            //몇분전인지
            	timeBeforeStr = min+"분 전";
            }else if(sec>0){
            //몇초전인지 계산
            	timeBeforeStr = sec+"초 전";
            }
        }
    }
	
	console.log("timeBeforeStr: " + timeBeforeStr);
	return timeBeforeStr;
}