//
//  MovieDataRepository.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

class MovieDataRepository: MovieRepository {
    
    init() { }
    
    /**
     *  This function serialize the json and send the completion of the List of the movies if error has not occured.
     *  IF error has come then in completion it will send the error message in completion
     */
    
    func fetch(_ completion: @escaping MovieResponseCompletionHandler) {
        
        if let url = Bundle.main.url(forResource: MovieConstants().data, withExtension: MovieConstants().json){
            do{
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let result = object as? [Any]{
                    completion(parseResponse(result: result), nil)
                }else{
                    completion(nil, MovieConstants().error)
                }
            }
            catch {
                completion(nil, MovieConstants().error)
            }
        }
    }
    
    /**
     *  @param result    Contains the information of the List of the movies
     *  This function parse the result of the movies and convert that in array of the movie model.
     */
    
    private func parseResponse(result: [Any])-> [MovieListModel] {
        
        var movieItems = [MovieListModel]()
        
        for _result in result {
            
            var ratingModel = [Ratings]()
            
            let movieDetail = _result as? [AnyHashable:Any]
            
            let title = movieDetail?[MovieListTitle.TITLE.rawValue] as? String
            let year = movieDetail?[MovieListTitle.YEAR.rawValue] as? String
            let genre = movieDetail?[MovieListTitle.GENRE.rawValue] as? String
            let director = movieDetail?[MovieListTitle.DIRECTOR.rawValue] as? String
            let actors = movieDetail?[MovieListTitle.ACTORS.rawValue] as? String
            let language = movieDetail?[MovieListTitle.LANGUAGE.rawValue] as? String
            let poster = movieDetail?[MovieListTitle.POSTER.rawValue] as? String
            let plot = movieDetail?[MovieListTitle.PLOT.rawValue] as? String
            let releaseDate = movieDetail?[MovieListTitle.RELEASED.rawValue] as? String
            
            let ratings = movieDetail?[MovieListTitle.RATINGS.rawValue] as? [Any]
            
            for rating in ratings ?? [] {
                let _rating = rating as? [AnyHashable:Any]
                let source = _rating?[MovieListTitle.SOURCE.rawValue] as? String
                let value = _rating?[MovieListTitle.VALUE.rawValue] as? String
                ratingModel.append(Ratings(source: source, value: value))
            }
            
            let movieModel = MovieListModel(title: title,poster: poster, year: year,language: language, genre: genre,directors: director,actors: actors,plot: plot, releaseDate: releaseDate, ratings: ratingModel)
            movieItems.append(movieModel)
        }
        
        return movieItems
    }
}
