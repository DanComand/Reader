class ArticlesController < ApplicationController
   before_filter :ensure_logged_in, only: [:create, :destroy]
  def index
  	@articles = Article.all
  end

  def show
  	@article = Article.find(params[:id])
  end

  def new
  	@article = Article.new
  end

  def edit
  	@article = Article.new(article_params)
  end

  def create
    @article = Article.new(article_params)

    meta = MetaInspector.new(@article.url)
    @article.title = meta.title
    @article.image = meta.images.best
    @article.summary = meta.description

    if @article.save
      redirect_to articles_url
    else
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(article_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :image, :summary, :url, :user_id)
  end
end