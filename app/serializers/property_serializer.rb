class PropertySerializer < ActiveModel::Serializer
  cached

  attributes :id, :name, :address, :description, :lat, :lng, :created_at, :updated_at
  has_one :user
  has_many :beacons, :highlights

  def cache_key
    [object, scope]
  end
end
