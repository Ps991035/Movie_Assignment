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

/**
 *  The structure of Movie List and Movie List Option is created here. Here We get the details of Movie List through Factory,adapter and repository.
 */

class MovieViewModel {
    
    var adapter: MovieAdapter?
    private var repoFactory: MovieRepoFactory?
    private var movieSectionItems: [SectionItem]?
    private var searchedMovieSectionItems: [SectionItem]?
    private var movieListOptionSectionItem: [SectionItem]?
    private var movieListModel: [MovieListModel]?
    
    weak var delegate: MovieViewModelDelegate?
    
    init(repoFactory: MovieRepoFactory?) {
        self.repoFactory = repoFactory
    }
    
    func fetchData(_ searchText: String?) {
        if searchText == nil || searchText?.count == 0 {
            self.fetchData()
        } else {
            self.fetchSearchData(searchText: searchText)
        }
    }
    
    /**
     *  Get the list of movies and also inform that the response has come through delegate
     */
    
    private func fetchData() {
        self.repoFactory?.getListRepository()?.fetch({ result, error in
            if let _result = result {
                self.setData(result: _result)
            }
            self.delegate?.onDataFetched()
        
        })
    }
    
    /**
     * @param searchText    Filter the movies based upon on this.
     *  This function get the list of movies based upon the search text
     */
    
    private func fetchSearchData(searchText: String?) {
        let repoParam = MovieRepositoryParam(searchText: searchText, movieListModel: movieListModel)
        
        let searchRepository = repoFactory?.getSearchListRepository(repositoryParam: repoParam)
        searchRepository?.fetch({ result, error in
            
            if let _result = result {
                self.searchedMovieSectionItems = _result
            }
        })
    }
    
    /**
     * @param result   List of Movies
     *  This function set the movieSectionItems and movieListOptionSectionItem
     */
    
    private func setData(result: [MovieListModel]?) {
        
        self.movieListModel = result
        self.movieSectionItems = (self.adapter as? MovieListDataAdapter)?.getData(result: result)
        
        self.movieListOptionSectionItem = (self.adapter as? MovieDataAdapter)?.getData(result: result)
    }
    
    func getMovieListOptionSectionItems() ->[SectionItem]? {
        return self.movieListOptionSectionItem
    }
    
    func getSearchedMovieSectionItem() -> [SectionItem]? {
        return self.searchedMovieSectionItems
    }
    
    func getMovieListOptionCount() -> Int {
        return self.movieListOptionSectionItem?.count ?? 0
    }
    
    func getMovieListOption(section: Int) -> SectionItem? {
        return self.movieListOptionSectionItem?[section]
    }
    
    func getMovieOptionTitle(indexPath: IndexPath) -> String? {
        return self.movieListOptionSectionItem?[indexPath.section].sectionTitle
    }
    
    /**
     * @param indexPath   IndexPath of the selected Movie Option
     *  This function returns the MovieList Item from All Movie Option any movie is selected from all movie option
     */
    
    func getMovieListItem(indexPath: IndexPath?) -> MovieListItem? {
        guard let _indexPath = indexPath else {
            return nil
        }
        let movieCategorySection = getMovieListOption(section: _indexPath.section)
        return movieCategorySection?.subItems[_indexPath.row] as? MovieListItem
    }
    
    /**
     * @param indexPath   IndexPath of the selected Movie Option
     *  This function returns the filtered movie list based upon the selected movie option
     */
    
    func getFilterdMovieBasedOnSelectedOption(indexPath: IndexPath?) -> [SectionItem]? {
        
        guard let _indexPath = indexPath else {
            return nil
        }
        
        var movieSections = [SectionItem]()
        var movieSubItems = [MovieItem]()
        
        let movieCategorySection = getMovieListOption(section: _indexPath.section)
        let selectedCategoryType = (movieCategorySection?.subItems[_indexPath.row] as? MovieListOptionItem)?.label ?? ""
        
        for model in self.movieListModel ?? [] {
            
            if movieCategorySection?.sectionTitle == MovieCategory.YEAR.rawValue {
                if model.year?.contains(selectedCategoryType) ?? false {
                    let movieSubItem = MovieListItem(cellReusableIdentifier: MovieConstants().movieListTableViewCell,moviewListModel: model)
                    movieSubItems.append(movieSubItem)
                }
            }else if movieCategorySection?.sectionTitle == MovieCategory.GENERE.rawValue {
                if model.genre?.contains(selectedCategoryType) ?? false {
                    let movieSubItem = MovieListItem(cellReusableIdentifier: MovieConstants().movieListTableViewCell,moviewListModel: model)
                    movieSubItems.append(movieSubItem)
                }
            }else if movieCategorySection?.sectionTitle == MovieCategory.DIRECTOR.rawValue {
                if model.directors?.contains(selectedCategoryType) ?? false {
                    let movieSubItem = MovieListItem(cellReusableIdentifier: MovieConstants().movieListTableViewCell,moviewListModel: model)
                    movieSubItems.append(movieSubItem)
                }
            }else if movieCategorySection?.sectionTitle == MovieCategory.ACTOR.rawValue {
                if model.actors?.contains(selectedCategoryType) ?? false {
                    let movieSubItem = MovieListItem(cellReusableIdentifier: MovieConstants().movieListTableViewCell,moviewListModel: model)
                    movieSubItems.append(movieSubItem)
                }
            }
        }
        let movieSectionItem = MovieSectionItem(subItems: movieSubItems, sectionTitle: MovieCategory.ALL_MOVIE.rawValue)
        movieSections.append(movieSectionItem)
        return movieSections
    }
    
}
