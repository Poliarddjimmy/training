class UsersController < ApplicationController
    before_action :authorize_request, except: %i[show index]
    before_action :find_user, except: %i[create index subscribe]

    # GET /users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # GET /users/{username}
    def show
        render json: @user, status: :ok
    end

    # POST /users
    def create
        @user = User.create(user_params)
        if @user
            render json: @user, status: 200
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # PUT /users/{username}
    def update
        if @user.update(user_params)
            render json: @user, status: :ok
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    #GET /users/subscribe/{_course_id}
    def subscribe
        authorization = @current_user.subscribed(params[:_course_slug])
        if authorization
            render json: true
        else
            render json: false
        end
    end

    # DELETE /users/{username}
    def destroy
        if @user.destroy
            render json: @user, status: :ok
        end
    end

    private

    def find_user
        @user = User.find_by_username!(params[:_username])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
        params.permit(
        :avatar, :name, :username, :email, :password, :password_confirmation
        )
    end
end
