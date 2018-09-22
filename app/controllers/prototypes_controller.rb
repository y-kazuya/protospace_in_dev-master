class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :destroy, :edit, :update]

  def index
    #現状Like数でのソートになっていません。Like機能追加後に修正します。
    @prototypes = Prototype.page(params[:page]).per(8).order("created_at ASC")
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    3.times do
      @prototype.tags.build
    end
    #@tag1 = Tag.new
    #@tag2 = Tag.new
    #@tag3 = Tag.new
    #@tags = [@tag1,@tag2,@tag3]
  end

  def create
    @prototype = Prototype.new(prototype_params)
    n =[]
    @prototype.tags.each do |t|
      tag = Tag.find_by(name: t.name)
      unless tag == nil
        n << tag
      else
        n << t
      end
    end
    @prototype.tags = []
    n.each do |w|
      @prototype.tags << w
    end


    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      render :new
    end
  end

  def show

    @tags = Prototype.find(params[:id]).tags
    @comment = Comment.new
    @comments = @prototype.comments.order(created_at: :DESC).includes(:user)
  end

  def edit
    PrototypesTag.where(prototype_id:@prototype.id).destroy_all
    3.times do
      @prototype.tags.build
    end
  end

  def update
 
    n =[]
    @prototype.tags.each do |t|
      tag = Tag.find_by(name: t.name)
      unless tag == nil
        n << tag
      else
        n << t
      end
    end
    @prototype.tags = []
    n.each do |w|
      @prototype.tags << w
    end
    if @prototype.update(prototype_update_params)
      redirect_to root_path, alert: 'Prototype was successfully Update'
    else
      render :edit
    end

  end
  def destroy
    @prototype.destroy
    redirect_to :root, alert: 'Prototype was successfully deleted'
  end

  def newest
    @prototypes = Prototype.page(params[:page]).per(8).order("created_at DESC")
  end


  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status],
      tags_attributes: [:name]
    )
  end

  def prototype_update_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :id],
      tags_attributes: [:name,:id]
    )
  end

end
