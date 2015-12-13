class SessionDestroyer

    def initialize(current_user)
      @current_user = current_user
    end

    def execute
      if @current_user.present?
        @current_user.save!
        { notice: 'You need to sign in before continuing.' }
      else
        { errors: 'Session not found' }
      end
    end
  end
