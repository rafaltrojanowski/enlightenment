class Administrator < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  ## VALIDATIONS
  validates :first_name, :last_name, :email,
            presence: true

  def to_s
    "#{full_name} (#{email})"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
