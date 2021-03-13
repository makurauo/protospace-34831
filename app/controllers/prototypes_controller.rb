class PrototypesController < ApplicationController
   before_action :authenticate_user!, except: [:index,:show]
   before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end
  
  def new
    @prototypes = Prototype.new
  end

  def show
    @prototypes = Prototype.find(params[:id])
    @comment = Comment.new
  end

  def edit
   @prototypes = Prototype.find(params[:id])
   redirect_to root_path unless current_user.id == @prototypes.user_id
  end

  def update
    @prototypes = Prototype.find(params[:id])
    @prototypes.update(prototypes_params)
    if @prototypes.save
      redirect_to prototype_path(@prototypes.id)
    else
      render :edit
    end
  end

  def create
    @prototypes = Prototype.new(prototypes_params)
    if @prototypes.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def destroy
    prototypes = Prototype.find(params[:id])
    prototypes.destroy
    redirect_to root_path(@prototypes)
  end

  private

  def prototypes_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  
  def move_to_index
      redirect_to new_user_session_path unless user_signed_in?
  end

end
