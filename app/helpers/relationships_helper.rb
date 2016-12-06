module RelationshipsHelper
  def follow_unfollow_toggle other_user
    unless following? other_user
      link_to t("btnfollow").html_safe,
        relationships_path(followed_id: other_user),
        id: "follow", remote: true, method: :get
    else
      link_to t("btnunfollow").html_safe,
        relationship_path(followed_id: other_user), remote: true, method: :delete
    end
  end
end
