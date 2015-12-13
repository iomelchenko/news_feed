describe V1::PublicNews do
  let(:params) do
    {
      title: attributes_for(:news)[:title],
      body:  attributes_for(:news)[:body]
    }
  end

  let(:user) { create :user }
  let(:news) { create :news, user: user }
  let(:published_news) { create :news, user: user }

  before do
    published_news.state = 'published'
    published_news.save
  end

  def response_json
    JSON.parse(response.body)
  end

  context 'Default user' do
    describe "can GET" do
      it "all list of published news" do
        get "/api/v1/public_news"

        expect(response.status).to eql 200
        expect(response_json.count).to eq News.published.count
      end

      it "published news by id" do
        get "/api/v1/public_news/#{published_news.id}"

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
        get "/api/v1/public_news/#{news.id}"

        expect(response.status).to eql 404
        expect(response_json['errors']).to eql("Couldn't find News with 'id'=#{news.id}")
      end
    end

    describe "can POST" do
      it "new news" do
        post '/api/v1/public_news', params.merge!(user_id: user.id)
        created_news = News.last

        expect(response_json['news']).to eq({
          "id"   => created_news.id,
          "title" => created_news.title,
          "body" => created_news.body,
          "state" => 'pending approval',
          "created_at" => created_news.created_at.strftime('%FT%T%:z')
        })
      end
    end
  end
end