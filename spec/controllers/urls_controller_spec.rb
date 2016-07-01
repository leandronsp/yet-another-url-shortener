describe UrlsController, type: :controller do
  describe 'GET /shortened_url' do
    before do
      Url.create(id: 12345, url: 'http://domain/profile.html')
    end

    it 'redirects to the original url' do
      get :original, params: { key: '3d7' }
      expect(response).to redirect_to('http://domain/profile.html')
    end

    it 'increments the number of visits' do
      get :original, params: { key: '3d7' }
      get :original, params: { key: '3d7' } #second visit

      expect(Url.find(12345).number_of_visits).to eq(2)
    end

    context 'not found' do
      it 'returns 404' do
        get :original, params: { key: 'abc' }
        expect(response.code).to eq('404')
      end
    end
  end

  describe 'POST /' do
    before do
      post :create, params: { url: 'http://domain.com/cool.html' }
    end

    it 'saves the url' do
      expect(Url.last.url).to eq('http://domain.com/cool.html')
    end

    it 'returns the shortened url into Location' do
      expect(response.code).to eq('201')
      expect(response.location).to eq('http://test.host/1')
    end

    context 'with current user' do
      let(:user) { User.make! }

      before do
        session[:user_id] = user.id
        post :create, params: { url: 'http://custom.com/cool.html' }
      end

      it 'makes the user relation' do
        expect(user.urls.first.url).to eq('http://custom.com/cool.html')
      end
    end

    context 'already exists' do
      before do
        post :create, params: { url: 'http://domain.com/cool.html' }
      end

      it 'does not save' do
        expect(Url.count).to eq(1)
      end

      it 'returns the existent shortened url into Location' do
        expect(response.code).to eq('201')
        expect(response.location).to eq('http://test.host/1')
      end
    end

    context 'invalid url' do
      before do
        post :create, params: { url: 'invalid.url' }
      end

      it 'returns bad request status code' do
        expect(response.code).to eq('400')
      end
    end
  end
end
