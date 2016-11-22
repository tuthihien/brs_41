class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user, dependent: :destroy
  has_many :comments, as: :target
end
