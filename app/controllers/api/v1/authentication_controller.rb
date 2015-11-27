module Api::V1
  class AuthenticationController < ApiController
    before_filter :authenticate_user!, except: [:create]
    
    #curl -i -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3000/v1/signin   -d '{"email": "michael@nyclabs.com", "password": "test1234"}'
    #curl -i -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NTA4ODU2MzJ9.JUzj-ZBpdYZfnvr78zuxsk3voylV8WVwky6xb6QtAJ0" http://localhost:3000/v1/
    def create
      user = User.find_for_database_authentication( :email => params[:email] )
      access_denied and return unless user

      if user.valid_password?(params[:password])
        sign_in( "user", user )
        render json: authentication_payload( user, 60 * 24 * 30 )
      else
        access_denied and return
      end
    end
    
    def destroy
    end
    
  end
end