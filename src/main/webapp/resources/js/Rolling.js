function changeover(metag, name){
    metag.src = "resources/img/" + name + "_Over.png";
}
function changeout(metag, name){
    metag.src = "resources/img/" + name + "_Out.png";
}

function changeup(metag, name){
    metag.src = "resources/img/" + name + "_Over.jpg";
}
function changedown(metag, name){
    metag.src = "resources/img/" + name + "_Out.jpg";
}


$(document).ready(function(){
    var $contents = $(".RollingDiv").find("ul");
    var itemWidth = $contents.children().outerWidth();
    var itemLength = $contents.children().length;
    var rollingId;
    auto();
    // 배너 오버
    $contents.mouseover(function(){
        clearInterval(rollingId);
    })
    // 배너 아웃
    $contents.mouseout(function(){
        auto();
    })
    // 이전
    $("#prev").on("click", prev);
    $("#prev").mouseover(function(e){
        clearInterval(rollingId);
    });
    $("#prev").mouseout(auto);
    // 다음
    $("#next").on("click",next);
    $("#next").mouseover(function(e){
        clearInterval(rollingId);
    });
    $("#next").mouseout(auto);

    function auto(){
        rollingId = setInterval(function(){
            start();
        }, 3000);
    }

    function start(){
        //$contents.css("width", itemWidth * itemLength);
        $contents.animate({"left": - itemWidth + "px"}, function(){
            $(this).append("<li>" + $(this).find("li:first").html() + "</li>");
            $(this).find("li:first").remove();
            $(this).css("left", 0);
        });
    }

    function prev(e){
        $("#prev").attr('disabled', true);
        $contents.css("left", - itemWidth);
        $contents.prepend("<li>" + $contents.find("li:last").html() + "</li>");
        $contents.animate({"left":"0px"}, function(){
            clearInterval(rollingId);
            $(this).find("li:last").remove();
            $("#prev").attr("disabled",false);
        });
    }

    function next(e){
        $contents.animate({"left": - itemWidth + "px"}, function(){
            clearInterval(rollingId);
            $(this).append("<li>" + $(this).find("li:first").html() + "</li>");
            $(this).find("li:first").remove();
            $(this).css("left", 0);
        })
    }
});