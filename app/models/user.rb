class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  validate :must_have_a_role, on: :update
  
  has_many :posts, through: :roles, source: :resource, source_type:  :Post
  
  private
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "Must have at least 1 role ")
    end
  end

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end   

end