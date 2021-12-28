//
//  HomeVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 09/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import SPStorkController
import FittedSheets

class HomeVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var navCollection: UICollectionView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var section0Footer: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    // MARK: - properties
    var selectedIndex: Int?
    var arrImages = [#imageLiteral(resourceName: "HomeSliderPic"), #imageLiteral(resourceName: "HomeSliderPic"), #imageLiteral(resourceName: "HomeSliderPic")]
    var arrDelivery = ["Livraison 30min", "À emporter 10min"]
    var arrSectionLastImages = [#imageLiteral(resourceName: "OurRestaurants"), #imageLiteral(resourceName: "OurRestaurants1"), #imageLiteral(resourceName: "OurRestaurants"), #imageLiteral(resourceName: "OurRestaurants1")]
    var arrSectionLastTitle = ["Fish’n Co", "Believe", "Fish’n Co", "Believe"]
    var arrSectionLastSubTitle = ["La carte de Fish’n Co est un véritable condensé de gourmandises. Après une entrée consistante, laissez vous séduire par l’une des spécialités du chef.", "Believe, le restaurant veggie oeuvre pour préparer de savoureux plats végétariens ou vegan ! Après une entrée froide ou chaude, laissez vous tenter par une sélection de plats aux notes fraîches et acidulées.", "La carte de Fish’n Co est un véritable condensé de gourmandises. Après une entrée consistante, laissez vous séduire par l’une des spécialités du chef.", "Believe, le restaurant veggie oeuvre pour préparer de savoureux plats végétariens ou vegan ! Après une entrée froide ou chaude, laissez vous tenter par une sélection de plats aux notes fraîches et acidulées."]
    var editText = ""
    var isEdit: Bool = false
    var x = 1
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: 0)
        searchBar.setImage(#imageLiteral(resourceName: "Search"), for: .search, state: .normal)
        self.navigationController?.navigationBar.isHidden = true
        headerConfiguration()
        startTimer()
        self.pageControl.numberOfPages = self.arrImages.count
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGestureRecognizer)
        DispatchQueue.main.async {
            self.searchBar.isTranslucent = true
            self.searchBar.searchTextField.backgroundColor = UIColor.clear
            self.searchBar.searchTextField.borderStyle = .none
            self.searchView.layer.cornerRadius = self.searchView.bounds.height / 2
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}
// MARK: - Action Method
extension HomeVC {
    @IBAction func action_PageControl(_ sender: UIPageControl) {
        //  pageControl.currentPage = arrImages.count
    }
    @IBAction func action_Search(_ sender: UIControl) {
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    @IBAction func action_OpenAddressSheet(_ sender: UIControl) {
        chooseAddress()
    }
    // MARK: - Choose Address
    func chooseAddress() {
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "ChooseAddressVC") as! ChooseAddressVC
        let transitionDelegate = SPStorkTransitioningDelegate()
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        transitionDelegate.customHeight = UIScreen.main.bounds.height/2 + 16
        transitionDelegate.showIndicator = false
        transitionDelegate.translateForDismiss = 50
        transitionDelegate.tapAroundToDismissEnabled = true
        vc.sheetView = false
        vc.home = self
        vc.identifierVC = "Home"
        self.present(vc, animated: true, completion: nil)
    }
}
// MARK: - CollectionView DataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == navCollection {
            return arrDelivery.count
        } else if collectionView == bannerCollectionView {
            return arrImages.count
        } else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == navCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NavCollectionCell", for: indexPath) as! NavCollectionCell
            DispatchQueue.main.async {
                cell.bckView.layer.cornerRadius = cell.bckView.frame.height/2
            }
            cell.lblName.text = arrDelivery[indexPath.row]
            cell.bckView.backgroundColor = selectedIndex == indexPath.row ? #colorLiteral(red: 0.968627451, green: 0.9215686275, blue: 0.2039215686, alpha: 1) : #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
            return cell
        } else if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanerCollectionCell", for: indexPath) as! BanerCollectionCell
            cell.imgView.image = arrImages[indexPath.row]
            pageControl.numberOfPages = arrImages.count
            return cell
        }
        return UICollectionViewCell()
    }
}
// MARK: - CollectionView Delegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == navCollection {
            self.navCollection.reloadData()
            selectedIndex = indexPath.row
            openBottomSheet()
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    func openBottomSheet() {
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "BottomSheetVC") as! BottomSheetVC
        vc.homeVC = self
        vc.editAddress = editText
        vc.isEdit = isEdit
        let transitionDelegate = SPStorkTransitioningDelegate()
        vc.transitioningDelegate = transitionDelegate
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        transitionDelegate.showIndicator = false
        transitionDelegate.translateForDismiss = 50
        transitionDelegate.tapAroundToDismissEnabled = true
        if selectedIndex == 0 {
            vc.strKey = "delevery30min"
        } else {
            vc.strKey = "delevery10min"
        }
        self.present(vc, animated: true, completion: nil)
    }
}
// MARK: - CollectionView Flowlayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            let collectionWidth = bannerCollectionView.bounds.width
            return CGSize(width: collectionWidth/1  ,height: bannerCollectionView.bounds.height)
        } else {
            let collectionView = navCollection.bounds.size
            let size = (arrDelivery[indexPath.row]).size(withAttributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
            ])
            return CGSize(width: size.width + 45, height: collectionView.height)
            //return CGSize(width: collectionWidth/3  ,height: bannerCollectionView.bounds.height )
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            return 0
        } else {
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            return 0
        } else {
            return 10
        }
    }
}
// MARK: - TableView DataSource
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 2
        } else {
            return arrSectionLastImages.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InTheNewsTableCell", for: indexPath) as! InTheNewsTableCell
            cell.home = self
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OurSpecialtiesTableCell", for: indexPath) as! OurSpecialtiesTableCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedProductsTableCell", for: indexPath) as! RecommendedProductsTableCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OurRestaurantsTableCell", for: indexPath) as! OurRestaurantsTableCell
            cell.imgView.image = arrSectionLastImages[indexPath.row]
            cell.lblTitle.text = arrSectionLastTitle[indexPath.row]
            cell.lblSubTitle.text = arrSectionLastSubTitle[indexPath.row]
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60.0
        } else if section == 1 {
            return 45.0
        } else if section == 2 {
            return 45.0
        } else {
            return 10.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if section == 0 {
            let label = UILabel(frame: CGRect(x: 16, y: 32, width:tableView.frame.size.width, height: 22))
            label.font = UIFont(name: "Roboto-BoldCondensed", size: 22.0)
            label.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
            label.text = "À la une"
            headerView.addSubview(label)
        } else if section == 1 {
            let label = UILabel(frame: CGRect(x: 16, y: 8, width:tableView.frame.size.width, height: 22))
            label.font = UIFont(name: "Roboto-BoldCondensed", size: 22.0)
            label.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
            label.text = "Nos spécialités"
            headerView.addSubview(label)
        } else if section == 2 {
            let label = UILabel(frame: CGRect(x: 16, y: 8, width:tableView.frame.size.width, height: 22))
            label.font = UIFont(name: "Roboto-BoldCondensed", size: 22.0)
            label.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
            label.text = "Produits recommandés"
            headerView.addSubview(label)
        } else {
            let label = UILabel(frame: CGRect(x: 16, y: -16, width:tableView.frame.size.width, height: 22))
            label.font = UIFont(name: "Roboto-BoldCondensed", size: 22.0)
            label.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
            label.text = "Nos restaurants"
            headerView.addSubview(label)
        }
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return section0Footer
        } else {
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 144.0
        } else {
            return 0.0
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = tableView.contentOffset.y
        if offset <= 0 {
            navView.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        } else {
            navView.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16)

        }
    }
}
// MARK: - TableHeader Configuration
extension HomeVC {
    func headerConfiguration() {
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerView.frame.height)
        tableView.tableHeaderView =  headerView
        tableView.tableHeaderView?.frame =  headerView.frame
    }
}
// MARK: - collectionView Cell Class
class NavCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var lblName: UILabel!
}
// MARK: - Auto Scroll For Header
extension HomeVC {
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
     _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
    }
    // create auto scroll
    @objc func autoScroll() {
        pageControl.currentPage = x
        if self.x < arrImages.count {
            let indexPath = IndexPath(item: x, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.x = self.x + 1
        } else {
            self.x = 0
            self.bannerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = x
        }
    }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedItem != nil) {
            bannerCollectionView.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
