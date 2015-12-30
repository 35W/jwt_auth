module Api::V1
  class ApiController < ApplicationController
    def pages_meta( results )
      {
        page: {
          number: results.current_page, size: results.total_count,
          pages: results.total_pages, next_page: results.next_page,
          prev_page: results.prev_page, per_page: results.limit_value
        }
      }
    end

    def render_pages_for( klass, params )
      page = params[:page] || {}
      results = klass.order( order_hash(params) ).page( page[:number] ).per( page[:size] )
      render json: results , meta: pages_meta( results )
    end

    def order_hash( params )
      order = { id: :asc }
      order = params[:sort].split(",").inject({}) do |memo, item|
        item_name = item.gsub('-','')
        item_dir = item =~ /^\-/ ? :desc : :asc
        memo[item_name.to_sym] = item_dir
        memo
      end if params[:sort]
      order
    end
  end
end