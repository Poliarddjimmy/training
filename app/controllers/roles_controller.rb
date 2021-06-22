class RolesController < ApplicationController
    before_action :authorize_request, except: :index
    before_action :find_role, except: %i[create index]

    # GET /roles
    def index
        @roles = Role.all
        render json: {roles: @roles, status: :ok}
    end

    # GET /roles/{slug}
    def show
        render json: @role, status: :ok
    end

    # POST /roles
    def create
        @role = Role.new(role_params)
        @role.valid?
        if @role.save
            render json: {role: @role, status: :created}
        else
            render json: { errors: @role.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    # PUT /roles/{slug}
    def update
        if @role.update(role_params)
            render json: {role: @role, status: :created}
        else
            render json: { errors: @role.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /roles/{slug}
    def destroy
        if @role.destroy
            render json: {role: @role, status: :ok}
        end
    end

    private

    def find_role
        @role = Role.find_by_slug!(params[:_slug])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'role not found' }, status: :not_found
    end

    def role_params
        params.require(:role).permit(:name)
    end
end
