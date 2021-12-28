//
//  ChooseAddressVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 18/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import SPStorkController

class ChooseAddressVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    // MARK: - Prope rties
    var sheetView: Bool?
    var home: HomeVC?
    var bottomSheet: BottomSheetVC?
    var identifierVC = ""
    var arrImg = [ #imageLiteral(resourceName: "homeYellow"), #imageLiteral(resourceName: "office"), #imageLiteral(resourceName: "Hotel"), #imageLiteral(resourceName: "Hotel")]
    var arrTitle = ["Maison", "Bureau", "Hotel", "Chez Vincent"]
    var arrSubTitle = ["9 rue Bufault 750009 Paris", "28 boulevard Victor Hugo 75019 Paris", "Georges 5 - 34 avenue des Champs Ely…", "34 avenue de la Californie 7500…"]
    var emptyOrNot: String = "NotEmpty"
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
        footerConfiguration()
        if sheetView ?? false {
            tableView.bounces = true
        } else {
            tableView.bounces = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.ChooseAddressTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
}
// MARK: - Action Method
extension ChooseAddressVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_AddNewAddress(_ sender: UIControl) {
        self.dismiss(animated: true, completion: {
            let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "NewAddressVC") as! NewAddressVC
            aboutVC.home = self.home
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: aboutVC)
            getNav.present( rootNavView, animated: true, completion: nil)
        })
    }
}
// MARK: - TableView DataSource
extension ChooseAddressVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if emptyOrNot == "NotEmpty" {
             return arrImg.count
        } else {
             return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if emptyOrNot == "NotEmpty" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseAddressCell", for: indexPath) as! ChooseAddressCell
            cell.imgView.image = arrImg[indexPath.row]
            cell.lblTitle.text = arrTitle[indexPath.row]
            cell.lblSubTitle.text = arrSubTitle[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyAddressCell", for: indexPath) as! EmptyAddressCell
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension ChooseAddressVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let label = UILabel(frame: CGRect(x:16, y:24, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Poppins-Regular", size: 14.0)
        label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        label.text = "Mes adresses"
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Supprimer"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrImg.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if arrImg.count == 0 {
                 emptyOrNot = "Empty"
                 self.tableView.reloadData()
            } else {
                emptyOrNot = "NotEmpty"
            }
        } else {
            if editingStyle == .none {
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sheetView ?? false {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            self.dismiss(animated: true) {
                if self.identifierVC == "Home" {
                    self.home?.lblAddress.text = self.arrTitle[indexPath.row]
                } else {
                    self.bottomSheet?.editAddress =  self.arrTitle[indexPath.row]
                    self.home?.editText = self.arrSubTitle[indexPath.row]
                    self.home?.isEdit = true
                    self.home?.openBottomSheet()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
// MARK: - TableFooter Config
extension ChooseAddressVC {
    func footerConfiguration() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.height)
        tableView.tableFooterView =  footerView
        tableView.tableFooterView?.frame =  footerView.frame
    }
}
// MARK: - TableView Cell Class
class ChooseAddressCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
}
class EmptyAddressCell: UITableViewCell {
}
