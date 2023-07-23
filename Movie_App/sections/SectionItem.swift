//
//  MovieSectionItem.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 22/07/23.
//

import Foundation

/**
 * This is a section of a movie Item. Every Movie Section item should confirm this
 */

protocol SectionItem: AnyObject {
    var subItems: [MovieItem] {get set}
    var isExpanded: Bool? {get set}
    var sectionTitle: String? {get set}
}
