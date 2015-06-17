class Geocoder
  # Geokit-specific
  GEOCODER = Geokit::Geocoders::GoogleGeocoder
  Geokit::default_units = :kms

  attr_accessor :address, :lat, :lng

  def initialize(opts={})
    @result = nil
    opts.each do |k,v|
      send("#{k}=", v) if self.respond_to?("#{k}=")
    end

    self
  end

  def geocode
    return if !address
    @result = GEOCODER.geocode(address)
    finalize
  end

  def reverse_geocode
    return if !lat || !lng
    @result = GEOCODER.reverse_geocode("#{lat},#{lng}")
    finalize
  end

  private

  def finalize
    return if !@result
    self.address = @result.full_address
    self.lat = @result.lat
    self.lng = @result.lng
    self
  end
end