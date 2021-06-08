class CoursesController < ApplicationController
    # before_action :authorize_request, except: :index
    before_action :find_course, except: %i[create index]

    # GET /courses
    def index
        @courses = Course.all
        render json: {courses: @courses, status: :ok}
    end

    # GET /courses/{slug}
    def show
        render json: @course, status: :ok
    end

    # POST /courses
    def create
        @course = Course.new(course_params)
        @course.valid?
        if @course.save
            render json: {course: @course, status: :created}
        else
            render json: { errors: @course.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    # PUT /courses/{slug}
    def update
        if @course.update(course_params)
            render json: {course: @course, status: :created}
        else
            render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /courses/{slug}
    def destroy
        if @course.destroy
            render json: {course: @course, status: :ok}
        end
    end

    private

    def find_course
        @course = Course.find_by_slug!(params[:_slug])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'course not found' }, status: :not_found
    end

    def course_params
        params.permit(
        :picture, :name, :slug, :description, :category_id
        )
    end
end
