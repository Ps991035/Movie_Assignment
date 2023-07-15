//
//  MovieDataAdapter.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

class MovieDataAdapter: MovieAdapter {    
    
    func getData(result: [Any]?) -> [MovieModel]? {
        
        guard let result = result else {
            return []
        }
        
        var movieModels = [MovieModel]()
        
        for _result in result {
            
            var ratingModel = [Ratings]()
            
            let movieDetail = _result as? [AnyHashable:Any]
            
            let title = movieDetail?["Title"] as? String
            let year = movieDetail?["Year"] as? String
            let genre = movieDetail?["Genre"] as? String
            let director = movieDetail?["Director"] as? String
            let actors = movieDetail?["Actors"] as? String
            let language = movieDetail?["Language"] as? String
            let poster = movieDetail?["Poster"] as? String
            let plot = movieDetail?["Plot"] as? String
            let releaseDate = movieDetail?["Released"] as? String
            
            let ratings = movieDetail?["Ratings"] as? [Any]
            
            for rating in ratings ?? [] {
                let _rating = rating as? [AnyHashable:Any]
                let source = _rating?["Source"] as? String
                let value = _rating?["Value"] as? String
                ratingModel.append(Ratings(source: source, value: value))
                
            }
            
            let movieModel = MovieModel(title: title,poster: poster, year: year,language: language, genre: genre,directors: director,actors: actors,plot: plot, releaseDate: releaseDate, ratings: ratingModel)
            
            movieModels.append(movieModel)
        }
        return movieModels
    }
}
