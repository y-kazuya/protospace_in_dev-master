$(function(){
  var count_target = $("#comment_count")
  var count = count_target.text()

  $(".proto-comment").on('click',".edit_btn",function(){ //非同期編集
    $(this).parents(".proto-comment--comments--comment--right").find("input").css("display", "block");
    $(this).parents(".proto-comment--comments--comment--right").find(".proto-comment--comments--comment--right__text").text("");
    $(this).css("display" , "none");
    $(this).next(".submit_btn").css("display", "inline-block");

    $(".comment").on("submit", function(e){
      e.preventDefault();
      var form = $(this);
      var content = $(this).find("#comment_content").val();
      var url = $(this).attr("action");
      $.ajax({
        url: url,
        type: "PATCH",
        data: {
          comment: {
            content: content
          }
        },
        dataType: 'json'
      })
      .done(function(){
        $(".submit_btn").prop("disabled", false);
        form.find(".submit_btn").css("display", "none");
        form.find(".edit_btn").css("display", "inline-block");
        form.find(".proto-comment--comments--comment--right").find("input").css("display", "none");
        form.find(".proto-comment--comments--comment--right").find(".proto-comment--comments--comment--right__text").text(content);

      })
      .fail(function(){
        alert('error');
      });
    })
  })
  //非同期コメント削除

  $(".proto-comment").on('click',".delete_btn",function(){
    var comment = $(this).parents(".comment");
    var url = comment.attr("action");
    $.ajax({
      url: url,
      type: "DELETE",
      dataType: 'json'
    })
    .done(function(){
      comment.remove();
      count -= 1;
      count_target.text(count);

    })
    .fail(function(){
      alert('error');
    });
  })


  //非同期コメント追加

  function buildHtml(data){
    var html = `<form class="comment" id="edit_comment_${data.id}" action="/prototypes/44/comments/${data.id}" accept-charset="UTF-8" method="post">
        <input name="utf8" type="hidden" value="✓">
        <input type="hidden" name="_method" value="patch">
        <input type="hidden" name="authenticity_token" value="m9hwCNcqUTCP7vpb391VnKTq9mZKQ21wi8FFtjWhb/an+g2TXV+6G5+Q6qzxAq8eKsOKNszAtA9WNS5wXmfh/w==">
        <div class="proto-comment--comments--comment">
          <div class="proto-comment--comments--comment__avater">
            <img alt="profile" class="user-avater" style="width: 64px; height: 64px;" src="${data.user_avatar}">
          </div>
          <div class="proto-comment--comments--comment--right">
            <div class="proto-comment--comments--comment--right__user-name">
              ${data.user_name}
              <div class="btn btn-default delete_btn">
                Delete
              </div>
              <div class="btn btn-default edit_btn">
                edit
              </div>
              <input type="submit" name="commit" value="Update" class="btn btn-default submit_btn">
            </div>
            <div class="proto-comment--comments--comment--right__text">
              ${data.comment}
            </div>
            <input value="rer" type="text" name="comment[content]" id="comment_content">
          </div>
        </div>
      </form>`
      return html;

  }
  $("#new_comment").on("submit", function(e){
    e.preventDefault();
    if ($(this).find("textarea").val() == "") {
      alert ("コメントを入力してください");
      return
    }
    var form = $(this)
    var formData = new FormData($(this)[0])
    var url = form.attr("action")
    $.ajax({
      url: url,
      type: "Post",
      data: formData,
      dataType: 'json',
      processData: false,
			contentType: false
    })
    .done(function(data){
      count = parseInt(count) + 1;
      count_target.text(count);
      var target = $(".proto-comment--comments");
      var html = buildHtml(data);
      target.prepend(html);
      form[0].reset();
      $(".proto-description")[0].scrollIntoView(true);

    })
    .fail(function(){
      alert('error');
    });

  })
})

//アニメート