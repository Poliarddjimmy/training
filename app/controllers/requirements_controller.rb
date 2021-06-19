class RequirementsController < ApplicationController
    before_action :authorize_request
    before_action :find_requirement, except: %i[create index]

    # GET /requirements/{id}
    def show
        render json: @requirement, status: :ok
    end

    # POST /requirements
    def create
        @requirement = Requirement.new(requirement_params)
        @requirement.valid?
        if @requirement.save
            render json: {requirement: @requirement, status: :created}
        else
            render json: { errors: @requirement.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    # PUT /requirements/{id}
    def update
        if @requirement.update(requirement_params)
            render json: {requirement: @requirement, status: :created}
        else
            render json: { errors: @requirement.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /requirements/{id}
    def destroy
        if @requirement.destroy
            render json: {requirement: @requirement, status: :ok}
        end
    end

    private

    def find_requirement
        @requirement = Requirement.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Requirement not found' }, status: :not_found
    end

    def requirement_params
        params.require(:requirement).permit(:price, :content, :duration, :course_id)
    end
end
