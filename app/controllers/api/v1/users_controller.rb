module Api::V1
  class UsersController < ApiController
    before_filter :authenticate_user!
    
    #curl -i -g -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMDIsImV4cCI6MTQ1Mjk3NjQyOH0.hYaSDfXc3zTHB7lQPX6cKsLVsg6ao1Bq-chh7CJHLIQ" "http://localhost:3000/v1/users?page[number]=2&page[size]=2"
    def index
      render_pages_for( User, params )
    end
  end
end