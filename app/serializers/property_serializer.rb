class PropertySerializer < ActiveModel::Serializer
  # cached

  attributes :id, :name, :address, :description, :lat, :lng, :created_at, :updated_at
  has_one :user
  has_many :beacons
  has_many :highlights
  has_many :fields

  def cache_key
    [object, scope]
  end
end
