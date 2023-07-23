//
//  MovieCategoryTableViewCell.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit

class MovieCategoryTableViewCell: UITableViewCell, MovieListCellProtocol {
    
    @IBOutlet weak var lblMovieCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(item: MovieItem) {
        if let _item = item as? MovieListOptionItem {
            self.lblMovieCategory.text = _item.label
        }
    }
}
