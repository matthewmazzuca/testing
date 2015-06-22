class HighlightSerializer < ActiveModel::Serializer
  cached

  attributes :id, :name, :sub_heading, :image, :created_at, :updated_at
  has_one :property
  has_many :options

  def cache_key
    [object, scope]
  end
end
