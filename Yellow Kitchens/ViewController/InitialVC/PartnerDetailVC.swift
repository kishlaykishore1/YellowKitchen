//
//  PartnerDetailVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 09/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class PartnerDetailVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: DesignableView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headerConfiguration()
        setNavShadow(shadowRadius: 0, shadowOpacity: 0, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.PartnerDetailTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - TableView DataSource
extension PartnerDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PartnerDetailCell", for: indexPath) as! PartnerDetailCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PartnerDetailAmmountCell", for: indexPath) as! PartnerDetailAmmountCell
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension PartnerDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60.0
        } else {
            return 10.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let label = UILabel(frame: CGRect(x:16, y:32, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Poppins-Regular", size: 14.0)
        label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        if section == 0 {
            label.text = "Détails du versement"
        } else {
            label.text = ""
        }
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63.0
    }
}
// MARK: - TableFooter Config
extension PartnerDetailVC {
    func headerConfiguration() {
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerView.frame.height)
        tableView.tableHeaderView =  headerView
        tableView.tableHeaderView?.frame = headerView.frame
    }
}
// MARK: - TableView Cell Class
class PartnerDetailCell: UITableViewCell {
}
class PartnerDetailAmmountCell: UITableViewCell {
}
