describe V1::Comments do
  let(:params) do
    {
      comment: attributes_for(:comment)[:comment],
      news_id:  attributes_for(:comment)[:news_id],
      user_id:  attributes_for(:comment)[:user_id]
    }
  end

  let(:user) { create :user }
  let(:published_news) { create :news, user: user }
  let!(:comments) { create_list :comment, 5, user: user, news: published_news }

  before do
    published_news.state = 'published'
    published_news.save
    @credentials = get_credentials(user)
  end

  def response_json
    JSON.parse(response.body)
  end

  context 'Default user' do
    describe "can POST" do
      it "new comment" do
        post "/api/v1/news/#{published_news.id}/comments", params.merge!(@credentials)
        created_comment = Comment.last

        expect(response_json['comment']).to eq({
          "id"   => created_comment.id,
          "comment" => created_comment.comment,
          "user_id" => created_comment.user_id,
          "news_id" => created_comment.news_id,
          "created_at" => created_comment.created_at.strftime('%FT%T%:z')
        })
      end
    end

    describe "can GET" do
      it "all comments for published news" do
        get "/api/v1/news/#{published_news.id}/comments"

        expect(response.status).to eql 200
        expect(response_json.count).to eq News.find(published_news.id).comments.count
      end
    end
  end

  context 'Guest' do
    describe "can POST" do
      it "new comment" do
        post "/api/v1/news/#{published_news.id}/comments", params
        created_comment = Comment.last

        expect(response_json['comment']).to eq({
          "id"   => created_comment.id,
          "comment" => created_comment.comment,
          "user_id" => created_comment.user_id,
          "news_id" => created_comment.news_id,
          "created_at" => created_comment.created_at.strftime('%FT%T%:z')
        })
      end
    end
  end
end
