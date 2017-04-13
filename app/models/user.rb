class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  has_many :crawls

  after_create :assign_role
  # Validators for dob during account creation

  validates :password, length: { in: 6..20 }, on: :update, if: Proc.new { |u| u.password.present? }
  validates :dob, presence: true, if: Proc.new { |u| u.provide != "twitter" }
  validate :age_not_less_than_21, if: Proc.new { |u| u.provide != "twitter" }


  def age_not_less_than_21
    if self.dob && self.dob + 21.year >= Date.today
      errors.add(:dob, ": Ages under 21 not permitted")

    end
  end

  def assign_role
    add_role(:user)
  end

  def assign_admin
    add_role(:admin)
  end

  def self.from_omniauth(auth)
    where(provide: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid + "@twitter.com"
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name assuming the user model has a name
      # user.image = auth.info.image assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
   super.tap do |user|
     if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
     end
   end
 end

end
