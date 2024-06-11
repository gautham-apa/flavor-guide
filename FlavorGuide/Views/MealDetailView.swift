//
//  MealDetailView.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/10/24.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        VStack {
            if mealDetailViewModel.isFetching {
                ProgressView()
            } else if let mealDetailModel = mealDetailViewModel.mealDetailModel {
                scrollContent(mealDetailModel: mealDetailModel)
            } else {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                    
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.all, 9)
                        .background(.white)
                        .clipShape(.circle)
                }
                .frame(width: 30, height: 30)
                .tint(Color.white)
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .alert(mealDetailViewModel.error?.message ?? "Something went wrong",
               isPresented: .constant(mealDetailViewModel.error != nil)) {
            Button("OK") {
                mealDetailViewModel.error = nil
            }
        }
       .onAppear {
           Task(priority: .userInitiated) {
               await mealDetailViewModel.makeNetworkCall()
           }
       }
    }
    
    @ViewBuilder
    func constructIngredientList(detailModel: MealDetailModel) -> some View {
        VStack(spacing: 0) {
            ForEach(detailModel.ingredientWithMeasureList, id: \.self) { ingredientAndMeasure in
                HStack {
                    Text(ingredientAndMeasure.ingredient.firstLetterCapitalized)
                        .font(.system(size: 15, weight: .medium))
                    Spacer()
                    Text(ingredientAndMeasure.measure)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 15)
                Divider()
            }
        }
    }
    
    @ViewBuilder
    func scrollContent(mealDetailModel: MealDetailModel) -> some View {
        ScrollView {
            AsyncImage(url: URL(string: mealDetailModel.mealThumb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 400)
            .scaledToFit()
            .cornerRadius(15)
            recipeContent(detailModel: mealDetailModel)
        }
        .background(Color(red: 240/255, green: 242/255, blue: 247/255))
        .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    func recipeContent(detailModel: MealDetailModel) -> some View {
        Spacer().frame(height: 30)
        Text(detailModel.mealName).font(.title).multilineTextAlignment(.center)
            .fontWeight(.bold)
            .padding(.horizontal, 20)
        Spacer().frame(height: 30)
        VStack {
            Text("Ingredients").font(.title2).multilineTextAlignment(.leading)
                .fontWeight(.bold)
                .padding(.vertical, 20)
            constructIngredientList(detailModel: detailModel)
            Text("Instructions").font(.title2).multilineTextAlignment(.leading)
                .fontWeight(.bold)
                .padding(.vertical, 20)
            Text(detailModel.instructions).font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.gray)
            Spacer().frame(height: 30)
            HStack {
                ForEach(detailModel.tags, id: \.self) { tag in
                    Text(tag).font(.system(size: 15, weight: .medium, design: .rounded))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundStyle(.white)
                        .background(.gray)
                        .clipShape(.capsule)
                }
            }
            Spacer().frame(height: 30)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(15)
    }
}
