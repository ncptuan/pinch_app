//
//  PageModel.swift
//  PinchApp
//
//  Created by Mac on 14/08/2024.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnail: String {
        return "thumb-" + imageName;
    }
}
