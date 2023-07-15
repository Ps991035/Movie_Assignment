//
//  MovieCategoryTableViewCell.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit

class MovieCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMovieCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ title: String?) {
        self.lblMovieCategory.text = title
    }
    
}
