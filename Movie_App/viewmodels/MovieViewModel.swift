//
//  MovieViewModel.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func onDataFetched()
}

class MovieViewModel {
    
    private var adapter: MovieAdapter?
    
    private var movieCategorySection: [MovieCategorySection]?
    private var repoFactory: MovieRepoFactory?
    private var movieModel: [MovieModel]?
    private var searchedMovieModel: [MovieModel]?
    
    weak var delegate: MovieViewModelDelegate?
    
    init(repoFactory: MovieRepoFactory?, adapter: MovieAdapter?) {
        self.repoFactory = repoFactory
        self.adapter = adapter
    }
    
    func fetchData(_ searchText: String?) {
        if searchText == nil || searchText?.count == 0 {
            self.fetchData()
        } else {
            self.fetchSearchData(searchText: searchText)
        }
    }
    
    private func fetchData() {
        self.repoFactory?.getListRepository()?.fetch({ result, error in
            self.delegate?.onDataFetched()
            if let _result = result {
                self.setData(result: _result)
            }
        })
    }
    
    private func fetchSearchData(searchText: String?) {
        let repoParam = MovieRepositoryParam(searchText: searchText, movieModel: self.movieModel)
        let searchRepository = repoFactory?.getSearchListRepository(repositoryParam: repoParam)
        searchRepository?.fetch({ result, error in
            self.delegate?.onDataFetched()
            
            if let _result = result {
                self.searchedMovieModel = _result
            }
        })
    }
    
    func setData(result: [Any]) {
        self.movieModel = self.adapter?.getData(result: result) ?? []
        self.setMovieCategoryModel()
    }
    
    func getSearchedMovieModel() -> [MovieModel]? {
        return self.searchedMovieModel
    }
    
    private func setMovieCategoryModel() {
        
        var year = Set<String>()
        var genre = Set<String>()
        var directors = Set<String>()
        var actors = Set<String>()
        
        for movie in self.movieModel ?? [] {
            
            year.insert(movie.year ?? "")
            
            let _genres = movie.genre?.components(separatedBy: ",")
            let _directors = movie.directors?.components(separatedBy: ",")
            let _actors = movie.actors?.components(separatedBy: ",")
            
            for _genre in _genres ?? [] {
                genre.insert(_genre)
            }
            
            for _director in _directors ?? [] {
                directors.insert(_director)
            }
            
            for _actor in _actors ?? [] {
                actors.insert(_actor)
            }
        }
        
        let movieCategorySection: [MovieCategorySection] = [
            
            MovieCategorySection(title: "Year", rows: Array(year), isExpanded: false),
            
            MovieCategorySection(title: "Genre", rows: Array(genre), isExpanded: false),
            
            MovieCategorySection(title: "Directors", rows: Array(directors), isExpanded: false),
            
            MovieCategorySection(title: "Actors", rows: Array(actors), isExpanded: false)
        ]
        
        self.movieCategorySection = movieCategorySection
    }
    
    func getMovieCategorySection() -> Int {
        return self.movieCategorySection?.count ?? 0
    }
    
    func getMovieCategorySection(section: Int) -> MovieCategorySection? {
        return self.movieCategorySection?[section]
    }
    
    func getMovieCategoryRowTitle(indexPath: IndexPath) -> String? {
        return self.movieCategorySection?[indexPath.section].rows?[indexPath.row]
    }
    
    func getFilterdMovieBasedOnCategory(indexPath: IndexPath?) -> [MovieModel]? {
        
        var movieModel = [MovieModel]()
        
        guard let _indexPath = indexPath else {
            return nil
        }
        
        let movieCategorySection = getMovieCategorySection(section: _indexPath.section)
        let selectedCategoryType = movieCategorySection?.rows?[_indexPath.row] ?? ""
        
        for movie in self.movieModel ?? [] {
            
            if movieCategorySection?.title == "Year" {
                
                if movie.year?.contains(selectedCategoryType) ?? false {
                    movieModel.append(movie)
                }
            }else if movieCategorySection?.title == "Genre" {
                
                if movie.genre?.contains(selectedCategoryType) ?? false {
                    movieModel.append(movie)
                }
            }else if movieCategorySection?.title == "Directors" {
                
                if movie.directors?.contains(selectedCategoryType) ?? false {
                    movieModel.append(movie)
                }
            }else if movieCategorySection?.title == "Actors" {
                
                if movie.actors?.contains(selectedCategoryType) ?? false {
                    movieModel.append(movie)
                }
            }
            
        }
        return movieModel
    }
    
}
