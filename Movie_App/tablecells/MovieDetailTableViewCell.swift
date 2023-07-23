//
//  MovieDetailTableViewCell.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell, MovieListCellProtocol {
    
    @IBOutlet weak var lblMovieDetailTitle: UILabel!
    @IBOutlet weak var lblMovieDetailValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(item: MovieItem) {
        
        if let _item = item as? MovieDetailItem, let title = _item.movieDetailModel?.title, let value = _item.movieDetailModel?.value {
            self.lblMovieDetailTitle.text = title + " : "
            self.lblMovieDetailValue.text = value
        }
    }
}
