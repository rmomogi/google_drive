class User < ApplicationRecord
  has_one :permission

  devise :database_authenticatable, :timeoutable, :omniauthable, :omniauth_providers => [:google_oauth2]
  
  def self.from_omniauth(auth)
    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    where(email: auth.info.email).first_or_create do |user|
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
      user.email = auth.info.email
      user.name = auth.info.name
    end
  end
end
