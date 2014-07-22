require 'test_helper'

describe House do
  subject{ build :house }

  it 'should have a valid factory' do
    subject.must_be :valid?
  end

  describe '#create' do
    it 'should always have an #internal_name' do
      subject.save!
      subject.internal_name.must_be :present?
    end
  end
end
