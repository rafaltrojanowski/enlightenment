class Group < ActiveRecord::Base
  attr_reader :user_tokens

  belongs_to :owner, class_name: 'User'
  has_many :content_entities
  has_and_belongs_to_many :users, join_table: :participants

  validates :name, presence: true
  validates :owner, presence: true
  validates :icon, presence: true
  validates :name, uniqueness: true

  after_destroy do
    content_entities.update_all(inbox: true, group_id: nil)
  end

  def other_users(query)
    User.filtering(query).not_members(user_ids)
  end

  def self.visible_for(user)
    user.groups
  end
end
