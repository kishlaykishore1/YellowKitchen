//
//  MyAccountVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 04/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class MyAccountVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var section2array = ["Mes informations", "Mes moyens de paiement", "Adresses enregistrées"]
    var section2arrayImg = [#imageLiteral(resourceName: "user"), #imageLiteral(resourceName: "credit-card"), #imageLiteral(resourceName: "home")]
    var section3array = ["Parainage", "Programme partenaire"]
    var section3arrayImg = [#imageLiteral(resourceName: "refer"), #imageLiteral(resourceName: "handshake")]
    var section4array = ["Foire aux questions", "Activer les notifications", "À propos"]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.MyAccountTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource
extension MyAccountVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 3
        } else if section == 3 {
            return 2
        } else if section == 4 {
            return 3
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
            cell.lblSourceName.text = "La boutique"
            cell.sourceImg.image = #imageLiteral(resourceName: "giftbox")
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
            cell.lblSourceName.text = section2array[indexPath.row]
            cell.sourceImg.image = section2arrayImg[indexPath.row]
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
            cell.lblSourceName.text = section3array[indexPath.row]
            cell.sourceImg.image = section3arrayImg[indexPath.row]
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell1", for: indexPath) as! TableCell1
            cell.lblName.text = section4array[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell1", for: indexPath) as! TableCell1
            cell.arrowImg.isHidden = true
            cell.lblName.textColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 1)
            cell.lblName.text = "Déconnexion"
            cell.lblName.font = UIFont(name: "Poppins-Regular", size: 16.0)
            return cell
        }
    }
}

// MARK: - TableView Delegate
extension MyAccountVC: UITableViewDelegate {
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                default:
                    break
                }
            case 1:
                switch indexPath.row {
                case 0:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                default:
                    break
                }
            case 2:
                switch indexPath.row {
                case 0:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "EditAccountVC") as! EditAccountVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 1:
                    let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "ChoosePaymentVC") as! ChoosePaymentVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 2:
                    let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "ChooseAddressVC") as! ChooseAddressVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                default:
                    break
                }
            case 3:
                switch indexPath.row {
                case 0:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "ReferalVC") as! ReferalVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 1:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "PartnerOnBoardingVC") as! PartnerOnBoardingVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                default:
                    break
                }
            case 4:
                switch indexPath.row {
                case 0:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "FaqVC") as! FaqVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 2:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                default:
                    break
                }
            case 5:
                let alert  = UIAlertController(title: "Alerte !", message: "Êtes-vous sûr de vouloir vous déconnecter ?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Confirmer", style: .destructive, handler: { _ in
                }))
                alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
    }
}

// MARK: - TableView Cell Class
class TableCell: UITableViewCell {
    @IBOutlet weak var sourceImg: UIImageView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var lblSourceName: UILabel!
}

class TableCell1: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
}
