//
//  OurSpecialtiesTableCell.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 10/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class OurSpecialtiesTableCell: UITableViewCell {
    @IBOutlet weak var ourSpecialtiesCollectionView: UICollectionView!
    var OurspecialtiesImages =  [#imageLiteral(resourceName: "salad"), #imageLiteral(resourceName: "vaggie"), #imageLiteral(resourceName: "french-fries"), #imageLiteral(resourceName: "chicken"),#imageLiteral(resourceName: "salad"), #imageLiteral(resourceName: "vaggie"), #imageLiteral(resourceName: "french-fries"), #imageLiteral(resourceName: "chicken")]
    var OurspecialtiesColor = [#colorLiteral(red: 0.7764705882, green: 0.8862745098, blue: 1, alpha: 1), #colorLiteral(red: 0.768627451, green: 0.9019607843, blue: 0.6235294118, alpha: 1), #colorLiteral(red: 1, green: 0.9647058824, blue: 0.5411764706, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.8901960784, blue: 0.6, alpha: 1),#colorLiteral(red: 0.7764705882, green: 0.8862745098, blue: 1, alpha: 1), #colorLiteral(red: 0.768627451, green: 0.9019607843, blue: 0.6235294118, alpha: 1), #colorLiteral(red: 1, green: 0.9647058824, blue: 0.5411764706, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.8901960784, blue: 0.6, alpha: 1)]
    var OurspecialtiesName = ["Poké ball", "Veggie", "Frites", "Poulet","Poké ball", "Veggie", "Frites", "Poulet"]
    override func awakeFromNib() {
        super.awakeFromNib()
        ourSpecialtiesCollectionView.delegate = self
        ourSpecialtiesCollectionView.dataSource = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension OurSpecialtiesTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OurspecialtiesImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OurSpecialtiesCollectionCell", for: indexPath) as! OurSpecialtiesCollectionCell
        DispatchQueue.main.async {
            cell.roundView.layer.cornerRadius = cell.roundView.bounds.height/2
        }
        cell.roundView.backgroundColor = OurspecialtiesColor[indexPath.row]
        cell.imgView.image = OurspecialtiesImages[indexPath.row]
        cell.lblName.text = OurspecialtiesName[indexPath.row]
        return cell
    }
}
extension OurSpecialtiesTableCell: UICollectionViewDelegate {
}
extension OurSpecialtiesTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = ourSpecialtiesCollectionView.bounds.width
        return CGSize(width: collectionWidth/4.3  ,height: collectionWidth/4.3)
    }
}
