class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, inverse_of: :user, dependent: :destroy
  has_many :groups, through: :memberships
end