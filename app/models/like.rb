class Like < ApplicationRecord
  belongs_to :user

  scope :scope_target_id, -> target_id {where target_id: target_id}
end
