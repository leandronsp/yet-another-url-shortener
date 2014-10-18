describe UrlsController, type: :controller do
  describe 'GET /shortened_url' do
    before do
      Url.create(id: 12345, url: 'http://domain/profile.html')
    end

    it 'redirects to the original url' do
      get :original, key: '3d7'
      expect(response).to redirect_to('http://domain/profile.html')
    end

    it 'increments the number of visits' do
      get :original, key: '3d7'
      get :original, key: '3d7' # second visit

      expect(Url.find(12345).number_of_visits).to eq(2)
    end

    context 'not found' do
      it 'returns 404' do
        get :original, key: 'abc'
        expect(response.code).to eq('404')
      end
    end
  end

  describe 'POST /' do
    before do
      post :create, url: 'http://domain.com/cool.html'
    end

    it 'saves the url' do
      expect(Url.last.url).to eq('http://domain.com/cool.html')
    end

    it 'returns the shortened url into Location' do
      expect(response.code).to eq('200')
      expect(response.location).to eq('http://test.host/1')
    end

    context 'already exists' do
      before do
        post :create, url: 'http://domain.com/cool.html'
      end

      it 'does not save' do
        Url.count.should eq(1)
      end

      it 'returns the existent shortened url into Location' do
        expect(response.code).to eq('200')
        expect(response.location).to eq('http://test.host/1')
      end
    end

    context 'invalid url' do
      before do
        post :create, url: 'invalid.url'
      end

      it 'returns bad request status code' do
        expect(response.code).to eq('400')
      end
    end
  end
end
