//
//  NetworkRequest+Recipes.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

enum MealCategory: String {
    case dessert = "Dessert"
}

enum RecipesRequest: NetworkRequestible {
    case fetchRecipes(category: MealCategory)
    case fetchRecipeDetail(mealId: String)
}

extension RecipesRequest {
    var path: String {
        switch self {
        case .fetchRecipes:
            return "/api/json/v1/1/filter.php"
        case .fetchRecipeDetail:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        case .fetchRecipes(let category):
            return [URLQueryItem(name: "c", value: category.rawValue)]
        case .fetchRecipeDetail(let mealId):
            return [URLQueryItem(name: "i", value: mealId)]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchRecipes, .fetchRecipeDetail:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchRecipes, .fetchRecipeDetail:
            return nil
        }
    }
    
    
    var body: [String : String]? {
        switch self {
        case .fetchRecipes, .fetchRecipeDetail:
            return nil
        }
    }
}
