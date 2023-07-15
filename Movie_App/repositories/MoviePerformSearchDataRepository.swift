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
    
    func fetch(_ completion: @escaping MovieSearchResponseCompletionHandler) {
        
        var movieModel = [MovieModel]()
        
        guard let models = repositoryParam?.movieModel, let searchText = repositoryParam?.searchText else {
            return
        }
        
        for model in models {
            
            if (model.year?.contains(searchText) ?? false) || (model.genre?.contains(searchText) ?? false) || (model.directors?.contains(searchText) ?? false) || (model.actors?.contains(searchText) ?? false){
                movieModel.append(model)
            }
        }
        completion(movieModel,nil)
        
    }
}
