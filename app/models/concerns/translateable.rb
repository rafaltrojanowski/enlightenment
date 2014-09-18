module Translateable
  extend ActiveSupport::Concern
  included do |base|
    ## ASSOCIATIONS
    has_many :translations, class_name: "#{base.name}Translation",
                            foreign_key: base.name.foreign_key,
                            dependent: :destroy

    ## ANAF
    accepts_nested_attributes_for :translations

    ## BEFORE & AFTER
    after_create :rebuild_translations
  end

  def rebuild_translations
    to_save = []
    LanguageVersion.all.each do |lv|
      translations.where(language_version_id: lv.id).first_or_initialize do |t|
        if self.class.constants(false).member?(:TRANSLATEABLE)
          self.class::TRANSLATEABLE.each do |k, v|
            t.send("#{v}=", send(k))
          end
        end
        t.language_version = lv
        to_save << t
      end
    end
    to_save.each { |t| persisted? ? t.save : translations << t }
  end

  def get_translated(attr, language_version = nil)
    language_version ||= LanguageVersion.default.first
    if @language_version != language_version
      @language_version = language_version
      @translation = nil
    end
    @translation ||= translations.where(language_version_id: language_version.id).first
    @translation.send(attr.to_sym) if @translation.present?
  end
end
