require 'spec_helper'

describe Gyftwrapper::API do
  subject { Gyftwrapper::API.new }

  class Rails
    def self.root
      Pathname.new(".").realpath
    end

    def self.env
      'test'
    end
  end

  context 'with configs' do
    before do
      path_to_configs = Pathname.new("./spec").realpath
      allow(Rails).to receive(:root).and_return(path_to_configs)
    end

    describe '.purchase_card', :vcr do
      context 'for valid params' do
        let(:params) {{ shop_card_id: 3266, to_email: 'rpmilevskiy@gmail.com' }}

        it 'returns successful result' do
          expect(subject.purchase_card(params).successful?).to be_truthy
        end

        it 'returns response' do
          expect(subject.purchase_card(params).response.id).to_not be_nil
        end
      end

      context 'for invalid params' do
        context 'shop_card_id' do
          let(:params) {{ shop_card_id: 111 }}

          it 'returns unsuccessful result' do
            expect(subject.purchase_card(params).successful?).to be_falsey
          end

          it 'returns error' do
            expect(subject.purchase_card(params).response).to include('Cannot find shop card for purchase')
          end
        end

        context 'to_email' do
          let(:params) {{ shop_card_id: 3266, to_email: '123' }}

          it 'returns unsuccessful result' do
            expect(subject.purchase_card(params).successful?).to be_falsey
          end

          it 'returns error' do
            expect(subject.purchase_card(params).response).to include('Email address is not valid')
          end
        end
      end
    end
  end

  context 'without configs' do
    let(:params) {{ shop_card_id: 3266, to_email: 'rpmilevskiy@gmail.com' }}

    it 'returns unsuccessful result' do
      expect(subject.purchase_card(params).successful?).to be_falsey
    end

    it 'returns error' do
      expect(subject.purchase_card(params).response).to eq('Provide configs in gyftwrapper.yml file')
    end
  end
end
