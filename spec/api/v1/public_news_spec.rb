describe V1::PublicNews do
  let(:params) do
    {
      title: attributes_for(:news)[:title],
      body:  attributes_for(:news)[:body]
    }
  end

  let(:user) { create :user }
  let(:manager) { create :user, role: 'Manager' }
  let(:news) { create :news, user: user }
  let(:published_news) { create :news, user: user }

  before do
    published_news.state = 'published'
    published_news.save
    @credentials = get_credentials(user)
    @managers_credentials = get_credentials(manager)
  end

  def response_json
    JSON.parse(response.body)
  end

  context 'Default user' do
    describe "can GET" do
      it "all list of published news" do
        get "/api/v1/news"

        expect(response.status).to eql 200
        expect(response_json.count).to eq News.published.count
      end

      it "published news by id" do
        get "/api/v1/news/#{published_news.id}"

        expect(response_json['news']).to eq({
          "id"   => published_news.id,
          "title" => published_news.title,
          "body" => published_news.body,
          "state" => published_news.state,
          "user_id" => published_news.user_id,
          "created_at" => published_news.created_at.strftime('%FT%T%:z')
        })
      end
    end

    describe "can NOT GET" do
      it "unpublished news by id" do
        get "/api/v1/news/#{news.id}"

        expect(response.status).to eql 404
        expect(response_json['errors']).to eql("Couldn't find News with 'id'=#{news.id}")
      end
    end

    describe "can POST" do
      it "new news" do
        post '/api/v1/news', params.merge!(@credentials)
        created_news = News.last

        expect(response_json['news']).to eq({
          "id"   => created_news.id,
          "title" => created_news.title,
          "body" => created_news.body,
          "state" => 'pending approval',
          "user_id" => user.id,
          "created_at" => created_news.created_at.strftime('%FT%T%:z')
        })
      end
    end

    describe "can NOT POST" do
      it "new news vith invalid params" do
        params[:title] = ''
        post '/api/v1/news', params.merge!(@credentials)

        expect(response.status).to eql 422
      end

      it " approve news" do
        put "/api/v1/news/#{news.id}", @credentials

        expect(response.status).to eql 403
      end
    end
  end

  context 'Guest' do
    describe "can NOT POST" do
      it "new news" do
        post '/api/v1/news', params

        expect(response.status).to eql 401
      end
    end
  end

  context 'Manager' do
    describe "can" do
      it " approve news" do
        put "/api/v1/news/#{news.id}", @managers_credentials

        expect(response_json['news']).to eq({
          "id"   => news.id,
          "title" => news.title,
          "body" => news.body,
          "state" => 'published',
          "user_id" => news.user_id,
          "created_at" => news.created_at.strftime('%FT%T%:z')
        })
      end
    end
  end
end
