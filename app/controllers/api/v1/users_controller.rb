module Api::V1
  class UsersController < ApiController
    before_filter :authenticate_user!
    
    #curl -i -g -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NTA4ODU2MzJ9.JUzj-ZBpdYZfnvr78zuxsk3voylV8WVwky6xb6QtAJ0" "http://localhost:3000/v1/users?page[number]=2&page[size]=2"
    def index
      page, per = page_params( params )
      
      
      users = User.order(:id).page( page ).per( per )
      render json: users
    end
  
  end
end