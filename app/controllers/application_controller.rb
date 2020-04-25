class ApplicationController < ActionController::Base
	
	rescue_from ActiveRecord::RecordNotFound, 
		            with: :record_not_found

  before_action :check_login
  
  helper_method :current_user, :current_cart
  # 取代session[:kkk1230]

  private

  def check_login
    redirect_to login_path unless current_user
    # if not session[:kkk1230] && controller_name != "users"
    #       redirect_to login_path
    # end
  end

  def record_not_found
  	render file: 'public/404.html',
  	              status: 404,
  	              layout: false
  	# redirect_to items_path, notice: "沒有品項喔!"
  end

  def current_user
    # session[:kkk1230] 有寫下面就不用這行
    User.find_by(id: session[:kkk1230])
  end

  
  def current_cart 
    @_ca123 ||= Cart.from_hash(session[:carty])
  end
  



end
