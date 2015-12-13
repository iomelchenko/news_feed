describe V1::SignUp do
  let(:params) do
    {
      username: attributes_for(:user)[:username],
      password: attributes_for(:user)[:password]
    }
  end

  def response_json
    JSON.parse(response.body)
  end

  describe "POST /api/v1/sign_up" do
    it "creates default user and returns users api_key" do
      post '/api/v1/sign_up', params
      user = User.last

      expect(response_json['user']).to eq({
        "id"   => user.id,
        "username" => user.username,
        "api_key" => user.api_key,
        "role" => 'Default account'
      })
    end

    it "creates user with Manager role and returns users api_key" do
      params[:role] = 'Manager'
      post '/api/v1/sign_up', params
      user = User.last

      expect(response_json['user']).to eq({
        "id"   => user.id,
        "username" => user.username,
        "api_key" => user.api_key,
        "role" => 'Manager'
      })
    end

    it "creates user with Admin role and returns users api_key" do
      params[:role] = 'Admin'
      post '/api/v1/sign_up', params
      user = User.last

      expect(response_json['user']).to eq({
        "id"   => user.id,
        "username" => user.username,
        "api_key" => user.api_key,
        "role" => 'Admin'
      })
    end
  end
end
