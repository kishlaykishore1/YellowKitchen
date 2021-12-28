//
//  RestaurantVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 11/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import ParallaxHeader
import FittedSheets

class RestaurantVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var heightHeaderImage: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var lblFindOutMore: TTTAttributedLabel!
    @IBOutlet weak var lblHeaderReadMore: TTTAttributedLabel!
    // MARK: - properties
    var arrCategories = ["Bagels", "Entrées", "Desserts", "Boissons", "Accompagnements"]
    var selectedIndex: Int?
    var selectedCollectionIndex = 0
    var index = IndexPath()
    var isBottomView = Bool()
    var headerHeight:CGFloat = 340.0
    let kCharacterBeforReadMore =  100
    let kReadMoreText           =  "... Lire plus ⋁"
    let kReadLessText           =  " Voir moins ⋀"
    var strFull = ""
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup()
        headerTitleSetup()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        tableBottomHeight.priority = UILayoutPriority(rawValue: 999)
        self.bottomView.isHidden = true
        //parallaxHeaderWithTopMenu()
    }
    // MARK: For
    func readMore(readMore: Bool) {
        lblHeaderReadMore.showTextOnTTTAttributeLable(str: strFull, readMoreText: kReadMoreText, readLessText: kReadLessText, font: UIFont.init(name: "Poppins-Regular", size: 12), charatersBeforeReadMore: kCharacterBeforReadMore, activeLinkColor: UIColor.blue, isReadMoreTapped: readMore, isReadLessTapped: false)
    }
    func readLess(readLess: Bool) {
        lblHeaderReadMore.showTextOnTTTAttributeLable(str: strFull, readMoreText: kReadMoreText, readLessText: kReadLessText, font: UIFont.init(name: "Poppins-Regular", size: 12), charatersBeforeReadMore: kCharacterBeforReadMore, activeLinkColor: UIColor.blue, isReadMoreTapped: readLess, isReadLessTapped: true)
    }
}
// MARK: - Action & Functions
extension RestaurantVC {
    @IBAction func action_BackHeader(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_backHiddenView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_AddToCart(_ sender: UIControl) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    @IBAction func action_Share(_ sender: UIButton) {
        let items: [Any] = [#imageLiteral(resourceName: "Bitmap"), "Yellow Kitchens"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    @IBAction func action_ShareHeaderButton(_ sender: UIButton) {
        let items: [Any] = [#imageLiteral(resourceName: "Bitmap"), "Yellow Kitchens"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
//    func parallaxHeaderWithTopMenu() {
//        // setup blur vibrant view
//        //headerView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
//        //tableView.parallaxHeader.view =  headerView
//        tableView.parallaxHeader.height = headerHeight
//        tableView.parallaxHeader.minimumHeight = 0
//        tableView.parallaxHeader.mode = .centerFill
//        tableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
//            //update alpha of blur view on top of image view
//            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
//            if parallaxHeader.progress == 0.0 {
//                self.setView(view: self.hiddenView, hidden: false)
//                self.view.backgroundColor = UIColor.white
//            } else {
//                self.setView(view: self.hiddenView, hidden: true)
//                self.view.backgroundColor = UIColor.black
//            }
//        }
//    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
}
// MARK: - TableView DataSource
extension RestaurantVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBottomView == true {
            tableBottomHeight.priority = UILayoutPriority(rawValue: 997)
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.bottomView.isHidden = false
            }
        } else {
            tableBottomHeight.priority = UILayoutPriority(rawValue: 999)
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.bottomView.isHidden = true
            }
        }
        index = indexPath
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagLineTableCell", for: indexPath) as! TagLineTableCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesListTableCell", for: indexPath) as! CategoriesListTableCell
            cell.restaurantVC = self
            return cell
        }
    }
}

// MARK: - TableView Delegate
extension RestaurantVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let offset = tableView.contentOffset.y
            heightHeaderImage.constant = (278 - offset) < 0 ? 0 : (278 - offset)
            if offset <= 200 {
                self.setView(view: self.hiddenView, hidden: true)
                self.view.backgroundColor = UIColor.black
            } else {
                self.setView(view: self.hiddenView, hidden: false)
                self.view.backgroundColor = UIColor.white
            }
        }
        let visibleCellsIndexes = self.tableView.returnVisibleCellsIndexes()
        visibleCellsIndexes.forEach { (indexpath) in
            //print(indexpath.section)
            selectedIndex = indexpath.section
            collectionView.reloadData()
        }
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .autoreverse, animations: {
            if self.selectedIndex != self.selectedCollectionIndex {
                self.selectedCollectionIndex = self.selectedIndex ?? 0
                self.collectionView.scrollToItem(at:IndexPath(item: (self.selectedIndex ?? 0), section: 0) , at: .centeredHorizontally, animated: true)
            }
        }, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        } else {
            return 50.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if section == 1 {
            let label = UILabel(frame: CGRect(x:16, y:16, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Bagels"
            headerView.addSubview(label)
        } else  if section == 2 {
            let label = UILabel(frame: CGRect(x:16, y:16, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Entrées"
            headerView.addSubview(label)
        } else  if section == 3 {
            let label = UILabel(frame: CGRect(x:16, y:16, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Desserts"
            headerView.addSubview(label)
        } else  if section == 4 {
            let label = UILabel(frame: CGRect(x:16, y:16, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Boissons"
            headerView.addSubview(label)
        } else  if section == 5 {
            let label = UILabel(frame: CGRect(x:16, y:16, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Accompagnements"
            headerView.addSubview(label)
        }
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.restaurant = self
        vc.indexx = index
        let sheetController = SheetViewController(controller: vc, sizes: [.fullScreen])
        sheetController.dismissOnBackgroundTap = true
        sheetController.pullBarView.isHidden = true
        sheetController.blurBottomSafeArea = false
        self.present(sheetController, animated: false, completion: nil)
    }
}

// MARK: - CollectionView DataSource
extension RestaurantVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.lblName.text = arrCategories[indexPath.row]
        cell.bckView.backgroundColor = self.selectedIndex == indexPath.row ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lblName.textColor = self.selectedIndex == indexPath.row ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
}

// MARK: - CollectionView Flowlayout
extension RestaurantVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionView = collectionView.bounds.size
        let size = (arrCategories[indexPath.row]).size(withAttributes: [
            NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 14.0)!
        ])
        return CGSize(width: size.width + 45, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// MARK: - CollectionView Delegate
extension RestaurantVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.collectionView.reloadData()
    }
}
// MARK: - TermsOfUse Label Set
extension RestaurantVC {
//    func setup() {
//        lblFindOutMore.numberOfLines = 0
//        let strPP = "En savoir plus"
//        let string = "Exclusivité Yellow Kitchens : Commandez dans plusieurs restaurants. Nous organisons la livraison. \(strPP)"
//        let nsString = string as NSString
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1
//        let fullAttributedString = NSAttributedString(string:string, attributes: [
//            NSAttributedString.Key.paragraphStyle: paragraphStyle,
//            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
//            NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 11) ?? UIFont()
//        ])
//        lblFindOutMore.textAlignment = .center
//        lblFindOutMore.attributedText = fullAttributedString
//        let rangePP = nsString.range(of: strPP)
//        let ppLinkAttributes: [String: Any] = [
//            NSAttributedString.Key.foregroundColor.rawValue: #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 1),
//            NSAttributedString.Key.underlineStyle.rawValue: false,
//            NSAttributedString.Key.font.rawValue: UIFont.init(name: "Poppins-Regular", size: 11) ?? UIFont()
//        ]
//        lblFindOutMore.activeLinkAttributes = ppLinkAttributes
//        lblFindOutMore.linkAttributes = ppLinkAttributes
//        let urlPP = URL(string: "action://PP")!
//        lblFindOutMore.addLink(to: urlPP, with: rangePP)
//        lblFindOutMore.textColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
//        lblFindOutMore.delegate = self
//    }
    func headerTitleSetup() {
//        lblHeaderReadMore.numberOfLines = 2
//        let strPP = "Lire plus"
//        let string = "Nos bagels sont proposés avec un choix d’accompagnements gourmands et variés qui raviront vos papilles... \(strPP)"
//        let nsString = string as NSString
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1
//        let fullAttributedString = NSAttributedString(string:string, attributes: [
//            NSAttributedString.Key.paragraphStyle: paragraphStyle,
//            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
//            NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 12) ?? UIFont()
//        ])
//        lblHeaderReadMore.textAlignment = .left
//        lblHeaderReadMore.attributedText = fullAttributedString
//        let rangePP = nsString.range(of: strPP)
//        let ppLinkAttributes: [String: Any] = [
//            NSAttributedString.Key.foregroundColor.rawValue: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
//            NSAttributedString.Key.underlineStyle.rawValue: false,
//            NSAttributedString.Key.font.rawValue: UIFont.init(name: "Poppins-Regular", size: 12) ?? UIFont()
//        ]
//        lblHeaderReadMore.activeLinkAttributes = ppLinkAttributes
//        lblHeaderReadMore.linkAttributes = ppLinkAttributes
//        let urlPP = URL(string: "action://TP")!
//        lblHeaderReadMore.addLink(to: urlPP, with: rangePP)
//        lblHeaderReadMore.textColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        lblHeaderReadMore.delegate = self
        strFull = "Nos bagels sont proposés avec un choix d’accompagnements gourmands et variés qui raviront vos papilles,Nos bagels sont proposés avec un choix d’accompagnements gourmands et variés qui raviront vos papilles... "
        lblHeaderReadMore.showTextOnTTTAttributeLable(str: strFull, readMoreText: kReadMoreText, readLessText: kReadLessText, font: UIFont.init(name: "Poppins-Regular", size: 12)!, charatersBeforeReadMore: kCharacterBeforReadMore, activeLinkColor: UIColor.blue, isReadMoreTapped: false, isReadLessTapped: false)
    }
}
// MARK: - TTTAttributedLabelDelegate
extension RestaurantVC: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWithTransitInformation components: [AnyHashable : Any]!) {
        if let _ = components as? [String: String] {
          if let value = components["ReadMore"] as? String, value == "1" {
            self.readMore(readMore: true)
          }
          if let value = components["ReadLess"] as? String, value == "1" {
            self.readLess(readLess: true)
          }
        }
      }
}
// MARK: - Collection Cell Class
class CategoriesCell: UICollectionViewCell {
    @IBOutlet weak var bckView: DesignableView!
    @IBOutlet weak var lblName: UILabel!
}
// MARK: - TableView Cell Class
class TagLineTableCell: UITableViewCell {
}
class CategoriesListTableCell: UITableViewCell {
    @IBOutlet weak var lblDescription: TTTAttributedLabel!
    var isExpand = false
    var restaurantVC: RestaurantVC?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellTitleSetup()
    }
    func cellTitleSetup() {
        lblDescription.numberOfLines = 0
        //lblDescription.lineBreakMode = .byTruncatingMiddle
        let strPP = "Lire plus"
        let string = "Amazin toast with french butter and fresh milk. The bext way to enjoy in Amazin toast with french butter and fresh milk. The bext way to enjoy in morning \(strPP)"
        let nsString = string as NSString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        //paragraphStyle.allowsDefaultTighteningForTruncation = true
        //paragraphStyle.lineBreakMode = .byTruncatingMiddle
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
            NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 11) ?? UIFont()
        ])
        lblDescription.textAlignment = .left
        lblDescription.attributedText = fullAttributedString
        let rangePP = nsString.range(of: strPP)
        let ppLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.underlineStyle.rawValue: false,
            NSAttributedString.Key.font.rawValue: UIFont.init(name: "Poppins-Regular", size: 13) ?? UIFont()
        ]
        lblDescription.activeLinkAttributes = ppLinkAttributes
        lblDescription.linkAttributes = ppLinkAttributes
        let urlPP = URL(string: "action://TP")!
        lblDescription.addLink(to: urlPP, with: rangePP)
        lblDescription.textColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        //lblDescription.delegate = self
    }
}

// MARK: - TTTAttributedLabelDelegate
extension CategoriesListTableCell: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString == "action://TP" {
            if isExpand {
                lblDescription.numberOfLines = 2
                isExpand = false
            } else {
                lblDescription.numberOfLines = 0
                isExpand = true
            }
            restaurantVC?.tableView.reloadData()
        }
    }
}

extension UITableView {
    func returnVisibleCellsIndexes() -> [IndexPath] {
        var indexes = [IndexPath]()
        for cell in self.visibleCells {
            if let indexpath = self.returnIndexPath(cell: cell) {
                indexes.append(indexpath)
            }
        }
        return indexes
    }
    func returnIndexPath(cell: UITableViewCell) -> IndexPath? {
        guard let indexPath = self.indexPath(for: cell) else {
            return nil
        }
        return indexPath
    }
    func returnVisibleCells() -> [UITableViewCell] {
        let visiblecell = self.visibleCells
        return visiblecell
    }
}
