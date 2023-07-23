//
//  MovieDetailViewController.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit
import SDWebImage

/**
 *   This class shows all the details of the selected movie, and also handle the rating of the movie user can tap of any option of the given rating type and based upon that rating will be shown.
 */

class MovieDetailViewController: UIViewController {
    
    var movieModel: MovieListModel?
    var movieDetailTitles = [[AnyHashable:Any]]()
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblRatingValue: UILabel!
    @IBOutlet weak var tvMovieDetails: UITableView!
    @IBOutlet weak var collectionViewRatings: UICollectionView!
    
    private var selectedIndexPath: IndexPath?
    
    private var movieItems: [MovieItem] = []
    
    private lazy var viewModel: MovieDetailViewModel? = {
        let viewModel = MovieDetailViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupUI()
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
        self.collectionViewRatings.register(UINib(nibName: MovieConstants().movieRatingCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: MovieConstants().movieRatingCollectionViewCell)
    }
    
    private func setupTableView() {
        
        self.tvMovieDetails.delegate = self
        self.tvMovieDetails.dataSource = self
        
        for item in movieItems {
            self.tvMovieDetails.register(UINib(nibName: item.cellReusableIdentifier, bundle: nil), forCellReuseIdentifier: item.cellReusableIdentifier)
        }
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
        self.movieItems = self.viewModel?.getMovieDetailItem(_movie) ?? []
    }
    
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = movieItems[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellReusableIdentifier) as? MovieListCellProtocol {
            cell.configureCell(item: item)
            return cell as? UITableViewCell ?? UITableViewCell()
        }
        return UITableViewCell()
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
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieConstants().movieRatingCollectionViewCell, for: indexPath) as? MovieRatingCollectionViewCell else {
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
