class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :content, :user, presence: true

  scope :ordered, -> { order('created_at DESC') }
end
