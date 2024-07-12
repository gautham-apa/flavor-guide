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
    
    let networkService: RecipesNetworkServiceable
    
    init(networkService: RecipesNetworkServiceable = NetworkService()) {
        self.networkService = networkService
    }
    
    func makeNetworkCall() async {
        isFetching = true
        let result = await networkService.fetchRecipes(for: .dessert)
        defer { isFetching = false }
        
        switch result {
        case .success(let responseModel):
            error = nil
            mealList = responseModel.meals.sorted { $0.strMeal < $1.strMeal }
        case .failure(let error):
            self.error = error
        }
    }
}

