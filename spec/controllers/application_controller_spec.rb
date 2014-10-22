describe ApplicationController do
  describe '.domain_url' do
    it 'returns protocol://domain' do
      expect(subject.domain_url).to eq('http://test.host')
    end
  end
end
