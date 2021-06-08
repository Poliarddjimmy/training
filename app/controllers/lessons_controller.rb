class LessonsController < ApplicationController
    # before_action :authorize_request, except: :index
    before_action :find_lesson, except: %i[create index]

    # GET /lessons
    def index
        @lessons = Lesson.all
        render json: {lessons: @lessons, status: :ok}
    end

    # GET /lessons/{slug}
    def show
        render json: @lesson, status: :ok
    end

    # POST /lessons
    def create
        @lesson = Lesson.new(lesson_params)
        @lesson.valid?
        if @lesson.save
            render json: {lesson: @lesson, status: :created}
        else
            render json: { errors: @lesson.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    # PUT /lessons/{slug}
    def update
        if @lesson.update(lesson_params)
            render json: {lesson: @lesson, status: :created}
        else
            render json: { errors: @lesson.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /lessons/{slug}
    def destroy
        if @lesson.destroy
            render json: {lesson: @lesson, status: :ok}
        end
    end

    private

    def find_lesson
        @lesson = Lesson.find_by_slug!(params[:_slug])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'lesson not found' }, status: :not_found
    end

    def lesson_params
        params.permit(
        :title, :content, :slug, :description, :chapter_id
        )
    end
end
