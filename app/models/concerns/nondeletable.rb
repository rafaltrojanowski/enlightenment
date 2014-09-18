module Nondeletable
  extend ActiveSupport::Concern
  included do |base|
    before_update :protect_identifier
  end

  def destroy
    super if is_deletable?
  end

  def protect_identifier
    return unless attributes.key? 'identifier'

    unless is_deletable?
      self.identifier = identifier_was if identifier_changed?
    end
  end
end
