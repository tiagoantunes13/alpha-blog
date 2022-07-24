class CategoriesController < ApplicationController

  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
    p " ASDASDASDASDASDASDASdASDASD SADASDDSADSADSA"
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])

  end

  def create
    @category = Category.new(category_params)
    p params
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to category_url(@category)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end


  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "Nao tem permissoes para criar artigos"
      redirect_to categories_path
    end
  end


end
