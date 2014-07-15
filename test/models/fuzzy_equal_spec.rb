require 'test_helper'

describe FuzzyEqual do
  subject{ FuzzyEqual.equal?(a, b) }

  describe '#equal?' do
    let(:a){ { locality: 'Guelph', region: 'Ontario', country_name: 'Canada' } }

    describe 'equal' do
      describe 'exactly' do
        let(:b){ { locality: 'Guelph', region: 'Ontario', country_name: 'Canada' } }

        it 'should be true' do
          subject.must_equal true
        end
      end

      describe 'one thing is nil on b' do
        let(:b){ { locality: nil, region: 'Ontario', country_name: 'Canada' } }

        it 'should be true' do
          subject.must_equal true
        end
      end

      describe 'two things are nil on b' do
        let(:b){ { locality: nil, region: nil, country_name: 'Canada' } }

        it 'should be true' do
          subject.must_equal true
        end
      end

      describe 'everything is nil on b' do
        let(:b){ { locality: nil, region: nil, country_name: nil } }

        it 'should be true' do
          subject.must_equal true
        end
      end

      describe 'things nil on a but not b' do
        let(:a){ { locality: nil, region: 'Ontario', country_name: 'Canada' } }
        let(:b){ { locality: 'Guelph', region: 'Ontario', country_name: 'Canada' } }

        it 'should be true' do
          subject.must_equal true
        end
      end
    end

    describe 'unequal' do
      describe 'mismatching value' do
        let(:b){ { locality: 'Waterloo', region: 'Ontario', country_name: 'Canada' } }

        it 'should be false when something does not match' do
          subject.must_equal false
        end
      end

      describe 'nil and mismatching value' do
        let(:b){ { locality: 'Waterloo', region: nil, country_name: 'Canada' } }

        it 'should be false when there are nils and non matches' do
          subject.must_equal false
        end
      end
    end
  end
end
