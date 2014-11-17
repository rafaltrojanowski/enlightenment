module Inbox
  extend ActiveSupport::Concern
  included do |base|
    after_commit :leave_inbox_if_need!
  end

  def leave_inbox_if_need!
    content_entity.update_column(:inbox, "#{!content_entity.group.present?}")
  end

  def inbox
    content_entity.inbox
  end

  def inbox?
    content_entity.inbox?
  end
end
