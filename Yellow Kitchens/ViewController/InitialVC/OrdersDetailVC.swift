//
//  OrdersDetailVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 07/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class OrdersDetailVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sectionFooter: UIView!
    @IBOutlet weak var footerView: UIView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        footerConfiguration()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.OrdersDetailTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_ContactUs(_ sender: UIControl) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}
// MARK: - TableView DataSource
extension OrdersDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 1
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCell", for: indexPath) as! OrderDetailCell
            return cell
        } else  if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCell1", for: indexPath) as! OrderDetailCell1
            return cell
        } else  if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailInvoiceCell", for: indexPath) as! OrderDetailInvoiceCell
            cell.lblName.text = "Demander une facture"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailInvoiceCell", for: indexPath) as! OrderDetailInvoiceCell
            cell.lblName.text = "Commander à nouveau"
            return cell
        }
    }
}

// MARK: - TableView Delegate
extension OrdersDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50.0
        } else if section == 1 {
            return 50.0
        } else if section == 2 {
            return 38.0
        } else if section == 3 {
            return 10.0
        } else {
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let label = UILabel(frame: CGRect(x:16, y:28, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Poppins-Regular", size: 14.0)
        label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        if section == 0 {
            label.text = "Statut"
        } else if section == 1 {
            label.text = "Récapitulatif"
        } else if section == 2 {
            label.text = ""
        } else {
            label.text = ""
        }
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return sectionFooter
        } else {
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 96.0
        } else {
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 50
        } else if indexPath.section == 3 {
            return 50
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: - TableFooter Config
extension OrdersDetailVC {
    func footerConfiguration() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.height)
        tableView.tableFooterView =  footerView
        tableView.tableFooterView?.frame =  footerView.frame
    }
}

// MARK: - TableView Cell Class
class OrderDetailCell: UITableViewCell {
}
class OrderDetailCell1: UITableViewCell {
}
class OrderDetailInvoiceCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
}
