//
//  MovieListViewController.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var uvMovieList: UIView!
    
    private var movieListView: MovieListView?
    var movieModel: [MovieModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeMovieListView()
    }
    
    private func initializeMovieListView() {
        self.movieListView = MovieListView(frame: self.uvMovieList.bounds)
        if let _movieListView = self.movieListView {
            _movieListView.delegate = self
            _movieListView.setData(self.movieModel)
            self.uvMovieList.addSubview(_movieListView)
        }
    }

}

extension MovieListViewController: MovieListViewDelegate {
    
    func onMovieSelected(model: MovieModel?) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            vc.movieModel = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
