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
    
    init(mealId: String) {
        self.mealId = mealId
    }
    
    func makeNetworkCall() async {
        isFetching = true
        let result = await RecipesNetworkService().fetchRecipeDetail(for: mealId)
        isFetching = false
        switch result {
        case .success(let responseModel):
            let detailModel = MealDetailModel(mealResponse: responseModel.meals.first ?? [:])
            mealDetailModel = detailModel
        case .failure(let error):
            self.error = error
        }
    }
}


