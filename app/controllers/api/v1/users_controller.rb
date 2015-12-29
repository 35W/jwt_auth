module Api::V1
  class UsersController < ApiController
    before_filter :authenticate_user!
    
    #curl -i -g -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0NTA4ODU2MzJ9.JUzj-ZBpdYZfnvr78zuxsk3voylV8WVwky6xb6QtAJ0" "http://localhost:3000/v1/users?page[number]=2&page[size]=2"
    def index
      order = :id
      if params[:sort]
        order = params[:sort].split(",").inject({}) do |memo, item|
          item_name = item.gsub('-','')
          item_dir = item =~ /^\-/ ? :desc : :asc
          memo[item_name.to_sym] = item_dir
          memo
        end
      end
      users = User.order(order).page( params[:page] ).per( params[:per_page] )
      render json: users
    end
  
  end
end