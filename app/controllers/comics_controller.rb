class ComicsController < ApplicationController
  before_action :set_comic, only: [:show]

  respond_to :html, :json

  # GET /comics
  # GET /comics.json
  def index
    @comics = Comic.order(:title).page(params[:page]).per(12)
    respond_with(@comics)
  end

  def show
    respond_to do |format|
      format.html do
        @chapters = Kaminari.paginate_array(@comic.chapters.sort_by(&:number_for_file)).page(params[:page]).per(12)
        respond_with(@chapters)
      end
      format.json do
        respond_with(@comic, include: :chapters)
      end
    end
  end

  # GET /comics/new
  def new
    @comic = Comic.new
    respond_with(@comic)
  end

  # POST /comics
  # POST /comics.json
  def create
    @comic = Comic.new(comic_params)
    parser = ParserLibrary.get_parser params[:comic][:parser_data][:url]

    @comic.parser = parser.new(
      url: params[:comic][:parser_data][:url]
    )

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
    @comic = Comic.includes(:chapters).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comic_params
    params.require(:comic).permit(:title)
  end
end
