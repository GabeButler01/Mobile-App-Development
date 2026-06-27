//
//  FavoriteItem.swift
//  APIPexels
//
//  Created by Gabe Butler on 11/28/24.
//

import SwiftData
import Foundation

@Model
class FavoriteItem {
    var url: String
    var favorite: Bool

    init(url: String, favorite: Bool = true) {
        self.url = url
        self.favorite = favorite
    }
}
