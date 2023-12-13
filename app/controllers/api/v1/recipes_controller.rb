class Api::V1::RecipesController < ActionController::API

  def search
    query = params["query"]
    result_set = Recipe.joins(:recipe_type, :user)
    result_set = result_set.where("title LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%")
    render json: result_set.to_json(), status: 200
  end
end
