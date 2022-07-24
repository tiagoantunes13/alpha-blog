class ArticlesController < ApplicationController

  before_action :set_article, only:[:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)

  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(set_permit)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article successfully created"
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end



  def update
    if @article.update(set_permit)
      flash[:notice] = "Article successfully updated"
      redirect_to article_path(@article)#edit_article_path
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @article.destroy
    redirect_to articles_path, status: :see_other
  end


  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_permit
    params.require(:article).permit(:tittle, :description)
  end


end
