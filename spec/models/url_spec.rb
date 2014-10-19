describe Url do
  describe '.create' do
    context 'duplicated url' do
      before do
        Url.create(url: 'http://domain/profile.html')
      end

      it 'raises ActiveRecord::RecordNotUnique error' do
        expect { Url.create(url: 'http://domain/profile.html') }
          .to raise_error(ActiveRecord::RecordNotUnique)
      end
    end

    context 'given a user' do
      it 'makes the relation with user' do
        user = User.make!
        Url.create(url: 'http://new.com/url.html', user_id: user.id)

        expect(user.urls.first.url).to eq('http://new.com/url.html')
      end
    end
  end
end
