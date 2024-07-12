//
//  NetworkService+Recipes.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

protocol RecipesNetworkServiceable {
    func fetchRecipes(for category: MealCategory) async -> Result<MealGlimpseResponseModel, RequestError>
    func fetchRecipeDetail(for mealId: String) async -> Result<MealDetailResponseModel, RequestError>
}

extension NetworkService: RecipesNetworkServiceable {
    func fetchRecipes(for category: MealCategory) async -> Result<MealGlimpseResponseModel, RequestError> {
        let result = await networkServiceInterface.sendRequest(decodableType: MealGlimpseResponseModel.self, networkRequest: RecipesRequest.fetchRecipes(category: category))
        return result
    }
    
    func fetchRecipeDetail(for mealId: String) async -> Result<MealDetailResponseModel, RequestError> {
        let result = await networkServiceInterface.sendRequest(decodableType: MealDetailResponseModel.self, networkRequest: RecipesRequest.fetchRecipeDetail(mealId: mealId))
        return result
    }
}
