//
//  MealGlimpseModel.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

struct MealGlimpseResponseModel: Decodable {
    let meals: [MealGlimpseModel]
}

struct MealGlimpseModel: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

extension MealGlimpseModel: Identifiable {
    var id: String { idMeal }
}
