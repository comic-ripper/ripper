class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show]

  def show
    respond_to do |format|
      format.html do
        @pages = @chapter.pages.order(:number).page(params[:page]).per(1)
        render :page
      end
      format.json { render json:  @chapter, include: :pages }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chapter
    @chapter = Chapter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chapter_params
    params.require(:chapter)
  end
end
