describe Manage::UrlsController, type: :controller do
  render_views

  describe 'GET index' do
    it 'lists URLs given a current user' do
      user   = User.make!
      model  = Url.make!(user_id: user.id)

      session[:user_id] = user.id
      get :index

      expect(response.body).to match('Hello, Chuck Norris')
      expect(response.body).to match(model.url)
      expect(response.body).to match(model.key)
    end

    context 'admin' do
      let(:user) { User.make!(role: 'admin') }
      let(:url)  { Url.make!(user_id: user.id) }

      before do
        session[:user_id] = user.id
        get :index
      end

      it 'renders with filter `All | My links`' do
        expect(response.body).to match('All')
        expect(response.body).to match('My Links')
      end

      it 'renders title `My Links`' do
        expect(response.body).to match('<h1>My Links</h1>')
      end

      context 'scope all' do
        before do
          session[:user_id] = user.id
          get :index, scope: 'all'
        end

        it 'renders with filter `All | My links`' do
          expect(response.body).to match('All')
          expect(response.body).to match('My Links')
        end

        it 'renders title `Manage Links`' do
          expect(response.body).to match('<h1>Manage Links</h1>')
        end
      end
    end

    context 'unauthenticated' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
