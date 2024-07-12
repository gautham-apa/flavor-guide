//
//  MealDetailViewModel.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/10/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetailModel: MealDetailModel?
    @Published var error: RequestError?
    let mealId: String
    @Published var isFetching: Bool = false
    
    let networkService: RecipesNetworkServiceable
    
    init(mealId: String, networkService: RecipesNetworkServiceable = NetworkService()) {
        self.mealId = mealId
        self.networkService = networkService
    }
    
    func makeNetworkCall() async {
        isFetching = true
        let result = await networkService.fetchRecipeDetail(for: mealId)
        defer { isFetching = false }
        
        switch result {
        case .success(let responseModel):
            let detailModel = MealDetailModel(mealResponse: responseModel.meals.first ?? [:])
            mealDetailModel = detailModel
            error = nil
        case .failure(let error):
            self.error = error
        }
    }
}


