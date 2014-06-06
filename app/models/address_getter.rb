class AddressGetter
  attr_private :results, :search, :equalizer

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

  def raw
    @raw ||= Geocoder.search(@search)
  end

  def addresses
    raw.map do |r|
      component = r.data['address_components']
      {
            locality: component.find{ |c| c['types'].include?('locality') }.try(:[], 'long_name'),
              region: component.find{ |c| c['types'].include?('administrative_area_level_1') }.try(:[], 'long_name'),
        country_name: component.find{ |c| c['types'].include?('country') }.try(:[], 'long_name')
      }
    end
  end
end
