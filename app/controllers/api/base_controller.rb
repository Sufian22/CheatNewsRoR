module Api
    class BaseController < ApplicationController

      protect_from_forgery
      before_filter :current_user, :cors_preflight_check
      after_filter :cors_set_access_control_headers


      def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization' 
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Max-Age'] = '1728000'
      end


      def cors_preflight_check
        if request.method == :options
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT'
          headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
          headers['Access-Control-Request-Method'] = '*'
          headers['Access-Control-Max-Age'] = '1728000'
          render :text => '', :content_type => 'text/plain'
        end
      end
    end
end