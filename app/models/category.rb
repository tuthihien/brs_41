class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  belongs_to :parent, class_name: Category.name
  has_many :categories, foreign_key: :parent_id

  validates :name, presence: true, uniqueness: true

  scope :order_by_name, -> {order :name}
end
