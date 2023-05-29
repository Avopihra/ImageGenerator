//
//  FavoriteCell.swift
//  ImageGenerator
//
//  Created by Viktoriya on 28.05.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {
 
    @IBOutlet weak var favoriteImage: UIImageView?
    @IBOutlet weak var requestLabel: UILabel?

    //MARK: - Lyfe Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        requestLabel?.textColor = .darkGray
    }
    
    //MARK: - Content Setup Method

    func setCellContent(data: Data, text: String) {
        self.favoriteImage?.image = UIImage(data: data)
        self.requestLabel?.text = text
    }
}
