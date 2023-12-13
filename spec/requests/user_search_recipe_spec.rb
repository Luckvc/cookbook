require 'rails_helper'

describe 'User search recipe api' do
  context '/api/v1/recipes/search' do
    it 'response 200' do
      get search_api_v1_recipes_url, params: { query: 'Hamburguer'}

      expect(response).to have_http_status 200
    end
    it 'search by title' do
      user = User.create!(email: 'user@email.com', password: '123456', role: :user)
      dessert = RecipeType.create!(name: 'Sobremesa')
      main_course = RecipeType.create!(name: 'Prato principal')
      Recipe.create!(title: 'Manjar', cook_time: 60,
                    user: user,
                    recipe_type: dessert,
                    ingredients: 'leite condensado, leite, leite de coco',
                    instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')
      Recipe.create!(title: 'Hamburguer', cook_time: 10,
                    user: user,
                    recipe_type: main_course,
                    ingredients: 'hamburguer, pão de hamburguer, queijo',
                    instructions: 'Frite o hamburguer, coloque no pão, coma')
      Recipe.create!(title: 'HotDog', cook_time: 10,
                    user: user,
                    recipe_type: main_course,
                    ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                    instructions: 'Asse a salsicha, coloque no pão, coma')

      get search_api_v1_recipes_url, params: { query: 'Hamburguer'}

      expect(response).to have_http_status 200
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
      expect(json[0]["title"]).to eq "Hamburguer"
      expect(json[0]["cook_time"]).to eq 10
    end
    it 'search by recipe type' do
      user = User.create!(email: 'user@email.com', password: '123456', role: :user)
      dessert = RecipeType.create!(name: 'Sobremesa')
      main_course = RecipeType.create!(name: 'Prato principal')
      Recipe.create!(title: 'Manjar', cook_time: 60,
                    user: user,
                    recipe_type: dessert,
                    ingredients: 'leite condensado, leite, leite de coco',
                    instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')
      Recipe.create!(title: 'Hamburguer', cook_time: 10,
                    user: user,
                    recipe_type: main_course,
                    ingredients: 'hamburguer, pão de hamburguer, queijo',
                    instructions: 'Frite o hamburguer, coloque no pão, coma')
      Recipe.create!(title: 'HotDog', cook_time: 10,
                    user: user,
                    recipe_type: main_course,
                    ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                    instructions: 'Asse a salsicha, coloque no pão, coma')

      get search_api_v1_recipes_url, params: { query: 'Prato principal'}

      expect(response).to have_http_status 200
      json = JSON.parse(response.body)
      expect(json.length).to eq 2
      expect(json[0]["title"]).to eq "Hamburguer"
      expect(json[0]["cook_time"]).to eq 10
      expect(json[1]["title"]).to eq "HotDog"
      expect(json[1]["cook_time"]).to eq 10
    end
    it 'with no result' do
      user = User.create!(email: 'user@email.com', password: '123456', role: :user)
      dessert = RecipeType.create!(name: 'Sobremesa')
      main_course = RecipeType.create!(name: 'Prato principal')
      Recipe.create!(title: 'Manjar', cook_time: 60,
                    user: user,
                    recipe_type: dessert,
                    ingredients: 'leite condensado, leite, leite de coco',
                    instructions: 'Misture tudo, leve ao fogo e mexa, leve a geladeira')
      Recipe.create!(title: 'Hamburguer', cook_time: 10,
                    user: user,
                    recipe_type: main_course,
                    ingredients: 'hamburguer, pão de hamburguer, queijo',
                    instructions: 'Frite o hamburguer, coloque no pão, coma')
      Recipe.create!(title: 'HotDog', cook_time: 10,
                    user: user,
                    recipe_type: main_course,
                    ingredients: 'salsicha, pão de hotdog, ketchup, mostarda',
                    instructions: 'Asse a salsicha, coloque no pão, coma')

      get search_api_v1_recipes_url, params: { query: 'Pizza'}

      expect(response).to have_http_status 200
      json = JSON.parse(response.body)
      expect(json.length).to eq 0
    end
  end
end