class SearchesController < ApplicationController

  autocomplete :user, :name
  autocomplete :micropost, :content
  autocomplete :reply, :reply

  def index
    @pg_search_documents = 
      PgSearch.multisearch(params[:search]).page params[:page]
  end
end
