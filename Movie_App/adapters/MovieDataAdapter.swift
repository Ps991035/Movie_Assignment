//
//  MovieDataAdapter.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

class MovieDataAdapter: MovieAdapter {
    
    var movieListDataAdapter: MovieAdapter
    init(movieListDataAdapter: MovieAdapter){
        self.movieListDataAdapter = movieListDataAdapter
    }
    
    /**
     * @param result   List of Movies
     *  This function set the movieListOptionSectionItem where all the information of the section Item is present
     */
    
    func getData(result: [MovieListModel]?) -> [SectionItem]? {
        guard let result = result else {
            return []
        }
        var movieSectionItems = [SectionItem]()
        
        let optionModel = getMovieOptionModel(result)
        
        for model in optionModel {
            var movieSubItems = [MovieItem]()
            for option in model.option ?? [] {
                let movieItem = MovieListOptionItem(cellReusableIdentifier: MovieConstants().movieCategoryTableViewCell, label: option)
                movieSubItems.append(movieItem)
            }
            let movieSectionItem = MovieSectionItem(subItems: movieSubItems, sectionTitle: model.title)
            movieSectionItems.append(movieSectionItem)
        }
        
        movieSectionItems.append(contentsOf: movieListDataAdapter.getData(result: result) ?? [])
        
        return movieSectionItems
    }
    
    /**
     * @param result   List of Movies
     *  This function set the movieListOptionItem where all the information of the Item is present such as year, genres, directors and actors
     */
    
    private func getMovieOptionModel(_ result: [MovieListModel]) -> [MovieListOptionModel] {
        
        var years = Set<String>()
        var genres = Set<String>()
        var directors = Set<String>()
        var actors = Set<String>()
        
        var optionModel = [MovieListOptionModel]()
        
        for item in result {
            
            years.insert(item.year ?? "")
            
            let _genres = item.genre?.components(separatedBy: ",")
            let _directors = item.directors?.components(separatedBy: ",")
            let _actors = item.actors?.components(separatedBy: ",")
            
            for _genre in _genres ?? [] {
                genres.insert(_genre)
            }
            for _director in _directors ?? [] {
                directors.insert(_director)
            }
            for _actor in _actors ?? [] {
                actors.insert(_actor)
            }
        }
        
        optionModel.append(MovieListOptionModel(title:MovieCategory.YEAR.rawValue, option: years))
        optionModel.append(MovieListOptionModel(title:MovieCategory.GENERE.rawValue, option: genres))
        optionModel.append(MovieListOptionModel(title:MovieCategory.DIRECTOR.rawValue, option: directors))
        optionModel.append(MovieListOptionModel(title:MovieCategory.ACTOR.rawValue, option: actors))
        
        return optionModel
    }
}
