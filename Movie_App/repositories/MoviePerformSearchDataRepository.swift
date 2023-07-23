//
//  MoviePerformSearchDataRepository.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import Foundation

class MovieSearchDataRepository: MovieSearchRepository {
    
    private var repositoryParam: MovieRepositoryParam?
    
    init(repositoryParam: MovieRepositoryParam?) {
        self.repositoryParam = repositoryParam
    }
    
    /**
     *  This function send the information of the movie based on the searchText, if search Text is present in the List of the movies then it return those movies
     */
    
    func fetch(_ completion: @escaping MovieSearchResponseCompletionHandler) {
        
        guard let models = repositoryParam?.movieListModel, let searchText = repositoryParam?.searchText else {
            return
        }
        var movieSections = [SectionItem]()
        var movieSubItems = [MovieItem]()
        for model in models {
            if model.isMovieModelContains(searchText) {
                let movieSubItem = MovieListItem(cellReusableIdentifier: MovieConstants().movieListTableViewCell,moviewListModel: model)
                movieSubItems.append(movieSubItem)
            }
        }
        let movieSectionItem = MovieSectionItem(subItems: movieSubItems, sectionTitle: MovieCategory.ALL_MOVIE.rawValue)
        movieSections.append(movieSectionItem)
        completion(movieSections,nil)
        
    }
}
