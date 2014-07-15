require 'test_helper'

describe FacebookDataScraper do
  subject{ FacebookDataScraper.new(user, data) }
  let(:user){ build :user }
  let(:data) do
    {
      'extra' => {
        'raw_info' => {
          'location' => {
            'id' => '106514426051396',
            'name' => 'Waterloo, Ontario'
          },
          'birthday' => '09/18/1990',
          'gender' => 'male'
        }
      }
    }
  end
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

    it 'should change gender male to gender masculine' do
      subject.update_user
      user.gender.must_equal 'Masculine'
    end

    it 'should not update gender if gender is already set' do
      user.gender = 'confused'
      subject.update_user
      user.gender.must_equal 'confused'
    end

    describe 'address is nil' do
      let(:address){ Address.new(nil, nil, nil) }

      it 'should not set a location' do
        subject.update_user

        user.locality.must_be_nil
        user.region.must_be_nil
        user.country_name.must_be_nil
      end
    end
  end
end
