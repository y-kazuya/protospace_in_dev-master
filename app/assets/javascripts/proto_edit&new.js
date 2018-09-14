$(function(){
  var max_subs = 3  //最大サブ画像投稿数
    //画像投稿フォームの差し込み
  function buildHtml(i){
    var html = `<li class="list-group-item col-md-4 new_sub edit_subs" style="display:none;">
        <div class="image-upload">
          <img style="width: 100%; height: 100%;" class="sub_image" src="">
          <input type="file" name="prototype[captured_images_attributes][${i}][content]" id="prototype_captured_images_attributes_${i}_content">
          <input value="sub" type="hidden" name="prototype[captured_images_attributes][${i}][status]" id="prototype_captured_images_attributes_${i}_status">
        </div>
      </li>`

    return html;
  }

    //画像追加ボタンの差し込み
  function buildAddSub(){
    var add_sub  = `<li class="list-group-item col-md-4 add_sub" >
        <div>
          追加したいな
        </div>
      </li>`

    return add_sub;
  }
    //条件を見極めて、画像フォームと画像追加ボタンを差し込んでうr
  if (location.pathname.match(/\/prototypes\/\d+\/edit/)){
    var sub_count = $(".edit_subs").length
    var need_new = max_subs - sub_count
    if (sub_count == 0){
      var num = 1
    }
    else{
      var get_num = $(".edit_subs").find("input").attr("name").match(/\d/)
      var num = Number(get_num) + sub_count
    }
    if(need_new != 0){
      var target = $(".proto-sub-list")
      for (i = sub_count; i < need_new + sub_count ; i = i +1){
        var html = buildHtml(num)
        num += 1
        target.append(html);
      }
      var add_sub = buildAddSub()
      target.append(add_sub)
    }
  }

  $(".add_sub").on("click", function(){
    if (location.pathname.match(/\/prototypes\/\d+\/edit/)){//editpageの時
      var target = $(".edit_subs")[sub_count];
      $(target).css("display", "block");
      sub_count += 1;
      if(sub_count == max_subs){
        $(this).css("display", "none");
      }
    }
    else{//newpageの時
      $(this).prev().css("display", "block")
      $(this).css("display", "none")
    }
  })
})
