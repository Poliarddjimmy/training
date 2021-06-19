class CourseUsersController < ApplicationController
    before_action :authorize_request, except: %i[index create]
    before_action :find_course_user, except: %i[index create]

    def index
        @da = CourseUser.all
        render json: {da: @da, status: :ok}
    end
    # POST /course_users
    def create
        course_user = CourseUser.new(course_user_params)
        course_user.valid?
        if CourseUser.verify(course_user.user_id, course_user.course_id) 
            render json: { message: "Exist already" }
        else
            if course_user.save
                render json: true, status: :created
            else
                render json: { errors: course_user.errors.full_messages },
                    status: :unprocessable_entity
            end    
        end
    end

    # PUT /course_users/{id}
    def update
        if @course_user.update(course_user_params)
            render json: {status: :created}
        else
            render json: { errors: @course_user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /course_users/{id}
    def destroy
        if @course_user.destroy
            render json: {status: :ok}
        end
    end

    private

    def find_course_user
        @course_user = CourseUser.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Not found' }, status: :not_found
    end

    def course_user_params
        params.permit(
        :user_id, :course_id, :confirm
        )
    end
end
