class UsersController < ApplicationController
  # before_action :require_login, except: [:index, :new, :create]
  
  # before_action :require_correct_user, only: [:show, :edit, :update, :destroy]  
  
  def index

  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save 
      session[:user_id] = user.id
      redirect_to('/events');
    else
      flash[:register_errors] = user.errors.full_messages
      redirect_to('/');
    end
  end

  def show

  end

  def new
  end

  def edit
  end

  def update
    User.find(params[:id]).update(user_params)
    redirect_to '/events'
  end

  def destroy
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id;
      redirect_to '/events'
    else
      flash[:login_errors] = "Email and Password is invalid";
      redirect_to '/'
    end 
  end

  def logout
    session.destroy
    redirect_to('/')
  end

  private 
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
  end
end
