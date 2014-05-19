class ComicsController < ApplicationController
  before_action :set_comic, only: [:show]

  # GET /comics
  # GET /comics.json
  def index
    @comics = Comic.all
  end

  def show

  end

  # GET /comics/new
  def new
    @comic = Comic.new
  end

  # POST /comics
  # POST /comics.json
  def create
    @comic = Comic.new(comic_params)
    if params[:comic][:parser_data][:type] == "batoto"
      @comic.parser = BatotoRipper::Comic.new(
        url: params[:comic][:parser_data][:url],
        language: params[:comic][:parser_data][:language]
      )
    end

    respond_to do |format|
      if @comic.save
        format.html { redirect_to @comic, notice: 'Comic was successfully created.' }
        format.json { render :show, status: :created, location: @comic }
      else
        format.html { render :new }
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comic
      @comic = Comic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comic_params
      params.require(:comic).permit(:title)
    end
end
