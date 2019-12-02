class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }, status: :not_found
  end

  def authorize_request
    render(status: :unauthorized) unless current_user
  end

  def only_for_admin
    render(status: :forbidden) unless current_user && current_user.admin?
  end

  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      nil
    rescue JWT::DecodeError => e
      nil
    end
  end
end
