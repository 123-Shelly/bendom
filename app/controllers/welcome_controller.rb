class WelcomeController < ApplicationController
	  skip_before_action :check_login

		def index
			# render html: "hi"	
	  end

	
	def login
		@user = User.new
	end

  def sign_up
  	@user = User.new
  end
  

  def sign_in
    user = User.find_by(email: user_params[:email],
	                      password: user_params[:password])
	  if user
	  	session[:kkk1230] = user.id 
	  	# 本來是mail改成id
	  	# 日安, <%= id[:kkk1230] %>
	  	redirect_to "/"
	  else
	  	redirect_to "/login"
	  end
  end


	def registration
		# user = params[:user]
		# p user[:password]
		# p user[:password_confirm]
		# if user_params[:password] == user_params[:password_confirm]
		# Strong parameters
		# clean_user = params.require(:user).permit(:email, :password_confirm)		
		@user = User.new(user_params)

		if @user.save
			session[:kkk1230] = @user.email

		  redirect_to "/login"
	  else
	  	render :sign_up
		  # J個失敗不會轉址，留在原地。
			# redirect_to "/sign_up 這個原本填的資料會不見，不好"
		end

	  # else
	  # 	redirect_to "/sign_up"
    #   end
  end


  def logout
  	session[:kkk1230] = nil
  	redirect_to "/"
  end




  private

  def user_params
  		params.require(:user).permit(:email, 
  																 :password, 
  																 :password_confirmation)
  end





end
  