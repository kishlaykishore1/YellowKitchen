//
//  ReferalVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 08/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class ReferalVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblReferalCode: UILabel!
    // MARK: - Properties
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 0, shadowOpacity: 0, shadowColor: UIColor.black.cgColor)
        headerConfiguration()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.ReferalTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_Share(_ sender: UIButton) {
        let items: [Any] = [lblReferalCode.text ?? ""]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
// MARK: - TableView DataSource
extension ReferalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReferalCell", for: indexPath) as! ReferalCell
        return cell
    }
}
// MARK: - TableView Delegate
extension ReferalVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        let label = UILabel(frame: CGRect(x: 16, y: 36, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Poppins-Regular", size: 14.0)
        label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        label.text = "Ils ont utilisé votre code"
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
// MARK: - TableView Header Configuration
extension ReferalVC {
    func headerConfiguration() {
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerView.frame.height)
        tableView.tableHeaderView =  headerView
        tableView.tableHeaderView?.frame =  headerView.frame
    }
}

// MARK: - TableView Cell Class
class ReferalCell: UITableViewCell {
}
