class NewsCreator
  def initialize(params, current_user)
    @params = {
      title:   params[:title],
      body:    params[:body],
      user_id: current_user.id
    }
  end

  def execute
    if news.save
      {
        news: {
          id:         news.id,
          title:      news.title,
          body:       news.body,
          state:      news.state,
          user_id:    news.user_id,
          created_at: news.created_at.strftime('%FT%T%:z')
        }
      }
    else
      { errors: news.errors.messages }
    end
  end

  private

  def news
    @news ||= News.new(@params)
  end
end
