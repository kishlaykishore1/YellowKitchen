//
//  TypeOfDishesTableCell.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 17/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class TypeOfDishesTableCell: UITableViewCell {
    @IBOutlet weak var typeOfDishCollection: UICollectionView!
    var arrDish = ["Entrées", "Plats", "Desserts", "Boissons"]
    override func awakeFromNib() {
        super.awakeFromNib()
        typeOfDishCollection.dataSource = self
        typeOfDishCollection.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension TypeOfDishesTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDish.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeOfDishesCollectionCell", for: indexPath) as! TypeOfDishesCollectionCell
        cell.lblName.text = arrDish[indexPath.row]
        return cell
    }
}
// MARK: - CollectionView Flowlayout
extension TypeOfDishesTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionView = typeOfDishCollection.bounds.size
        let size = (arrDish[indexPath.row]).size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
        ])
        return CGSize(width: size.width + 45, height: collectionView.height)
    }
}
