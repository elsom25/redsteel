require 'test_helper'

describe House do
  subject{ build :house }

  it 'should have a valid factory' do
    subject.must_be :valid?
  end
end
