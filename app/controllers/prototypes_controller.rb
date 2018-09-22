class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :destroy, :edit, :update]

  def index
    #現状Like数でのソートになっていません。Like機能追加後に修正します。
    @prototypes = Prototype.page(params[:page]).per(8).order("created_at ASC")
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      render :new
     end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.order(created_at: :DESC).includes(:user)
  end

  def edit
  end

  def update
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
      captured_images_attributes: [:content, :status]
    )
  end

  def prototype_update_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :id]
    )
  end
end
