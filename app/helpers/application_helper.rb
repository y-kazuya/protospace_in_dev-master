module ApplicationHelper

  def set_avater(ins = "none")
    if ins != "none"
      if ins.user[:avatar].nil?
        return "/assets/ava.png"
      else
        return ins.user.avatar.thumb.url
      end
    else
      if @user[:avatar].nil?
        return "/assets/ava.png"
      else
        return @user.avatar.thumb.url
      end
    end
  end

end
