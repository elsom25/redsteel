require 'test_helper'

describe AddressGetter do
  subject{ AddressGetter.new('Guelph') }
  let(:raw){ YAML.load(File.read('test/support/geocoder/guelph.yml')) }

  before{ Geocoder.stubs(:search).returns(raw) }

  it 'should initialize without error' do
    subject
  end

  describe 'with ambiguous results' do
    let(:raw) { YAML.load(File.read('test/support/geocoder/waterloo.yml')) }

    it 'should not set results' do
      subject.send(:results).wont_be :present?
    end

    [:locality, :region, :country_name].each do |value|
      it "should return a #{value} of nil" do
        subject.address.send(value).must_be_nil
      end
    end
  end

  describe 'with many unambiguous results' do
    let(:raw) { YAML.load(File.read('test/support/geocoder/guelph-latlng.yml')) }

    it 'should populate results' do
      subject.send(:results).must_be :present?
    end

    it 'should have a locality of Guelph' do
      subject.address.locality.must_equal 'Guelph'
    end

    it 'should have a region of Ontario' do
      subject.address.region.must_equal 'Ontario'
    end

    it 'should have a country name of Canada' do
      subject.address.country_name.must_equal 'Canada'
    end
  end

  describe 'with no results' do
    let(:raw) { [] }

    it 'should not set results' do
      subject.send(:results).wont_be :present?
    end

    [:locality, :region, :country_name].each do |value|
      it "should return a #{value} of nil" do
        subject.address.send(value).must_be_nil
      end
    end
  end

  describe 'with one result' do
    let(:raw) {
      [
        OpenStruct.new(
          data: {
            'address_components' => [
              {
                'long_name' => 'Guelph',
                'types' => ['locality']
              },
              {
                'long_name' => 'Ontario',
                'types' => ['administrative_area_level_1']
              },
              {
                'long_name' => 'Canada',
                'types' => ['country']
              }
            ]
          }
        )
      ]
    }

    it 'should populate results' do
      subject.send(:results).must_be :present?
    end

    it 'should have a locality of Guelph' do
      subject.address.locality.must_equal 'Guelph'
    end

    it 'should have a region of Ontario' do
      subject.address.region.must_equal 'Ontario'
    end

    it 'should have a country name of Canada' do
      subject.address.country_name.must_equal 'Canada'
    end
  end
end
