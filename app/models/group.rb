class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :participants
  before_destroy { users.clear }
  belongs_to :owner, class_name: 'User'
  validates :name, presence: true
  has_many :content_entities
  attr_reader :user_tokens
end
