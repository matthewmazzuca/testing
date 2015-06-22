# == Schema Information
#
# Table name: beacons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  uuid       :integer          is an Array
#  venue_id   :integer
#

class Beacon < ActiveRecord::Base
  belongs_to :property

  def uuid
    read_attribute(:uuid).join('.')
  end
end