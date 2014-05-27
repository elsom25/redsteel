require 'test_helper'

describe User do
  subject{ build :user }

  it 'should have a valid factory' do
    subject.must_be :valid?
  end

  describe '#create' do
    it 'should require unique email' do
      subject.save!
      user = build :user, email: subject.email
      user.wont_be :valid?
    end

    it 'should not allow an invalid email' do
      user = build :user, email: 'NOT AN EMAIL'
      user.wont_be :valid?
    end
  end

  describe '#name' do
    it 'should be nil with no name' do
      subject.name.must_be_nil
    end

    it 'should be present given names exist' do
      user1 = build :user
      user2 = build :user
      user3 = build :user

      user1.given_name = 'name'
      user1.name.must_match(/\w+/)

      user2.family_name = 'name'
      user2.name.must_match(/\w+/)

      user3.given_name = 'given_name'
      user3.family_name = 'family_name'
      user3.name.must_match(/\w+/)
    end
  end

  describe '#full_name' do
    it 'should be nil with no name' do
      subject.full_name.must_be_nil
    end

    it 'should be the given_name given only a given_name' do
      subject.given_name = 'given_name'
      subject.full_name.must_equal 'given_name'
    end

    it 'should be the family_name given only a family_name' do
      subject.family_name = 'family_name'
      subject.full_name.must_equal 'family_name'
    end

    it 'should include both given_name and family_name' do
      subject.given_name = 'given_name'
      subject.family_name = 'family_name'
      subject.full_name.must_equal 'given_name family_name'
    end
  end

  describe '#full_address' do
    it 'should be nil with no address fields' do
      subject.full_address.must_be_nil
    end

    it 'should be present given address fields exist' do
      subject.street_address = 'street_address'
      subject.full_address.must_be :include?, 'street_address'

      subject.locality = 'locality'
      subject.full_address.must_be :include?, 'locality'

      subject.postal_code = 'postal_code'
      subject.full_address.must_be :include?, 'postal_code'

      subject.country_name = 'country_name'
      subject.full_address.must_be :include?, 'country_name'

      # ensure fields havent been removed
      subject.full_address.must_be :include?, 'street_address'
      subject.full_address.must_be :include?, 'locality'
      subject.full_address.must_be :include?, 'postal_code'
    end
  end
end
