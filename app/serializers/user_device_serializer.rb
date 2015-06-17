class UserDeviceSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :uuid

  has_one :user

  def id
  	object.uuid
  end
end
