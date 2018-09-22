class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end
  def show
   @prototypes = Tag.find(params[:id]).prototypes.page(params[:page]).per(8).order("created_at ASC")
  end
end
