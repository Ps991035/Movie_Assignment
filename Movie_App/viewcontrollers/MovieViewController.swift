//
//  ViewController.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var uvSearchBar: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var uvMovie: UIView!
    @IBOutlet weak var uvMovieCategory: UIView!
    @IBOutlet weak var tvMovieCategory: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    private var movieListView: MovieListView?
    
    private lazy var viewModel: MovieViewModel? = {
        let viewModel = MovieViewModel(repoFactory: MovieRepoFactory(), adapter: MovieDataAdapter())
        viewModel.delegate = self
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showLoader(show: true)
        self.viewModel?.fetchData(nil)
    }
    
    private func setupUI() {
        setupSearchBarUI()
        setupTableView()
        initializeMovieListView()
    }
    
    private func showLoader(show: Bool){
        DispatchQueue.main.async {
            
            if show {
                self.loader.isHidden = false
                self.loader.startAnimating()
            }else{
                self.loader.isHidden = true
                self.loader.stopAnimating()
            }
            
        }
    }
    
    private func setupSearchBarUI() {
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.placeholder = "Search movies by title/actor/genre/director"
    }
    
    private func setupTableView() {
        self.tvMovieCategory.delegate = self
        self.tvMovieCategory.dataSource = self
        self.tvMovieCategory.register(UINib(nibName: "MovieCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCategoryTableViewCell")
    }
    
    private func initializeMovieListView() {
        self.movieListView = MovieListView(frame: self.uvMovie.bounds)
        if let _movieListView = self.movieListView {
            _movieListView.delegate = self
            self.uvMovie.addSubview(_movieListView)
        }
    }
    
}

extension MovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            self.uvMovieCategory.isHidden = true
        }else {
            self.uvMovieCategory.isHidden = false
            self.uvMovie.isHidden = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.fetchData(searchBar.text)
        self.uvMovie.isHidden = false
        self.movieListView?.setData(self.viewModel?.getSearchedMovieModel())
        self.searchBar.endEditing(true)
        
    }
    
}

extension MovieViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getMovieCategorySection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = viewModel?.getMovieCategorySection(section: section)
        
        if let _section = section {
            return _section.isExpanded ? _section.rows?.count ?? 0 : 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = .clear
        
        let movieCategorySection = viewModel?.getMovieCategorySection(section: section)
        
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.frame.width - 32, height: headerView.frame.height))
        titleLabel.text = movieCategorySection?.title
        titleLabel.textColor = .red
        headerView.addSubview(titleLabel)
        
        let imageView = UIImageView(frame: CGRect(x: headerView.frame.width - 36, y: 14, width: 16, height: 16))
        imageView.backgroundColor = .clear
        
        if movieCategorySection?.isExpanded ?? false {
            imageView.image = UIImage(systemName: "chevron.compact.up")
            imageView.tintColor = .lightGray
        }else {
            imageView.image = UIImage(systemName: "chevron.compact.down")
            imageView.tintColor = .lightGray
        }
        headerView.addSubview(imageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.tag = section
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCategoryTableViewCell", for: indexPath) as? MovieCategoryTableViewCell else {
            return UITableViewCell()
        }
        
        let section = viewModel?.getMovieCategorySection(section: indexPath.section)
        let row = section?.rows?[indexPath.row]
        cell.setData(row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController {
            
            vc.movieModel  = self.viewModel?.getFilterdMovieBasedOnCategory(indexPath: indexPath)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @objc func toggleSection(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        viewModel?.getMovieCategorySection(section: section)?.isExpanded.toggle()
        self.tvMovieCategory.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

extension MovieViewController: MovieListViewDelegate {
    
    func onMovieSelected(model: MovieModel?) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            
            vc.movieModel = model
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension MovieViewController: MovieViewModelDelegate {
    func onDataFetched() {
        self.showLoader(show: false)
    }
}
