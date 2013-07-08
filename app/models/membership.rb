class Membership < ActiveRecord::Base
  belongs_to :user, inverse_of: :memberships
  belongs_to :group, inverse_of: :memberships

  validates :user, :group, presence: true
  validates_uniqueness_of :user_id, :scope => [ :group_id ]
end