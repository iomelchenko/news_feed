module AuthHelper
  def get_credentials(user = nil)
    user ||= create :user
    {api_key: user.api_key, username: user.username}
  end
end
