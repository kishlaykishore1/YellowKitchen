//
//  RecommendedProductsTableCell.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 10/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class RecommendedProductsTableCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var recProductCollectionView: UICollectionView!
    var data = [DataIsExpendable(isExpendable: false), DataIsExpendable(isExpendable: false), DataIsExpendable(isExpendable: false), DataIsExpendable(isExpendable: false), DataIsExpendable(isExpendable: false)]
    override func awakeFromNib() {
        super.awakeFromNib()
        recProductCollectionView.delegate = self
        recProductCollectionView.dataSource = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
// MARK: - CollectionView DataSource
extension RecommendedProductsTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedProductsCollectionCell", for: indexPath) as! RecommendedProductsCollectionCell
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(favTap(sender:)), for: .touchUpInside)
        if data[indexPath.row].isExpendable {
            cell.btnFav.setImage(#imageLiteral(resourceName: "heartFill"), for: .normal)
        } else {
            cell.btnFav.setImage(#imageLiteral(resourceName: "favUnFill"), for: .normal)
        }
        return cell
    }
    @objc func favTap(sender: UIButton) {
        data[sender.tag].isExpendable = !( data[sender.tag].isExpendable)
        recProductCollectionView.reloadData()
    }
}
// MARK: - CollectionView Delegate
extension RecommendedProductsTableCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
    // MARK: - CollectionView DelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width / 1.5, height: collectionView.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee.x = scrollView.contentOffset.x
        let pageWidth = scrollView.frame.width
        let newPageWidth : CGFloat = (pageWidth / 1.50)
        var assistanceOffset : CGFloat = (pageWidth / 1.50)
        if velocity.x < 0 {
            assistanceOffset = -assistanceOffset
        }
        print(assistanceOffset)
        let assistedScrollPosition = (scrollView.contentOffset.x) / newPageWidth
        var targetIndex = Int(round(assistedScrollPosition))
        if targetIndex < 0 {
            targetIndex = 0
        } else if targetIndex >= recProductCollectionView.numberOfItems(inSection: 0) {
            targetIndex = recProductCollectionView.numberOfItems(inSection: 0) - 1
        }
        let indexPath = NSIndexPath(item: targetIndex, section: 0)
        recProductCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
    }
}
class DataIsExpendable {
    var isExpendable: Bool = false
    init(isExpendable: Bool) {
        self.isExpendable = isExpendable
    }
}
