class RecipesController < ApplicationController

	before_action :set_recipe, only: [:show, :edit, :delete, :update]
	
	def new
		@recipe = Recipe.new
		@ingredients = Ingredient.all
	end


	def create
	
		@recipe = Recipe.create(recipe_params)
			if params[:ingredient]
				params[:ingredient].each do |ingredient|
				@ingredients = Ingredient.find(ingredient)
				@recipe.ingredients << @ingredients
			end
		end
		@recipe.save

		redirect_to recipe_path(@recipe)
	end

	def show
	end

	def edit
		@recipe = Recipe.find(params[:id])
		@ingredients = Ingredient.all
	end

	def update
		@recipe = Recipe.find(params[:id])
		@recipe.update(recipe_params)
		@recipe.ingredients = []
		@recipe.save
			if params[:ingredient]
				params[:ingredient].each do |ingredient|
				@ingredients = Ingredient.find(ingredient)
				@recipe.ingredients << @ingredients
			end
		end

		redirect_to recipe_path(@recipe)
	end

	private

	def set_recipe
		@recipe = Recipe.find(params[:id])
	end

	def recipe_params
		params.require(:recipe).permit(:name)
	end
end
