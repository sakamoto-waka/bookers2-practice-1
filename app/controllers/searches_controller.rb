class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @content = params[:content]
    @model = params[:model]
    method = params[:method]
    # 後で後置if使ってみる
    if model == 'user'
      @records = User.search_for(content, method)
    else
      @records = Book.search_for(content, method)
    end  
  end
end
