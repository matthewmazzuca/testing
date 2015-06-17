# == Schema Information
#
# Table name: user_devices
#
#  id         :integer          not null, primary key
#  uuid       :string(255)
#  token      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  endpoint   :string(255)
#

class UserDevice < ActiveRecord::Base
  after_create :set_endpoint

  belongs_to :user

  has_many :sessions, as: :authable, class_name: Authable::Session

  validates_uniqueness_of :uuid
  
  private
    #TBD - can be found in SNS console, may not be needed
    #(per device targeting)
    def set_endpoint
      return if !self.token || self.token.length == 0

      client = AWS::SNS.new.client
      begin
        response = client.create_platform_endpoint(
          platform_application_arn: "arn:aws:sns:us-east-1:826990736834:app/APNS_SANDBOX/AddoDev",
          token: self.token
        )

        endpoint = response[:endpoint_arn]
        self.update_attributes(endpoint: endpoint)
      rescue => e
        Rails.logger.warn("Failed to get amazon endpoint: #{e}")
      end
    end
end