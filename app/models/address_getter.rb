class AddressGetter
  def initialize(search, equalizer=FuzzyEqual)
    @search = search
    @equalizer = equalizer
  end

  def address
    @address ||= Address.new(
      results[:locality],
      results[:region],
      results[:country_name]
    )
  end

protected

  def results
    @results ||= get_results
  end

  def get_results
    root_address = addresses.first
    return {} unless addresses.all?{ |address| equal?(address, root_address) }
    root_address || {}
  end

  def equal?(left, right)
    @equalizer.equal?(left, right)
  end

  def geocoder_raw
    @geocoder_raw ||= Geocoder.search(@search)
  end

  def addresses
    geocoder_raw.map do |raw|
      @component = raw.data['address_components']
      {
            locality: component_type('locality'),
              region: component_type('administrative_area_level_1'),
        country_name: component_type('country')
      }
    end
  end

  def component_type(type)
    @component.find{ |component| component['types'].include?(type) }.try(:[], 'long_name')
  end
end
