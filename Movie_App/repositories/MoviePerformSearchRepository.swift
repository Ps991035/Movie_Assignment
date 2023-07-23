//
//  MoviePerformSearchRepository.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import Foundation

typealias MovieSearchResponseCompletionHandler = (_ result: [SectionItem]?, _ error: String?) -> Void

protocol MovieSearchRepository {
    func fetch(_ completion: @escaping MovieSearchResponseCompletionHandler)
}
