$(function(){
   // main_image_preview/////////////////
   $(".main_image_uploader").find("input").on("change", function(e) {
     console.log()
     var file = e.target.files[0];
     var reader = new FileReader();
     if(file.type.indexOf("image") != 0){
       alert("画像ファイルを選択してください");
       return false;
     }

     reader.onload = (function(){
       return function(e){
         $(".main_image").attr("src", e.target.result);
       };
     })(file);
     reader.readAsDataURL(file);
   })

   // sub_image_preview///////////////////////
   $(".sub_image_uploder").on("click", $(this), function() {
     $(".sub_image_uploder").find("input").on("change", function(e) {
       var file = e.target.files[0]
       var reader = new FileReader();
       var target = $(this).siblings(".sub_image");

       if(file.type.indexOf("image") != 0){
         alert("画像ファイルを選択してください");
         return false;
       }

       reader.onload = (function(){
         return function(e){
           target.attr("src", e.target.result);
         };
       })(file);
       reader.readAsDataURL(file);
     })
   })
})
