class Group < ActiveRecord::Base
  has_many :memberships, inverse_of: :group, dependent: :destroy
end