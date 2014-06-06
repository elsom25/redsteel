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
    return {} unless addresses.all?{ |address| equal?(address, addresses.first) }
    addresses.first || {}
  end

  def equal?(a, b)
    @equalizer.equal?(a, b)
  end

  def geocoder_raw
    @geocoder_raw ||= Geocoder.search(@search)
  end

  def addresses
    geocoder_raw.map do |raw|
      component = raw.data['address_components']
      locality = component.find{ |c| c['types'].include?('locality') }.try(:[], 'long_name')
      {
            locality: component_type(component, 'locality'),
              region: component_type(component, 'administrative_area_level_1'),
        country_name: component_type(component, 'country')
      }
    end
  end

  def component_type(component, type)
    component.find{ |c| c['types'].include?(type) }.try(:[], 'long_name')
  end
end
