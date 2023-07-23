//
//  MovieRepository.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

typealias MovieResponseCompletionHandler = (_ result: [MovieListModel]?, _ error: String?) -> Void

protocol MovieRepository {
    func fetch(_ completion: @escaping MovieResponseCompletionHandler)
}
