//
//  MovieView.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import Foundation
import UIKit

protocol MovieListViewDelegate: AnyObject {
    func onMovieSelected(model: MovieModel?)
}

class MovieListView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tvMovieList: UITableView!
    @IBOutlet weak var lblNoSearchResult: UILabel!
    
    private var movieModel: [MovieModel]?
    
    weak var delegate: MovieListViewDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    private func commoninit() {
        Bundle.main.loadNibNamed("MovieListView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        setupTableView()
        self.lblNoSearchResult.isHidden = true
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tvMovieList.reloadData()
        }
    }
    
    func setData(_ model: [MovieModel]?) {
        self.movieModel = model
        
        if model?.count == 0 {
            self.lblNoSearchResult.isHidden = false
            self.lblNoSearchResult.text = "No Search Result Found! \n Please try again"
        }else {
            self.lblNoSearchResult.isHidden = true
        }
        self.reloadTableView()
    }
    
    private func setupTableView() {
        self.tvMovieList.delegate = self
        self.tvMovieList.dataSource = self
        self.tvMovieList.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
    }
    
}


extension MovieListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(movie: movieModel?[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.onMovieSelected(model: self.movieModel?[indexPath.row])
    }
    
    
}
