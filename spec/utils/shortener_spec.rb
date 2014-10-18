describe Shortener do
  describe 'encode' do
    it 'encodes from decimal base to base62' do
      expect(described_class.encode62(0)).to  eq('0')
      expect(described_class.encode62(5)).to  eq('5')
      expect(described_class.encode62(10)).to eq('a')
      expect(described_class.encode62(15)).to eq('f')
      expect(described_class.encode62(35)).to eq('z')
      expect(described_class.encode62(62)).to eq('10')
      expect(described_class.encode62(63)).to eq('11')
    end

    specify 'invalid range character' do
      expect { described_class.encode62('/') }.to raise_error(ArgumentError)
    end
  end

  describe 'decode' do
    it 'decodes from base62 to decimal base' do
      expect(described_class.decode62('0')).to  eq(0)
      expect(described_class.decode62('5')).to  eq(5)
      expect(described_class.decode62('a')).to  eq(10)
      expect(described_class.decode62('f')).to  eq(15)
      expect(described_class.decode62('z')).to  eq(35)
      expect(described_class.decode62('10')).to eq(62)
      expect(described_class.decode62('11')).to eq(63)
    end
  end
end
