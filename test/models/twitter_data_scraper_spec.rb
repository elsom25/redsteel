require 'test_helper'

describe TwitterDataScraper do
  subject{ FacebookDataScraper.new(user, data) }
  let(:user){ build :user }
  let(:data){
    {
      'extra' => {
        'raw_info' => {
          'name' => 'Jesse McGinnis',
          'screen_name' => 'elsom25',
          'location' => 'Waterloo, Ontario',
          'description' => "Boltmade | Imprint Director | uWaterloo Student | You have enemies? Good. That means you've stood up for something, sometime in your life.",
          'url' => nil
        },
      }
    }
  }
  let(:address){ Address.new('Waterloo', 'Ontario', 'Canada') }

  before{ subject.stubs(:address).returns(address) }

  it 'should initialize without error' do
    subject
  end

  describe '#update_user' do
    it 'should fill in the location fields' do
      [:locality, :region, :country_name].each do |field|
        user.send(field).must_be :blank?
      end

      subject.update_user

      user.locality.must_equal 'Waterloo'
      user.region.must_equal 'Ontario'
      user.country_name.must_equal 'Canada'
    end

    it 'should not fill in fields if they exist' do
      [:locality, :region, :country_name].each do |field|
        user.send("#{field}=", 'blah')
      end

      subject.update_user

      [:locality, :region, :country_name].each do |field|
        user.send(field).must_equal 'blah'
      end
    end

    describe 'address is nil' do
      let(:address) { Address.new(nil, nil, nil) }

      it 'should not set a location' do
        subject.update_user

        user.locality.must_be_nil
        user.region.must_be_nil
        user.country_name.must_be_nil
      end
    end
  end
end
