class AddressGetter
  attr_private :results, :search

  def initialize(search)
    @search = search
    @results = {}
    return unless addresses.all?{ |x| fuzzy_equal(x, addresses.first) }

    @results = addresses.first || {}
  end

  def address
    @address ||= Address.new(
      results[:locality],
      results[:region],
      results[:country_name]
    )
  end

protected

  def fuzzy_equal(a, b)
    a.to_h
    b.to_h
    a.keys.all?{ |k| a[k] == b[k] || b[k].nil? || a[k].nil? }
  end

  def raw
    @raw ||= Geocoder.search(search)
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
