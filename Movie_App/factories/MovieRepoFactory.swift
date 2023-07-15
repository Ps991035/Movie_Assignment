//
//  MovieFactory.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

class MovieRepoFactory {
    
    func getListRepository() -> MovieRepository? {
        return MovieDataRepository()
    }
    
    func getSearchListRepository(repositoryParam: MovieRepositoryParam?) -> MovieSearchRepository? {
            return MovieSearchDataRepository(repositoryParam: repositoryParam)
    }
    
}
