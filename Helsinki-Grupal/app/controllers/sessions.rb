JobVacancy::App.controllers :sessions do

  get :login, :map => '/login' do
    @user = User.new
    render 'sessions/new'
  end

  post :create do
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find(email)
    if @user.nil?
      @user = User.new
      flash.now[:error] = 'Invalid credentials'
      render 'sessions/new'
    else
      is_valid = @user.authenticate(password)
      @user.save
      if is_valid
        sign_in @user
        redirect '/'
      else
        @user.locked? ? flash.now[:error] = 'Your account has been locked' : flash.now[:error] = 'Invalid credentials'
        @user = User.new
        render 'sessions/new'
      end
    end
  end

  get :destroy, :map => '/logout' do
    sign_out
    redirect '/'
  end

end
