class RecipesController < ApplicationController

    # Error messages
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    # GET /recipes
    def index 
        recipes = Recipe.all 
        render json: recipes, status: :ok
    end

    # GET /recipes/:id
    def show
        recipe = Recipe.find(params[:id])
        render json: recipe, status: :ok
    end

    # POST /recipes
    def create
        recipe = Recipe.create!(recipe_params)
        render json: recipe, status: :created
    end

    # PATCH/PUT /recipes/:id
    def update
        recipe = Recipe.find(params[:id])
        recipe.update!(recipe_params)
        render json: recipe, status: :created
    end

    # DELETE /recipes/:id
    def destroy
        recipe = Recipe.find(params[:id])
        recipe.destroy
        head :no_content
    end

    private 

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {errors: ["Recipe not found"]}, status: :not_found
    end

end
