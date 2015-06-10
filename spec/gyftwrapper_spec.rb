require 'spec_helper'

describe Gyftwrapper do
  describe '.purchase_card' do
    it 'calls send request method with appropriate call type' do
      expect(Gyftwrapper).to receive(:send_request).with(:purchase_card, {})
      Gyftwrapper.purchase_card({})
    end
  end

  describe '.send_request' do
    let(:api) { double('api', purchase: true) }

    before { allow(Gyftwrapper::API).to receive(:new).and_return(api) }

    it 'calls appropriate api method' do
      expect(api).to receive(:purchase).and_return(true)
      Gyftwrapper.send_request(:purchase, {})
    end
  end
end
