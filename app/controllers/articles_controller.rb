class ArticlesController < ApplicationController
  before_action :find_article, except: %i[index]

  def index
    @articles = Article.where(lang: params[:lang])
    json = ArticleBlueprint.render @articles, view: :normal
    render json: json
  end

  def show
    json = ArticleBlueprint.render @articel, view: :extended
    render json: json
  end

  private

  def find_article
    @articel = Article.find_by(slug: params[:slug])
  end
end
