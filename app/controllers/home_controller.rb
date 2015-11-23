class HomeController < ApplicationController
  #before_filter :authenticate_user!, except: [:create]
  
  def index
    render json: { } 
  end
  
end