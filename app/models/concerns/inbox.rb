module Inbox
  extend ActiveSupport::Concern
  included do |base|
    after_commit :leave_inbox_if_need!
  end

  delegate :inbox, :inbox?, :body, to: :content_entity

  private

  def leave_inbox_if_need!
    content_entity.update_column(:inbox, "#{!content_entity.group.present?}")
  end
end
