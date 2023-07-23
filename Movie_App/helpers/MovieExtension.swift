//
//  MovieExtension.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 22/07/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
     *  @param item     Movie item
     *  This function navigate to movie detail viewcontroller if user select any movie
     */
    
    func navigateToMovieDetailViewController(item: MovieListItem?) {
        
        if let viewController = UIStoryboard(name: MovieConstants().main, bundle: nil).instantiateViewController(withIdentifier: MovieConstants().movieDetailViewController) as? MovieDetailViewController {
            viewController.movieModel = item?.moviewListModel
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    /**
     *  @param items     List of the section items
     *  This function navigate to movie List viewcontroller if user select any movie List Option
     */
    
    func navigateToMovieListViewController(items: [SectionItem]?) {
        
        if let viewController = UIStoryboard(name: MovieConstants().main, bundle: nil).instantiateViewController(withIdentifier: MovieConstants().movieListViewController) as? MovieListViewController {
            viewController.items = items
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
