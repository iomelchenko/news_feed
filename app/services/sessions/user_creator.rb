class UserCreator
  def initialize(params)
    @params = {
      username: params[:username],
      password: params[:password],
      role:     params[:role]
    }
  end

  def execute
    if user.save
      { user:
        {
          id:       user.id,
          username: user.username,
          api_key:  user.api_key,
          role:     user.role
        }
      }
    else
      { errors: user.errors.messages }
    end
  end

  private

  def user
    @params[:role] = 'Default account' if @params[:role].nil?
    @user ||= User.new(username: @params[:username],
                       password: @params[:password],
                       role: @params[:role])
  end
end
