class RoleUsersController < ApplicationController
    before_action :authorize_request, except: %i[index create]
    before_action :find_role_user, except: %i[index create]

    def index
        @da = RoleUser.all
        render json: {da: @da, status: :ok}
    end
    # POST /role_users
    def create
        role_user = RoleUser.new(role_user_params)
        role_user.valid?
        verify = RoleUser.verify(role_user.user_id) 
        verify && verify.destroy
        
        if role_user.save
            render json: true, status: :created
        else
            render json: { errors: role_user.errors.full_messages },
                status: :unprocessable_entity
        end    
        
    end

    # PUT /role_users/{id}
    def update
        if @role_user.update(role_user_params)
            render json: {status: :created}
        else
            render json: { errors: @role_user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /role_users/{id}
    def destroy
        if @role_user.destroy
            render json: {status: :ok}
        end
    end

    private

    def find_role_user
        @role_user = RoleUser.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Not found' }, status: :not_found
    end

    def role_user_params
        params.require(:role_user).permit(:user_id, :role_id)
    end
end
