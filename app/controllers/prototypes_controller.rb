class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :destroy, :edit, :update]

  def index
<<<<<<< HEAD
    #現状Like数でのソートになっていません。Like機能追加後に修正します。
    @prototypes = Prototype.all.page(params[:page]).per(5)
=======
    @prototypes = Prototype.page(params[:page]).per(8).order("created_at DESC")
>>>>>>> master
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
    @prototypes = Prototype.all.order(created_at: "DESC").page(params[:page]).per(5)
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
