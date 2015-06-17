module ActiveRecord
  module Validations
    # AssociatedBubblingValidator is a Validator class that iterates over each relation and
    # bubbles any validation errors up to the parent Model.
    #
    class AssociatedBubblingValidator < ActiveModel::EachValidator
      # Loop that iterates over each relation passed to an ABV.
      #
      # @param record <ActiveRecord::Base>
      # @param attribute Symbol
      # @param value <ActiveRecord::Base>, Array[<ActiveRecord::Base>]
      #
      def validate_each(record, attribute, value)
        return if value.blank?

        (value.is_a?(Array) ? value : [value]).each do |v|
          unless v && v.valid?
            v.errors.full_messages.each do |msg|
              record.errors.add(attribute, msg, options.merge(:value => value))
            end
          end
        end
      end
    end

    module ClassMethods
      # Class method to declare validator.
      # @param *attr_names Array[<Symbol>]
      #
      def validates_associated_bubbling(*attr_names)
        validates_with AssociatedBubblingValidator, _merge_attributes(attr_names)
      end
    end
  end
end