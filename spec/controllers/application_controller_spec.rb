describe ApplicationController do
  describe '.domain_url' do
    it 'returns protocol://domain' do
      expect(subject.domain_url).to eq('http://test.host')
    end

    context 'env development' do
      before do
        allow(Rails.env).to receive(:development?) { true }
      end

      it 'returns protocol://domain:port' do
        expect(subject.domain_url).to eq('http://test.host:80')
      end
    end
  end
end
