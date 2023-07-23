//
//  MovieListViewController.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit

/**
 *  This class shows the list of the movies when user tap on any movie then it will navigate to MovieDetailViewController.
 */

class MovieListViewController: UIViewController {

    @IBOutlet weak var uvMovieList: UIView!
    private var movieListView: MovieListView?
    
    var items: [SectionItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeMovieListView()
    }
    
    private func initializeMovieListView() {
        self.movieListView = MovieListView(frame: self.uvMovieList.bounds)
        if let _movieListView = self.movieListView {
            _movieListView.delegate = self
            _movieListView.setData(self.items ?? [])
            self.uvMovieList.addSubview(_movieListView)
        }
    }

}

extension MovieListViewController: MovieListViewDelegate {
    func onMovieSelected(item: MovieListItem?) {
        self.navigateToMovieDetailViewController(item: item)
    }
}
