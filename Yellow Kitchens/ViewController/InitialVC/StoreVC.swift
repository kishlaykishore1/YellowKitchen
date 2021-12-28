//
//  StoreVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 07/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class StoreVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sectionFooter: UIView!
    @IBOutlet weak var lblSec: UILabel!
    @IBOutlet weak var imgSec: UIImageView!
    @IBOutlet weak var sectionFooter1: UIView!
    @IBOutlet weak var lblSec1: UILabel!
    @IBOutlet weak var imgSec1: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    // MARK: - Properties
    var arrImages =  [#imageLiteral(resourceName: "Bitmap"), #imageLiteral(resourceName: "Bitmap"), #imageLiteral(resourceName: "Bitmap")]
    var isSection0Count = true
    var isSection1Count = true
    var zoomedImage = UIImage()
    var x = 1
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headerConfiguration()
        startTimer()
        self.pageControl.numberOfPages = self.arrImages.count
        setNavShadow(shadowRadius: 0, shadowOpacity: 0, shadowColor: UIColor.black.cgColor)
        setNavigationBarImage(for: UIImage(), color: .white)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.StoreTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Action Method
extension StoreVC {
    @IBAction func action_SectionFooter(_ sender: UIControl) {
        if isSection0Count {
            isSection0Count = false
            tableView.reloadData()
            lblSec.text = "Voir moins de cadeaux"
            imgSec.image = #imageLiteral(resourceName: "up-arrow")
        } else {
            isSection0Count = true
            tableView.reloadData()
            lblSec.text = "Voir plus de cadeaux"
            imgSec.image = #imageLiteral(resourceName: "down-arrow")
        }
    }
    @IBAction func action_SecondSectionFooter(_ sender: UIControl) {
        if isSection1Count {
            isSection1Count = false
            tableView.reloadData()
            lblSec1.text = "Voir moins de cadeaux"
            imgSec1.image = #imageLiteral(resourceName: "up-arrow")
        } else {
            isSection1Count = true
            tableView.reloadData()
            lblSec1.text = "Voir plus de cadeaux"
            imgSec1.image = #imageLiteral(resourceName: "down-arrow")
        }
    }
    @IBAction func pageControl(_ sender: UIPageControl) {
       // pageControl.currentPage = arrImages.count
    }
}
// MARK: - TableView DataSource
extension StoreVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isSection0Count {
                return 2
            } else {
                return 4
            }
        } else {
            if isSection1Count {
                return 2
            } else {
                return 4
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoreCell
            cell.zoomImageView.tag = indexPath.row
            zoomedImage = cell.zoomImageView.image ?? UIImage()
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.zoomImageView.isUserInteractionEnabled = true
            cell.zoomImageView.addGestureRecognizer(tapGestureRecognizer)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoreCell
            return cell
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "GalleryImageVC") as! GalleryImageVC
        aboutVC.zoomedImage = zoomedImage
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}
// MARK: - TableView Delegate
extension StoreVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let label = UILabel(frame: CGRect(x: 16, y: 36, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Poppins-Regular", size: 14.0)
        label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        if section == 0 {
            label.text = "Cadeaux de saison"
        } else {
            label.text = "High-Tech"
        }
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return sectionFooter
        } else {
            return sectionFooter1
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 51.0
        } else {
            return 51.0
        }
    }
}

// MARK: - CollectionView DataSource
extension StoreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCollectionCell", for: indexPath) as! StoreCollectionCell
        cell.imgView.image = arrImages[indexPath.row]
        pageControl.numberOfPages = arrImages.count
        return cell
    }
}
// MARK: - CollectionView Delegate
extension StoreVC: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
// MARK: - CollectionView Flowlayout
extension StoreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/1  , height: collectionView.bounds.height )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// MARK: - TableHeader Configuration
extension StoreVC {
    func headerConfiguration() {
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerView.frame.height)
        tableView.tableHeaderView =  headerView
        tableView.tableHeaderView?.frame =  headerView.frame
    }
}
// MARK: - Auto Scroll For Header
extension StoreVC {
    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func startTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
    }
    // create auto scroll
        @objc func autoScroll() {
            pageControl.currentPage = x
            if self.x < arrImages.count {
                let indexPath = IndexPath(item: x, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.x = self.x + 1
            } else {
                self.x = 0
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
                self.pageControl.currentPage = x
            }
        }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
            if (context.nextFocusedItem != nil) {
                collectionView.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
            }
        }
}
// MARK: - TableView Cell Class
class StoreCell: UITableViewCell {
    @IBOutlet weak var zoomImageView: UIImageView!
}

// MARK: - collectionView Cell Class
class StoreCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
}
