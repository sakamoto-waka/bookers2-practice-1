class SearchesController < ApplicationController
  before_action :authenticate_user!

  # def search
  #   @content = params[:content]
  #   @model = params[:model]
  #   method = params[:method]
  #   # 後で後置if使ってみる
  #   @model == 'user' ? @records = User.search_for(@content, method) : @records = Book.search_for(@content, method)
  # end

  def ransack_search
    @search_users = @q.result.includes(:books)
  end

end
