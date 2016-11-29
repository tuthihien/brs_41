class Book < ApplicationRecord
  belongs_to :category
  has_many :review
  has_many :activities, as: :target

  mount_uploader :image, ImageUploader
  has_attached_file :image, styles: {medium: Setting.medium, thumb: Setting.thumb}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :title, presence: true, length: {minimum: 6}
  validates :author, presence: true
  validates :num_of_page, presence: true
  validates :category_id, presence: true
  validates :publish_date, presence: true

  def self.rate? book_id, condition
    active = Activity.where user_id: current_user.id, target_id: book_id,
      action: condition
    active.any?
  end

  scope :recent, -> {order "updated_at DESC"}
end
