//
//  MovieItem.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 21/07/23.
//

import Foundation

/**
 * This is a row of a movie Item. Every Movie List and Movie Detail row item should confirm this
 */

protocol MovieItem {
    var cellReusableIdentifier: String { get set }
}
