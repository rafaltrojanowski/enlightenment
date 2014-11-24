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

  def update_with_contentable(params)
    attrs = params[:contentEntity]

    update_contentable(contentable, attrs)
    update_column(:group_id, attrs[:group_id])
  end

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

  def update_contentable(record, attrs)
    assign_params = begin
                      if record.is_a?(Link)
                        { description: attrs[:description] }
                      else
                        { body: attrs[:body] }
                      end
                    end
    assign_params = assign_params.merge(title: attrs[:title])
    record.update_attributes(assign_params)
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
