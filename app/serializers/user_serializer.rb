class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :memberships, embed: :ids, include: true
end