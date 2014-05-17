class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show]

  def show
    @page = @chapter.pages.order(:number).first
    @next_page = @chapter.pages.order(:number)[1]
    render :page
  end

  def page
    @chapter = Chapter.find params[:chapter_id]
    @page = @chapter.pages.where(number: params[:page_number]).first
    @next_page = @chapter.pages.where(number: @page.number+1).first
    if @next_page.nil?
      chapters = @chapter.comic.chapters.order(:number)
      chin = chapters.index(@chapter)
      if chapters[chin+1]
        @next_page = chapters[chin+1]
      else
        @next_page = @chapter.comic
      end
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
