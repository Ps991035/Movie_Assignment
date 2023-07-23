//
//  MovieAdapter.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

protocol MovieAdapter {
    func getData(result: [MovieListModel]?) -> [SectionItem]?
}

