//
//  MovieRatingCollectionViewCell.swift
//  Movie_App
//
//  Created by PRITESH SINGH on 15/07/23.
//

import UIKit

class MovieRatingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblRatingSource: UILabel!
    
    @IBOutlet weak var uvContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupShadow()
    }
    
    private func setupShadow() {
        self.uvContent.layer.cornerRadius = 8
        self.uvContent.layer.shadowColor = UIColor.black.cgColor
        self.uvContent.layer.shadowOpacity = 0.2
        self.uvContent.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.uvContent.layer.shadowRadius = 3
        self.uvContent.layer.masksToBounds = false
    }
    
    func setRatingSource(title: String?, isSelected: Bool){
        
        if isSelected {
            self.uvContent.backgroundColor = .systemGreen
        }else{
            self.uvContent.backgroundColor = .lightGray
        }
        self.lblRatingSource.text = title
    }

}
