//
//  MealListRow.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/10/24.
//

import SwiftUI

struct MealListRow: View {
    @State var recipeModel: MealGlimpseModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipeModel.strMealThumb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .padding(.trailing, 20)
            Text(recipeModel.strMeal)
                .font(.system(size: 18, weight: .regular, design: .rounded))
        }
    }
}
