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
    
    /**
     *  This view have the list of movies
     */
    private var movieListView: MovieListView?
    
    private lazy var viewModel: MovieViewModel? = {
        let viewModel = MovieViewModel(repoFactory: MovieRepoFactory())
        viewModel.delegate = self
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showLoader(show: true)
        self.viewModel?.adapter = MovieDataAdapter(movieListDataAdapter: MovieListDataAdapter())
        self.viewModel?.fetchData(nil)
    }
    
    private func setupUI() {
        setupSearchBarUI()
        initializeMovieListView()
    }
    
    /**
     * @param show  show and hide the loader
     *  This function shows and hide the loader based upon the show parameter
     */
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
        searchBar.placeholder = MovieConstants().searchBarTitle
    }
    
    private func setupTableView() {
        
        self.tvMovieCategory.delegate = self
        self.tvMovieCategory.dataSource = self
        
        for item in viewModel?.getMovieListOptionSectionItems() ?? [] {
            for subItem in item.subItems {
                self.tvMovieCategory.register(UINib(nibName: subItem.cellReusableIdentifier, bundle: nil), forCellReuseIdentifier: subItem.cellReusableIdentifier)
            }
        }
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
        self.viewModel?.adapter = MovieListDataAdapter()
        self.viewModel?.fetchData(searchBar.text)
        self.uvMovie.isHidden = false
        self.movieListView?.setData(self.viewModel?.getSearchedMovieSectionItem() ?? [])
        self.searchBar.endEditing(true)
        
    }
}

extension MovieViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.getMovieListOptionCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = viewModel?.getMovieListOption(section: section)
        if let _section = section {
            return _section.isExpanded ?? false ? _section.subItems.count : 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = .clear
        
        let movieListOption = viewModel?.getMovieListOption(section: section)
        
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.frame.width - 32, height: headerView.frame.height))
        titleLabel.text = movieListOption?.sectionTitle
        titleLabel.textColor = .red
        headerView.addSubview(titleLabel)
        
        let imageView = UIImageView(frame: CGRect(x: headerView.frame.width - 36, y: 14, width: 16, height: 16))
        imageView.backgroundColor = .clear
        
        if movieListOption?.isExpanded ?? false {
            imageView.image = UIImage(systemName: MovieConstants().chevronUp)
            imageView.tintColor = .lightGray
        }else {
            imageView.image = UIImage(systemName: MovieConstants().chevronDown)
            imageView.tintColor = .lightGray
        }
        headerView.addSubview(imageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSection(_:)))
        headerView.addGestureRecognizer(tapGesture)
        headerView.tag = section
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section >= viewModel?.getMovieListOptionCount() ?? 0) {
            return UITableViewCell()
        }
        let section = viewModel?.getMovieListOption(section: indexPath.section)
        
        guard let item = section?.subItems[indexPath.row] else {
            return UITableViewCell()
        }
        
        if indexPath.row < section?.subItems.count ?? 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellReusableIdentifier) as? MovieListCellProtocol {
                cell.configureCell(item: item)
                return cell as? UITableViewCell ?? UITableViewCell()
            }
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _item = self.viewModel?.getMovieListItem(indexPath: indexPath) {
            self.navigateToMovieDetailViewController(item: _item)
        }else if let _items = self.viewModel?.getFilterdMovieBasedOnSelectedOption(indexPath: indexPath) {
            self.navigateToMovieListViewController(items: _items)
        }
    }
    
    @objc func toggleSection(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        viewModel?.getMovieListOption(section: section)?.isExpanded?.toggle()
        self.tvMovieCategory.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}

extension MovieViewController: MovieListViewDelegate {
    
    func onMovieSelected(item: MovieListItem?) {
        self.navigateToMovieDetailViewController(item: item)
    }
}

extension MovieViewController: MovieViewModelDelegate {
    func onDataFetched() {
        self.setupTableView()
        self.showLoader(show: false)
    }
}
