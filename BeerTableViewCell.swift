//
//  BeerTableViewCell.swift
//  
//
//  Created by Conor Nolan on 30/07/2020.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet private weak var beerImageView: BeerImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var abvLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with beer: BeersResponseElement) {
        nameLabel.text = beer.name ?? "No name specified"
        abvLabel.text = "No abv specified."
        
        if let imageUrlString = beer.imageURL, let imageUrl = URL(string: imageUrlString) {
            beerImageView.loadImage(from: imageUrl)
        }
        
        if let abv = beer.abv {
            abvLabel.text = "\(abv)%"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
