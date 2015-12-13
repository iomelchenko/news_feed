class CommentsCreator
  def initialize(params, current_user_id)
    @params = {
      news_id: params[:news_id],
      comment: params[:comment],
      user_id: current_user_id
    }
  end

  def execute
    if comments.save
      {
        comment: {
          id:         comments.id,
          comment:    comments.comment,
          news_id:    comments.news_id,
          user_id:    comments.user_id,
          created_at: comments.created_at.strftime('%FT%T%:z')
        }
      }
    else
      { errors: comments.errors.messages }
    end
  end

  private

  def comments
    @comments ||= Comment.new(@params) if News.published.find(@params[:news_id]).present?
  end
end
