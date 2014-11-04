class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :filtering, ->(q) { where('email like ?', "%#{q}%") }
  scope :not_members, ->(user_ids) { where('id NOT in (?)', user_ids).map { |u| { id: u.id, email: u.email } } }

  has_many :content_entities
  has_many :links, through: :content_entities, source: :contentable, source_type: 'Link'
  has_many :notes, through: :content_entities, source: :contentable, source_type: 'Note'
  has_and_belongs_to_many :groups, join_table: :participants

  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def name
    username.presence || email
  end

  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
