//
//  MealListView.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/9/24.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var mealListViewModel = MealListViewModel()
    
    var body: some View {
        Group {
            if mealListViewModel.isFetching {
                ProgressView()
            } else if mealListViewModel.mealList.isEmpty {
                EmptyView()
            } else {
                mealListView()
            }
        }
        .alert(mealListViewModel.error?.message ?? "Something went wrong",
               isPresented: .constant(mealListViewModel.error != nil)) {
            Button("OK") {
                mealListViewModel.error = nil
            }
        }
        .onAppear {
            Task(priority: .userInitiated) {
                await mealListViewModel.makeNetworkCall()
            }
        }
    }
    
    @ViewBuilder
    func mealListView() -> some View {
        NavigationStack {
            List(mealListViewModel.mealList) { mealModel in
                NavigationLink(value: mealModel.idMeal) {
                    VStack(alignment: .leading, spacing: 0) {
                        MealListRow(recipeModel: mealModel)
                    }
                }
            }
            .navigationDestination(for: String.self) { mealId in
                MealDetailView(mealDetailViewModel: MealDetailViewModel(mealId: mealId))
            }
            .navigationTitle("Dessert")
        }
        .listStyle(PlainListStyle())
    }
}
