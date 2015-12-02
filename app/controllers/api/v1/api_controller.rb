module Api::V1
  class ApiController < ApplicationController
    
    def page_params( params )
      page = params[:page] ? params[:page][:number] : nil
      per = params[:page] ? params[:page][:size] : nil
      
      [page, per]
    end
    
  end
end