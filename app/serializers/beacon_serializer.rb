class BeaconSerializer < ActiveModel::Serializer
  cached

  attributes :id, :name, :property_id, :uuid, :created_at, :updated_at
  has_one :property

  def cache_key
    [object, scope]
  end
end
