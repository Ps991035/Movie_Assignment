//
//  MovieDetailViewModel.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 22/07/23.
//

import Foundation

class MovieDetailViewModel {
    
    /**
     * @param movie   The information of the movie
     *  This function get the movie information and based upon that it creates the item of Movie Item type which shows the information of a movie
     */
    
    func getMovieDetailItem(_ movie: MovieListModel) -> [MovieItem] {
        
        var movieItems = [MovieItem]()
        
        let movieTitleItem = MovieDetailItem(cellReusableIdentifier: MovieConstants().movieDetailTableViewCell,movieDetailModel: MovieDetailModel(title: MovieListTitle.TITLE.rawValue, value: movie.title ?? ""))
        
        let moviePlotItem = MovieDetailItem(cellReusableIdentifier: MovieConstants().movieDetailTableViewCell,movieDetailModel: MovieDetailModel(title: MovieListTitle.PLOT.rawValue, value: movie.plot ?? ""))
        
        let movieCast_Crew_Item = MovieDetailItem(cellReusableIdentifier: MovieConstants().movieDetailTableViewCell,movieDetailModel: MovieDetailModel(title: MovieListTitle.CAST_CREW.rawValue, value: (movie.directors ?? "") + (movie.actors ?? "")))
        
        let movieReleasedDateItem = MovieDetailItem(cellReusableIdentifier: MovieConstants().movieDetailTableViewCell,movieDetailModel: MovieDetailModel(title: MovieListTitle.RELEASED_DATE.rawValue, value: movie.releaseDate ?? ""))
        
        let movieGenreItem = MovieDetailItem(cellReusableIdentifier: MovieConstants().movieDetailTableViewCell,movieDetailModel: MovieDetailModel(title: MovieListTitle.GENRE.rawValue, value: movie.genre ?? ""))
        
        movieItems.append(movieTitleItem)
        movieItems.append(moviePlotItem)
        movieItems.append(movieCast_Crew_Item)
        movieItems.append(movieReleasedDateItem)
        movieItems.append(movieGenreItem)
        
        return movieItems
        
    }
}
