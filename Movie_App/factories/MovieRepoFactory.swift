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
    
    /**
     * @param repositoryParam    This contains the parameters that are used in to retuurn the data from the repositories
     *  This function return the repository which will return the movie list based on searchText
     */
    
    func getSearchListRepository(repositoryParam: MovieRepositoryParam?) -> MovieSearchRepository? {
            return MovieSearchDataRepository(repositoryParam: repositoryParam)
    }
    
}
