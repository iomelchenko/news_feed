class SessionCreator

    def initialize(params)
      @params = {
        username: params[:username],
        password: params[:password]
      }
    end

    def execute
      if user.present?
        {
          api_key: user.api_key
        }
      else
        { errors: 'Incorrect username or password' }
      end
    end

    private

    def user
      @user ||= User.authenticated(@params[:username], @params[:password])
    end
  end
