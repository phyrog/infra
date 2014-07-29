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
    if properties[:act] == "add"
      @property = Property.find_or_create_by(properties.permit(:name, :postfix, :value_type))
      @property.postfix = nil if properties[:postfix].empty?
      @property.save
      @tag.properties << @property
      render '_property', layout: false
    else 
      prop = @tag.properties.find_by(name: properties[:name])
      prop.destroy
      render json: prop, action: 'update'
    end
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

  def properties
    params.require(:property).permit(:name, :postfix, :value_type, :act)
  end
end
