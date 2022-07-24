module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    p size
    img = "https://www.gravatar.com/avatar/#{hash}"
    image_tag(img, alt:user.username, size: size, class: "rounded-circle mx-auto d-block")
  end




end
