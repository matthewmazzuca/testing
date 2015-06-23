class UserSerializer < ActiveModel::Serializer
  # cached

  # embed :ids
  attributes :id, :email, :created_at, :updated_at, :authentication_token

  # has_many :user_devices

  def cache_key
    [object, scope]
  end
end
