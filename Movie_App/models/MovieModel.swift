//
//  MovieModel.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

struct MovieModel {
    var title: String?
    var poster: String?
    var year: String?
    var language: String?
    var genre: String?
    var directors: String?
    var actors: String?
    var plot: String?
    var releaseDate: String?
    var ratings: [Ratings]?
    
}

struct Ratings {
    var source: String?
    var value: String?
}
