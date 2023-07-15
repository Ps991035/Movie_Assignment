//
//  MovieDataRepository.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 14/07/23.
//

import Foundation

class MovieDataRepository: MovieRepository {
    
    init() { }
    
    func fetch(_ completion: @escaping MovieResponseCompletionHandler) {
        
        if let url = Bundle.main.url(forResource: "Data", withExtension: "json"){
            
            do{
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let result = object as? [Any]{
                    completion(result, nil)
                }else{
                    completion(nil, "Error has Occured")
                }
            }
            catch {
                completion(nil, "Error has Occured")
            }
        }
        
    }
}
