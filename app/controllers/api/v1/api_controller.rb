module Api::V1
  class ApiController < ApplicationController
    
    def page_params( params )
      [ param[:page], param[:per_page] ]
    end
    
  end
end