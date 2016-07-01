describe SessionsController, type: :controller do
  render_views

  let!(:user) { User.make! email: 'fompila@gmail.com', password: '123' }

  describe 'GET /sign_in' do
    it 'renders the sign in form' do
      get :new
      expect(response.body).to match('Your Email')
      expect(response.body).to match('Your password')
    end
  end

  describe 'POST /sign_in' do
    it 'redirects to manage dashboard' do
      params = { user: { email: 'fompila@gmail.com', password: '123' }}
      post :create, params: params
      expect(response).to redirect_to('/manage')
    end

    context 'wrong password' do
      it 'show error message validation' do
        params = { user: { email: 'fompila@gmail.com', password: 'wrong' }}
        post :create, params: params
        expect(response.body).to match('Email/Password invalid')
      end
    end
  end

  describe 'GET /logout' do
    it 'removes user from session and redirects to root' do
      session['user_id'] = user.id

      get :destroy

      expect(session['user_id']).to be_nil
      expect(response).to redirect_to('/')
    end
  end

end
