module Inbox
  extend ActiveSupport::Concern
  included do |base|
    after_update :leave_inbox!
  end

  def leave_inbox!
    update_column(:inbox, false)
    content_entity.update_column(:inbox, false)
  end
end
