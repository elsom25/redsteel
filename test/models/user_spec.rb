require 'test_helper'

describe User do
  let(:user){ create :user }

  describe '#create' do
    it 'should require unique email' do
      new_user = build :user, email: user.email
      new_user.wont_be :valid?
    end

    it 'should not allow an invalid email' do
      new_user = build :user, email: 'NOT AN EMAIL'
      new_user.wont_be :valid?
    end
  end

  describe '#name' do
    it 'should be nil with no name' do
      user.name.must_be_nil
    end

    it 'should be the given_name given only a given_name' do
      user.given_name = 'given_name'
      user.name.must_equal 'given_name'
    end

    it 'should be the family_name given only a family_name' do
      user.family_name = 'family_name'
      user.name.must_equal 'family_name'
    end

    it 'should be the given_name given both names' do
      user.given_name = 'given_name'
      user.family_name = 'family_name'
      user.name.must_equal 'given_name'
    end
  end

  describe '#full_name' do
    it 'should be nil with no name' do
      user.full_name.must_be_nil
    end

    it 'should be the given_name given only a given_name' do
      user.given_name = 'given_name'
      user.full_name.must_equal 'given_name'
    end

    it 'should be the family_name given only a family_name' do
      user.family_name = 'family_name'
      user.full_name.must_equal 'family_name'
    end

    it 'should combine names nicely' do
      user.given_name = 'given_name'
      user.family_name = 'family_name'
      user.full_name.must_equal 'given_name family_name'
    end
  end
end
