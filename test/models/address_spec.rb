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

  describe '#blank?' do
    it{ nil.must_be :blank? }
    it{ subject.wont_be :blank? }

    describe 'all fields are nil' do
      subject{ Address.new(nil, nil, nil) }
      it{ subject.must_be :blank? }
    end
  end

  describe '#present?' do
    it{ nil.wont_be :present? }
    it{ subject.must_be :present? }

    describe 'all fields are nil' do
      subject{ Address.new(nil, nil, nil) }
      it{ subject.wont_be :present? }
    end
  end
end
