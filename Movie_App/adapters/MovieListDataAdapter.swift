//
//  MovieListDataAdapter.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 22/07/23.
//

import Foundation

class MovieListDataAdapter: MovieAdapter {
    
    /**
     * @param result   List of Movies
     *  This function set the movieListSectionItem where all the information of the section Item is present
     */
    
    func getData(result: [MovieListModel]?) -> [SectionItem]? {
        var movieSections = [SectionItem]()
        var movieSubItems = [MovieItem]()
        for movie in result ?? []{
            var movieSubItem = MovieListItem(cellReusableIdentifier: MovieConstants().movieListTableViewCell)
            movieSubItem.moviewListModel = movie
            movieSubItems.append(movieSubItem)
        }
        let movieSectionItem = MovieSectionItem(subItems: movieSubItems, sectionTitle: MovieCategory.ALL_MOVIE.rawValue)
        movieSections.append(movieSectionItem)
        return movieSections
        
    }
    
}
