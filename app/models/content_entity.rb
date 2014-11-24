class ContentEntity < ActiveRecord::Base
  attr_accessor :content
  validates :content, presence: true, on: :create
  validates :user, presence: true

  acts_as_taggable

  default_scope { includes(:user, :comments).
                  order(created_at: :desc) }

  belongs_to :contentable, polymorphic: true
  belongs_to :user
  belongs_to :group

  before_create :create_entity
  after_destroy :destroy_contentable

  delegate :to_s, :body, to: :contentable

  has_many :comments, as: :commentable, dependent: :destroy

  private

  def create_entity
    begin
      uri = URI.parse(content)

      if uri && uri.host && %(http https).include?(uri.scheme)
        create_link
      else
        create_note
      end
    rescue => error
      logger.error error
      create_note
    end
  end

  def destroy_contentable
    contentable.destroy
  end

  def create_link
    self.contentable = Link.create(url: content)
  end

  def create_note
    self.contentable = Note.create(body: content)
  end
end
