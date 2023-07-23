//
//  MovieConstantsHelper.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 22/07/23.
//

import Foundation

enum MovieCategory: String {
    case GENERE = "Genere"
    case YEAR = "Year"
    case ACTOR = "Actor"
    case DIRECTOR = "Director"
    case ALL_MOVIE = "All Movie"
}

enum MovieListTitle: String {
    case TITLE = "Title"
    case YEAR = "Year"
    case GENRE = "Genre"
    case DIRECTOR = "Director"
    case ACTORS = "Actors"
    case LANGUAGE = "Language"
    case POSTER = "Poster"
    case PLOT = "Plot"
    case RELEASED = "Released"
    case RATINGS = "Ratings"
    case SOURCE = "Source"
    case VALUE = "Value"
    case CAST_CREW = "Cast & Crew"
    case RELEASED_DATE = "Released Date"
}

struct MovieConstants {
    
    var main = "Main"
    var data = "Data"
    var json = "json"
    var movieListView = "MovieListView"
    var movieListTableViewCell = "MovieListTableViewCell"
    var searchBarTitle = "Search movies by title/actor/genre/director"
    var chevronUp = "chevron.compact.up"
    var chevronDown = "chevron.compact.down"
    var movieListViewController = "MovieListViewController"
    var movieDetailViewController = "MovieDetailViewController"
    var movieRatingCollectionViewCell = "MovieRatingCollectionViewCell"
    var movieDetailTableViewCell = "MovieDetailTableViewCell"
    var movieCategoryTableViewCell = "MovieCategoryTableViewCell"
    var error = "Error has Occured"
    var noSearchResultFoundText = "No Search Result Found! \n Please try again"
}
