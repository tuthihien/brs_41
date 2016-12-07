module LikesHelper
  def like? target_id, user_id
    Like.like_activities_with_id(target_id, user_id).any?
  end

  def toggle_like_button activity, user
    if Like.like_activities(activity, current_user).any?
      link_to t("disLike"), like_path id: activity.id, user_id: user.id,
        method: "delete", remote: true,
        class: "fa fa-thumbs-o-down", id: "dis#{activity.id}"
    else
      link_to t("like"), likes_path id: activity.id, user_id: user.id,
        remote: true, class: "fa fa-thumbs-o-up", id: "like#{activity.id}"
    end
  end
end
