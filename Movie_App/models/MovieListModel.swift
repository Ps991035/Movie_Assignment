//
//  MovieModel.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

struct MovieListModel {
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

extension MovieListModel {
    
    /**
     * @param searchText    Filter the movies based upon on this.
     *  This function check that whether the given search text is present in title,year,genre,director or actor ans return true if present.
     */
    
    func isMovieModelContains(_ searchText: String) -> Bool {
        let _searchText = searchText.lowercased()
        if (self.year?.lowercased().contains(_searchText) ?? false) || (self.genre?.lowercased().contains(_searchText) ?? false) || (self.directors?.lowercased().contains(_searchText) ?? false) || (self.actors?.lowercased().contains(_searchText) ?? false) || (self.title?.lowercased().contains(_searchText) ?? false){
            return true
        }
        return false
    }
    
}
