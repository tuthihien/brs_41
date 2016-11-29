class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  scope :following_other_user, user, other_user -> do
    where(follower_id: user.id,
      followed_id: other_user.id).any?
  end
end
