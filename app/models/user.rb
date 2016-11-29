class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, through: :active_relationships, source: :followed
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  before_save {self.email = email.downcase}

  validates :password, presence: true, length: {minimum: 6, allow_blank: true}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 100},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  VALID_FULLNAME_REGEX = /[\w]+([\s]+[\w]+){1}+/
  validates :fullname, presence: true, length: {maximum:150},
    format: {with: VALID_FULLNAME_REGEX}
  has_secure_password

  scope :newest, ->{order :created_at}

  def self.following? other_user
    if login?
      Relationship.following_other_user current_user, other_user
    end
    false
  end
end
