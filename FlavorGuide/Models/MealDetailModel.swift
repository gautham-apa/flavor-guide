//
//  MealDetailModel.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

struct MealDetailResponseModel: Codable {
    let meals: [[String: String?]]
}

struct MealDetailModel: Identifiable {
    struct IngredientAndMeasure: Hashable {
        let ingredient: String
        let measure: String
    }
    
    let mealID: String
    let mealName: String
    let instructions: String
    let mealThumb: String
    let tags: [String]
    let ingredientWithMeasureList: [IngredientAndMeasure]
    var id: String { mealID }
    
    init?(mealResponse: [String: String?]) {
        guard let mealID = mealResponse["idMeal"] as? String,
              let mealName = mealResponse["strMeal"] as? String,
              let instructions = mealResponse["strInstructions"] as? String,
              let mealThumb = mealResponse["strMealThumb"] as? String else {
            return nil
        }
        self.mealID = mealID
        self.mealName = mealName
        self.instructions = instructions
        self.mealThumb = mealThumb
        
        // Converting tag string into a list
        if let mealTags = mealResponse["strTags"] as? String {
            self.tags = mealTags.components(separatedBy: ",").map { tag in
                return tag
            }
        } else {
            self.tags = []
        }
        
        // Building a list of ingredients
        let maxIngredientCount = 20
        var ingredientList: [IngredientAndMeasure] = []
        for index in 0...maxIngredientCount {
            let ingredient = mealResponse["strIngredient\(index)"] as? String
            let measure = mealResponse["strMeasure\(index)"] as? String
            guard let ingredientValue = ingredient, !ingredientValue.isEmpty else { continue }
            ingredientList.append(IngredientAndMeasure(ingredient: ingredientValue, measure: measure ?? ""))
        }
        ingredientWithMeasureList = ingredientList
    }
}
