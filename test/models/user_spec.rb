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
end
