//
//  OurRestaurantsTableCell.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 10/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//
import UIKit
class OurRestaurantsTableCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
