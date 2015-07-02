class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :message
end
