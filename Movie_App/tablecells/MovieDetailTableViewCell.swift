//
//  MovieDetailTableViewCell.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    
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
    
    func setData(title: String?, value: String?) {
        self.lblMovieDetailTitle.text = (title ?? "") + " : "
        self.lblMovieDetailValue.text = value
    }
    
}
