class CategoriesController < ApplicationController
    before_action :authorize_request, except: :index
    before_action :find_category, except: %i[create index]

    # GET /categories
    def index
        @categories = Category.all
        render json: {categories: @categories, status: :ok}
    end

    # GET /categories/{slug}
    def show
        render json: @category, status: :ok
    end

    # POST /categories
    def create
        @category = Category.new(category_params)
        @category.valid?
        if @category.save
            render json: {category: @category, status: :created}
        else
            render json: { errors: @category.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    # PUT /categories/{slug}
    def update
        if @category.update(category_params)
            render json: {category: @category, status: :created}
        else
            render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /categories/{slug}
    def destroy
        if @category.destroy
            render json: {category: @category, status: :ok}
        end
    end

    private

    def find_category
        @category = Category.find_by_slug!(params[:_slug])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Category not found' }, status: :not_found
    end

    def category_params
        params.permit(
         :name, :description
        )
    end
end
