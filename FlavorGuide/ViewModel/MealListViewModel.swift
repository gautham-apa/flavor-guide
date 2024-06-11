//
//  MealListViewModel.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var mealList: [MealGlimpseModel] = []
    @Published var error: RequestError?
    @Published var isFetching: Bool = false
    
    func makeNetworkCall() async {
        isFetching = true
        let result = await RecipesNetworkService().fetchRecipes(for: .dessert)
        isFetching = false
        switch result {
        case .success(let responseModel):
            mealList = responseModel.meals.sorted { $0.strMeal < $1.strMeal }
        case .failure(let error):
            self.error = error
        }
    }
}

