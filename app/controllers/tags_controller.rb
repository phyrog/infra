class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
    @tag = Tag.find_or_create_by(tag_params)
    respond_to do |format|
      format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
      format.json { render action: 'show', status: :created, location: @tag }
    end
  end

  def destroy
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
