class RatingsEditor
  def initialize(params, current_user_id)
    @params = {
      target_type: params[:target_type],
      target_id:   params[:target_id],
      rating:      params[:rating],
      user_id:     current_user_id
    }
  end

  def execute
    if users_rating.present?
      rating = user_rating
      rating.rating = @params[:rating]
    else
      rating = Rating.new(@params)
    end

    if rating.save
      {
        rating: {
          id:          rating.id,
          rating:      rating.rating,
          target_type: rating.target_type,
          target_id:   rating.target_id
        }
      }
    else
      { errors: rating.errors.messages }
    end
  end

  private

  def users_rating
    if @params[:user_id].present?
     @user_rating ||= Rating.where(user_id:     @params[:user_id],
                                   target_type: @params[:target_type],
                                   target_id:   @params[:target_id])
    end
    @user_rating
  end
end
