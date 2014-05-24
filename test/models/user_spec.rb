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
    it 'should never be nil' do
      user.name.wont_be_nil
      user.name.must_equal ''
    end

    it 'should be the first_name given only a first_name' do
      user.first_name = 'first_name'
      user.name.must_equal 'first_name'
    end

    it 'should be the last_name given only a last_name' do
      user.last_name = 'last_name'
      user.name.must_equal 'last_name'
    end

    it 'should be the first_name given both names' do
      user.first_name = 'first_name'
      user.last_name = 'last_name'
      user.name.must_equal 'first_name'
    end
  end

  describe '#full_name' do
    it 'should never be nil' do
      user.full_name.wont_be_nil
      user.full_name.must_equal ''
    end

    it 'should be the first_name given only a first_name' do
      user.first_name = 'first_name'
      user.full_name.must_equal 'first_name'
    end

    it 'should be the last_name given only a last_name' do
      user.last_name = 'last_name'
      user.full_name.must_equal 'last_name'
    end

    it 'should combine names nicely' do
      user.first_name = 'first_name'
      user.last_name = 'last_name'
      user.full_name.must_equal 'first_name last_name'
    end
  end
end
