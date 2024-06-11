//
//  String.swift
//  FlavorGuide
//
//  Created by Hariharan Sundaram on 6/10/24.
//

extension StringProtocol {
    var firstLetterCapitalized: String { prefix(1).capitalized + dropFirst() }
}
