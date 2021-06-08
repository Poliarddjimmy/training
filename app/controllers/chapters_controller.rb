class ChaptersController < ApplicationController
    # before_action :authorize_request, except: :index
    before_action :find_chapter, except: %i[create index]

    # GET /chapters
    def index
        @chapters = Chapter.all
        render json: {chapters: @chapters, status: :ok}
    end

    # GET /chapters/{slug}
    def show
        render json: @chapter, status: :ok
    end

    # POST /chapters
    def create
        @chapter = Chapter.new(chapter_params)
        @chapter.valid?
        if @chapter.save
            render json: {chapter: @chapter, status: :created}
        else
            render json: { errors: @chapter.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    # PUT /chapters/{slug}
    def update
        if @chapter.update(chapter_params)
            render json: {chapter: @chapter, status: :created}
        else
            render json: { errors: @chapter.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /chapters/{slug}
    def destroy
        if @chapter.destroy
            render json: {chapter: @chapter, status: :ok}
        end
    end

    private

    def find_chapter
        @chapter = Chapter.find_by_slug!(params[:_slug])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'chapter not found' }, status: :not_found
    end

    def chapter_params
        params.permit(
        :title, :description, :slug, :objective, :course_id
        )
    end
end
