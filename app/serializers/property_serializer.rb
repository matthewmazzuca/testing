class PropertySerializer < ActiveModel::Serializer
  cached

  attributes :id, :name, :address, :description, :lat, :lng, :created_at, :updated_at
  has_one :user

  def cache_key
    [object, scope]
  end
end
