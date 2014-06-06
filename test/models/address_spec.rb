require 'test_helper'

describe Address do
  subject{ Address.new(locality, region, country_name) }
  let(:locality){ 'Waterloo' }
  let(:region){ 'Ontario' }
  let(:country_name){ 'Canada' }

  it 'should have the locality it was initialized with' do
    subject.locality.must_equal locality
  end

  it 'should have the region it was initialized with' do
    subject.region.must_equal region
  end

  it 'should have the country it was initialized with' do
    subject.country_name.must_equal country_name
  end
end
