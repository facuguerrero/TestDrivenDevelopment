JobVacancy::App.controllers :users do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :new, :map => '/register' do
    @user = User.new
    render 'users/new'
  end

  post :create do
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    params[:user].reject! {|k, v| k == 'password_confirmation'}
    if password == password_confirmation
      @user = User.new(params[:user])
      if not @user.valid_password? password
        flash.now[:error] = 'Invalid password. Should have at least 10 characters with at least a number, a lowercase letter and an uppercase letter'
        render 'users/new'
      elsif @user.save
        flash[:success] = 'User created'
        redirect '/'
      else
        flash.now[:error] = 'All fields are mandatory'
        render 'users/new'
      end
    else
      @user = User.new (params[:user])
      flash.now[:error] = 'Passwords do not match'
      render 'users/new'
    end
  end

end
