module Api::V1
  class HomeController < ApiController
    before_filter :authenticate_user!
  
    def index
      render json: { "you_are" => @current_user.email }
    end
  
  end
end