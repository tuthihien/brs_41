module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for human, size = Settings.gravatar_size
    gravatar_id = Digest::MD5::hexdigest(human.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: human.fullname, class: "gravatar")
  end
end
