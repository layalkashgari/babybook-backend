class ImagesController < ApplicationController

  before_action :set_image, only: [:show, :update, :destroy]

  def index 
    if params[:page_id]
      @images = Page.find(params[:page_id]).images 
    else 
      @images = Images.all 
    end 
    render json: @images
  end 

  def show 
    render json: @image
  end 

  def create 
    @image = Image.new(image_params)
    render json: @image.as_json.merge({image_url: url_for(@image.image)})
  end 

  def update 
    @image.update_attributes(image_params)
    render json: @image
  end 

  def destroy 
    @image.destroy 
    render json: {message: "success"}
  end 

  private 
  def set_image
    @image = Image.find(params[:id])
  end 
  def image_params 
    params.permit(:page_id, :image)
  end

end
