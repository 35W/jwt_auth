class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  
  def authentication_payload( user, ttl_in_minutes = nil )
    return nil unless user && user.id
    {
      auth_token: AuthToken.encode( { user_id: user.id }, ttl_in_minutes ),
      user: { id: user.id, username: user.email } # return whatever user info you need
    }
  end
  
  def authenticate_user!
    @current_user ||= begin
                        @decoded_auth_token ||= decoded_auth_token
                        User.find( @decoded_auth_token[:user_id].to_i )
                      rescue JWT::ExpiredSignature
                        authentication_timeout
                      rescue JWT::VerificationError, JWT::DecodeError, ActiveRecord::RecordNotFound
                        access_denied
                      end
  end
  
  def decoded_auth_token
    @http_auth_token ||= request.headers['HTTP_AUTHORIZATION'].present? ? request.headers['HTTP_AUTHORIZATION'].split(' ').last : nil
    @decoded_auth_token ||= AuthToken.decode( @http_auth_token )
  end
  
  def access_denied
    render json: { errors: ['Not Authorized'] }, status: :forbidden
  end
  
  def authentication_timeout
    render json: { errors: ['Authentication Timeout'] }, status: 419
  end
  
end
