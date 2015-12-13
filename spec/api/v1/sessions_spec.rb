describe V1::Sessions do
  let(:params) do
    {
      username: 'user',
      password: 'user'
    }
  end

  before(:all) do
    @user = create :user, username: 'user', password: 'user'
    @credentials = get_credentials(@user)
  end

  def response_json
    JSON.parse(response.body)
  end

  describe "POST /api/v1/sessions" do
    it "returns users api_key" do
      post '/api/v1/sessions', params

      expect(response_json['api_key']).to eq(@user[:api_key])
    end
  end

  describe "DELETE /api/v1/sessions/" do
    it "updates users api_key" do
      api_key = @user.api_key
      delete "/api/v1/sessions", @credentials

      expect(@user.reload.api_key).to_not eq(api_key)
      expect(response_json['notice']).to eq('You need to sign in before continuing.')
    end
  end
end
