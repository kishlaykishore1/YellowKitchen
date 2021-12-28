//
//  InTheNewsTableCell.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 10/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class InTheNewsTableCell: UITableViewCell {
    @IBOutlet weak var inTheNewCollectionView: UICollectionView!
    var home = HomeVC()
    var arrImage = [ #imageLiteral(resourceName: "OurRestaurants"), #imageLiteral(resourceName: "burger1"), #imageLiteral(resourceName: "OurRestaurants"), #imageLiteral(resourceName: "burger1")]
    override func awakeFromNib() {
        super.awakeFromNib()
        inTheNewCollectionView.dataSource = self
        inTheNewCollectionView.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension InTheNewsTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InTheNewsCollectionCell", for: indexPath) as! InTheNewsCollectionCell
        cell.imgView.image = arrImage[indexPath.row]
        return cell
    }
}
extension InTheNewsTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let controller = StoryBoard.Home.instantiateViewController(withIdentifier: "RestaurantVC") as! RestaurantVC
        //        home.navigationController?.pushViewController(controller, animated: true)
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "RestaurantVC") as! RestaurantVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        if #available(iOS 13.0, *) {
            aboutVC.isModalInPresentation = true
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        rootNavView.modalPresentationStyle = .fullScreen
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}
