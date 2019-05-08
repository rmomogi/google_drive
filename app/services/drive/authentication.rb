require 'google/api_client/client_secrets.rb'

module Drive
  module Authentication 
    def self.call(current_user)
      Google::APIClient::ClientSecrets.new(
        {
          "web" =>
            {
              "access_token" => current_user.token,
              "refresh_token" => current_user.refresh_token,
              "client_id" => ENV.fetch('GOOGLE_CLIENT_ID'),
              "client_secret" => ENV.fetch('GOOGLE_SECRET')
            }
        }
      )
    end
  end
end