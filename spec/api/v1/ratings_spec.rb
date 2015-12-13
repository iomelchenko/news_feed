describe V1::Ratings do
  let(:user) { create :user }
  let(:news) { create :news, user: user }
  let!(:comment) { create :comment, user: user, news: news }

  before do
    @credentials = get_credentials(user)
    @params = {rating: 5, target_type: 'News', target_id: news.id}
  end

  def response_json
    JSON.parse(response.body)
  end

  context 'Default user' do
    describe "can" do
      it "update rating for news" do
        put "/api/v1/ratings", @params.merge!(@credentials)
        created_rating = Rating.last

        expect(response_json['rating']).to eq({
          "id"   => created_rating.id,
          "rating" => created_rating.rating,
          "target_type" => created_rating.target_type,
          "target_id" => created_rating.target_id
        })
      end
    end
  end

  context 'Guest user' do
    describe "can" do
      it "update rating for news" do
        put "/api/v1/ratings", @params
        created_rating = Rating.last

        expect(response_json['rating']).to eq({
          "id"   => created_rating.id,
          "rating" => created_rating.rating,
          "target_type" => created_rating.target_type,
          "target_id" => created_rating.target_id
        })
      end
    end
  end
end
