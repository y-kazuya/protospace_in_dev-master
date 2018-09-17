json.id     @comment.id
json.comment @comment.content
json.user_id @comment.user.id
json.user_name @comment.user.name
json.user_avatar set_avater(@comment)
