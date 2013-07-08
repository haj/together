class Group < ActiveRecord::Base
  has_many :memberships, inverse_of: :group, dependent: :destroy
  has_many :users, through: :memberships

  scope :my_groups, lambda {|user|
    joins(:memberships).where(memberships: {user_id: user})
  }

  scope :other_groups, lambda {|user|
    where("id NOT IN (?)", my_groups(user).pluck(:id))
  }
end