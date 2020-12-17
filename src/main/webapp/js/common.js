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
})