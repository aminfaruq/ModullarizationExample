//
//  TableCell.swift
//  HomeModule
//
//  Created by Amin faruq on 26/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    
    @IBOutlet weak var imgMovie: UIImageView!
    
    @IBOutlet weak var lbSubview: UILabel!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbRating: UILabel!
    
    @IBOutlet weak var lbOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgMovie.layer.cornerRadius = self.imgMovie.frame.size.width / 2
        self.imgMovie.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
