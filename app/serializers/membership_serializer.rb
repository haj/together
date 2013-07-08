class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :group_id, :user_id
end