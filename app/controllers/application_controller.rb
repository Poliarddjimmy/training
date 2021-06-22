class ApplicationController < ActionController::API

    def not_found
      render json: { error: 'not_found' }
    end
  
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

    def current_user
      @current_user = nil 
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decode = JsonWebToken.decode(header)
        @current_user = User.find(@decode[:user_id])
      rescue => exception
        puts exception
      end
    end  
      
end
