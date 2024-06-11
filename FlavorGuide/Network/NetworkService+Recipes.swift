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

struct RecipesNetworkService: RecipesNetworkServiceable, HTTPClient {
    func fetchRecipes(for category: MealCategory) async -> Result<MealGlimpseResponseModel, RequestError> {
        let result = await sendRequest(request: RecipesRequest.fetchRecipes(category: category), responseModelType: MealGlimpseResponseModel.self)
        return result
    }
    
    func fetchRecipeDetail(for mealId: String) async -> Result<MealDetailResponseModel, RequestError> {
        let result = await sendRequest(request: RecipesRequest.fetchRecipeDetail(mealId: mealId), responseModelType: MealDetailResponseModel.self)
        return result
    }
}
