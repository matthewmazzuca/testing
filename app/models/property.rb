require './lib/geocoder'

# == Schema Information
#
# Table name: properties
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  address     :string(255)
#  description :text
#  lat         :decimal(9, 6)
#  lng         :decimal(9, 6)
#  created_at  :datetime
#  updated_at  :datetime
#

class Property < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  has_many :beacons
  has_many :highlights
  has_many :fields

  # scope :close_to, -> (lat, lng, distance_in_meters = 2000) {
  #   where(%{
  #     ST_DWithin(
  #       ST_GeographyFromText(
  #         'SRID=4326;POINT(' || proprties.lng || ' ' || properties.lat || ')'
  #       ),
  #       ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
  #       %d
  #     )
  #   } % [lng, lat, distance_in_meters])
  # }

  # def address=(addr)
  #   write_attribute(:address, addr)
  #   return if !addr
    
  #   g = Geocoder.new(address: addr).geocode
  #   self.lat = g.lat
  #   self.lng = g.lng
  # end
end