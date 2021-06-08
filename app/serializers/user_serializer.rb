class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :username, :avatar, :created_at, :updated_at
  # model association
end
