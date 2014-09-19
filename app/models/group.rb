class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :participants
  has_many :participants
  belongs_to :owner, class_name: 'User'
  attr_accessor :participant
end
