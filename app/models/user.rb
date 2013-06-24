class User < ActiveRecord::Base
  has_many :memberships, inverse_of: :user, dependent: :destroy
  has_many :groups, through: :memberships
end