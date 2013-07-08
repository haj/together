class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :member_ids

  has_many :memberships, embed: :ids, include: true

  def member_ids
    object.user_ids
  end
end