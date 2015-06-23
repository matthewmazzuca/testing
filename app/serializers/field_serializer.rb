class FieldSerializer < ActiveModel::Serializer
  attributes :id, :name, :value
  has_one :property

  def cache_key
    [object, scope]
  end
end
