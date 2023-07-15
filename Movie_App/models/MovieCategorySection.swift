//
//  MovieCategorySection.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import Foundation

class MovieCategorySection {
    
    var title: String?
    var rows: [String]?
    var isExpanded: Bool = false
    
    init(title: String? = nil, rows: [String]? = nil, isExpanded: Bool) {
        self.title = title
        self.rows = rows
        self.isExpanded = isExpanded
    }
    
}
