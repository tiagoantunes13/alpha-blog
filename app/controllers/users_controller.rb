class UsersController < ApplicationController


  before_action :set_user, only:[:show, :update, :edit, :destroy]
  before_action :require_user,  only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    if session[:user_id] != nil
      redirect_to articles_path
    else
      @user = User.new
    end

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account has been updated"
      redirect_to user_path(@user)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def show
    #@articles = Article.where(user_id: params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if current_user == @user
    flash[:notice] = "Account deleted"
    redirect_to signup_path, status: :see_other#, status: :unprocessable_entity
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your profile"
      redirect_to root_path
    end
  end


  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
