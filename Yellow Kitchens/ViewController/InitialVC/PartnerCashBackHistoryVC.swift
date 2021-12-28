//
//  PartnerCashBackHistoryVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 09/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class PartnerCashBackHistoryVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var lblEmptyViewMsg: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    // MARK: - Properties
    var strValue: String = "cashBack"
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 0, shadowOpacity: 0, shadowColor: UIColor.black.cgColor)
        segmentControl.addTarget(self, action: #selector(partnerCashHistory(sender:)), for:.allEvents)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.ContactUsPartnerTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func partnerCashHistory(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            strValue = "cashBack"
            tableView.reloadData()
        } else {
            strValue = "History"
            tableView.reloadData()
        }
    }
}
// MARK: - TableView DataSource
extension PartnerCashBackHistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if strValue == "cashBack" {
            return 4
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if strValue == "cashBack" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PartnerCashBackCell", for: indexPath) as! PartnerCashBackCell
            footerView.isHidden = false
            footerConfiguration()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PartnerHistoryCell", for: indexPath) as! PartnerHistoryCell
            if indexPath.row == 0 {
                cell.progressView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
                cell.lblProgress.text = "En cours"
            }
            footerView.isHidden = true
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension PartnerCashBackHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let label = UILabel(frame: CGRect(x:16, y:32, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Poppins-Regular", size: 14.0)
        label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        if strValue == "cashBack" {
            label.text = "Commissions en cours"
        } else {
            label.text = "Versements"
        }
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  strValue == "History" {
            let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "PartnerDetailVC") as! PartnerDetailVC
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            if #available(iOS 13.0, *) {
                aboutVC.isModalInPresentation = true
            }
            let rootNavView = UINavigationController(rootViewController: aboutVC)
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
}

// MARK: - TableFooter Config
extension PartnerCashBackHistoryVC {
    func footerConfiguration() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.height)
        tableView.tableFooterView =  footerView
        tableView.tableFooterView?.frame =  footerView.frame
    }
}

// MARK: - TableView Cell Class
class PartnerCashBackCell: UITableViewCell {
}
class PartnerHistoryCell: UITableViewCell {
    @IBOutlet weak var progressView: DesignableView!
    @IBOutlet weak var lblProgress: UILabel!
}
