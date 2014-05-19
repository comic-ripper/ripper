class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show]

  def show
    params[:page_number] ||= 1

    if params[:page_number]
      @page = @chapter.pages.where(number: params[:page_number]).first

      if @chapter.pages.where(number: params[:page_number].to_i + 1).first
        @next_page = {page_number: @page.number+1}
      else
        chapters = @chapter.comic.chapters.order(number: :asc)
        chin = chapters.index(@chapter)
        if chapters[chin+1]
          @next_page = chapters[chin+1]
        else
          @next_page = @chapter.comic
        end
      end
    end

    render :page
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
