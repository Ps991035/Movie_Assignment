//
//  MovieSectionItem.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 21/07/23.
//

import Foundation

/**
 *  This initialize the Section Item of a movie.
 */

class MovieSectionItem: SectionItem {
    var isExpanded: Bool? = false
    var subItems: [MovieItem]
    var sectionTitle: String?
    
    init(subItems: [MovieItem], sectionTitle: String? = nil) {
        self.subItems = subItems
        self.sectionTitle = sectionTitle
    }
}
