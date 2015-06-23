class Highlight < ActiveRecord::Base
  belongs_to :property
  has_many :options
end
