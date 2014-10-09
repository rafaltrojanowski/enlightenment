class Comment < ActiveRecord::Base
  attr_accessor :content
  belongs_to :commentable, polymorphic: true
end
