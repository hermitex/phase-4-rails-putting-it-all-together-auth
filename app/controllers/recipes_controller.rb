class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

  def index
    if session[:user_id]
      recipes = Recipe.all
      render json: recipes, include: [:user], status: :ok
    else
      render json: {errors: ["Login first to create a recipe"]}, status: :unauthorized
    end
  end

  def create
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      recipe = user.recipes.create!(recipe_params)
      render json: recipe, include: :user, status: :created
    else
      render json: {errors: ["Login first to create a recipe"]}, status: :unauthorized
    end
  end

  private
  def render_record_invalid_response(invalid)
    render json: {errors: invalid.record.errors.full_messages},  status: :unprocessable_entity
  end

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end
