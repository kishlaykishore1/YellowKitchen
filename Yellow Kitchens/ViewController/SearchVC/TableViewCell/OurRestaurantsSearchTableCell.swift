//
//  OurRestaurantsTableCell.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 17/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class OurRestaurantsSearchTableCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var ourRestroCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ourRestroCollectionView.dataSource = self
        ourRestroCollectionView.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension OurRestaurantsSearchTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OurRestaurantsCollectionCell", for: indexPath) as! OurRestaurantsCollectionCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
