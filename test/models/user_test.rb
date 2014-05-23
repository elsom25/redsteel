require 'test_helper'

describe User do
  let(:user){ FactoryGirl.create(:user) }

  describe 'creating' do
    it 'should require unique email' do
      user.save.must_equal true

      new_user = FactoryGirl.build :user, email: user.email
      new_user.save.must_equal false
    end

    it 'should not allow an invalid email' do
      new_user = FactoryGirl.build :user, email: 'NOT AN EMAIL'
      new_user.wont_be :valid?
    end
  end
end
