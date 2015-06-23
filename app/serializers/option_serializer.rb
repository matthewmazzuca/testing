class OptionSerializer < ActiveModel::Serializer
  # cached

  attributes :id, :name, :image, :created_at, :updated_at
  has_one :highlight

  def cache_key
    [object, scope]
  end
end
