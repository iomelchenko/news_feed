class NewsSearcher
  def initialize(params)
    @params = { id: params[:id] }
  end

  def execute
    if news.valid?
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
    @news ||= News.published.find(@params[:id])
  end
end
