class CoursesController < ApplicationController
    before_action :authorize_request, except: %i[show index]
    before_action :find_course, except: %i[create index]
    before_action :current_user

    # GET /courses
    def index
        @courses = Course.all
        render json: {courses: @courses, status: :ok}
    end

    # GET /courses/{slug}
    def show
        haveAcess = false
        if @current_user
            puts @current_user.name
            haveAcess = !!@course.subscribed(@current_user)
        end
        render json: {course: @course, haveAcess: haveAcess}, status: :ok
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
        params.require(:course).permit(:picture, :name, :slug, :description, :category_id, :user_id)
    end
end
