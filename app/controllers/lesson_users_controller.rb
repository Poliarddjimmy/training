class LessonUsersController < ApplicationController
    before_action :authorize_request, except: %i[index create]
    before_action :find_lesson_user, except: %i[index create]

    def index
        @da = LessonUser.all
        render json: {da: @da, status: :ok}
    end
    # POST /lesson_users
    def create
        lesson_user = LessonUser.new(lesson_user_params)
        lesson_user.valid?
        if LessonUser.verify(lesson_user.user_id, lesson_user.lesson_id) 
            render json: { message: "Exist already" }
        else 
            if lesson_user.save
                render json: true, status: :created
            else
                render json: { errors: lesson_user.errors.full_messages },
                    status: :unprocessable_entity
            end    
        end
    end

    # PUT /lesson_users/{id}
    def update
        if @lesson_user.update(lesson_user_params)
            render json: {status: :created}
        else
            render json: { errors: @lesson_user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /lesson_users/{id}
    def destroy
        if @lesson_user.destroy
            render json: {status: :ok}
        end
    end

    private

    def find_lesson_user
        @lesson_user = LessonUser.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Not found' }, status: :not_found
    end

    def lesson_user_params
        params.permit(
        :user_id, :lesson_id, :confirm
        )
    end
end
