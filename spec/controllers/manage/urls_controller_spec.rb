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

    context 'unauthenticated' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
