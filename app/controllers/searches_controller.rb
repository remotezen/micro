class SearchesController < ApplicationController
  def index
    @pg_search_documents = 
      PgSearch.multisearch(params[:search]).page params[:page]
  end
end
