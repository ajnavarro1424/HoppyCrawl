class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :crawls
  # Validators for dob during account creation
  validates :dob, presence: true
  validate :age_not_less_than_21

  def age_not_less_than_21
    if self.dob && self.dob + 21.year >= Date.today
      errors.add(:dob, ": Ages under 21 not permitted")

    end

  end

end
