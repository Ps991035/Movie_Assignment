//
//  MovieView.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import Foundation
import UIKit

protocol MovieListViewDelegate: AnyObject {
    func onMovieSelected(item: MovieListItem?)
}

/**
 *  This class shows all the List of the movies
 */

class MovieListView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tvMovieList: UITableView!
    @IBOutlet weak var lblNoSearchResult: UILabel!
    
    weak var delegate: MovieListViewDelegate?
    
    private var items: [SectionItem] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commoninit()
    }
    
    private func commoninit() {
        Bundle.main.loadNibNamed(MovieConstants().movieListView, owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        setupTableView()
        self.lblNoSearchResult.isHidden = true
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.setupTableView()
            self.tvMovieList.reloadData()
        }
    }
    
    func setData(_ items: [SectionItem]) {
        self.items = items
        if items.first?.subItems.count == 0 {
            self.lblNoSearchResult.isHidden = false
            self.lblNoSearchResult.text = MovieConstants().noSearchResultFoundText
        }else {
            self.lblNoSearchResult.isHidden = true
        }
        self.reloadTableView()
    }
    
    func setupTableView() {
        
        self.tvMovieList.delegate = self
        self.tvMovieList.dataSource = self
        
        for item in items {
            for subItem in item.subItems {
                self.tvMovieList.register(UINib(nibName: subItem.cellReusableIdentifier, bundle: nil), forCellReuseIdentifier: subItem.cellReusableIdentifier)
            }
        }
    }
}

extension MovieListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items[section].subItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section >= items.count ) {
            return UITableViewCell()
        }
        
        let section = items[indexPath.section]
        let item = section.subItems[indexPath.row]
        
        if indexPath.row < section.subItems.count {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellReusableIdentifier) as? MovieListCellProtocol {
                cell.configureCell(item: item)
                return cell as? UITableViewCell ?? UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = items[indexPath.section]
        let item = section.subItems[indexPath.row]
        self.delegate?.onMovieSelected(item: item as? MovieListItem)
    }
}
