module Authable
  class SessionSerializer < ::ActiveModel::Serializer
    attributes :token, :is_registered, :authable_type, :authable_id

    def is_registered
      object.authable.registered?
    end
  end
end