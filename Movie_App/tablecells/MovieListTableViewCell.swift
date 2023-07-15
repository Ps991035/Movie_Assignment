//
//  MovieListTableViewCell.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgMovie.layer.cornerRadius = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(movie: MovieModel?) {
        
        guard let _movie = movie else {
            return
        }
        if let imageURL = _movie.poster {
            self.imgMovie.sd_setImage(with: URL(string: imageURL),completed: nil)
        }
        
        self.lblMovieYear.text = _movie.year
        self.lblMovieTitle.text = _movie.title
        self.lblMovieLanguage.text = _movie.language
    }
    
}
