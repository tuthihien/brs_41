class Request < ApplicationRecord
  belongs_to :user
  before_save {self.status = false}

  scope :by_order ->where(user_id: current_user.id).order("status asc")

  scope :request_category, ->category_name do
    where("name LIKE ?", "%#{category_name}%").first
