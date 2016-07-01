describe HomeController, type: :controller do
  it 'returns 200 on GET /index' do
    get :index
    expect(response.code).to eq('200')
  end
end
