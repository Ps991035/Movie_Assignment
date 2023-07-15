//
//  MovieDetailViewController.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    var movieModel: MovieModel?
    var movieDetailTitles = [[AnyHashable:Any]]()
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblRatingValue: UILabel!
    @IBOutlet weak var tvMovieDetails: UITableView!
    @IBOutlet weak var collectionViewRatings: UICollectionView!
    
    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
    }
    
    private func setupUI() {
        self.setupTableView()
        self.setupCollectionView()
        self.imgMovie.layer.cornerRadius = 6
        self.lblRatingValue.isHidden = true
    }
    
    private func setupCollectionView() {
        self.collectionViewRatings.delegate = self
        self.collectionViewRatings.dataSource = self
        self.collectionViewRatings.register(UINib(nibName: "MovieRatingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieRatingCollectionViewCell")
    }
    
    private func setupTableView() {
        self.tvMovieDetails.delegate = self
        self.tvMovieDetails.dataSource = self
        self.tvMovieDetails.register(UINib(nibName: "MovieDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDetailTableViewCell")
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tvMovieDetails.reloadData()
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionViewRatings.reloadData()
        }
    }
    
    private func setRatingValue() {
        self.lblRatingValue.isHidden = false
        self.lblRatingValue.text = self.movieModel?.ratings?[selectedIndexPath?.row ?? 0].value
    }
    
    private func setData() {
        guard let _movie = movieModel else {
            return
        }
        if let imageURL = _movie.poster {
            self.imgMovie.sd_setImage(with: URL(string: imageURL),completed: nil)
        }
        self.movieDetailTitles = [
            ["Title": _movie.title ?? ""],
            ["Plot": _movie.plot ?? ""],
            ["Cast & Crew": (_movie.directors ?? "") + (_movie.actors ?? "")],
            ["Released Date": _movie.releaseDate ?? ""],
            ["Genre": _movie.genre ?? ""]
        ]
    }

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetailTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as? MovieDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let model = movieDetailTitles[indexPath.row]
        
        if let _key = model.keys.first as? String,let value = model.first?.value as? String {
            cell.setData(title: _key, value: value)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieModel?.ratings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieRatingCollectionViewCell", for: indexPath) as? MovieRatingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setRatingSource(title: self.movieModel?.ratings?[indexPath.row].source, isSelected: indexPath == selectedIndexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.setRatingValue()
        self.reloadCollectionView()
    }
    
    
}
