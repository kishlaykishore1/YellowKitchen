//
//  FaqVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 08/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class FaqVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var section0 = [Section0Expend(isExpendable: false), Section0Expend(isExpendable: false), Section0Expend(isExpendable: false), Section0Expend(isExpendable: false)]
    var section1 = [Section1Expend(isExpendable: false), Section1Expend(isExpendable: false), Section1Expend(isExpendable: false), Section1Expend(isExpendable: false)]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.FaqTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - TableView DataSource
extension FaqVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaqCell", for: indexPath) as! FaqCell
            if section0[indexPath.row].isExpendable == false {
                cell.spreaterView.isHidden = true
            } else {
                cell.spreaterView.isHidden = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaqCell", for: indexPath) as! FaqCell
            if section1[indexPath.row].isExpendable == false {
                cell.spreaterView.isHidden = true
            } else {
                cell.spreaterView.isHidden = false
            }
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension FaqVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50.0
        } else {
            return 30.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if section == 0 {
            let label = UILabel(frame: CGRect(x: 16, y: 28, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Prise de commande"
            headerView.addSubview(label)
        } else {
            let label = UILabel(frame: CGRect(x: 16, y: 8, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Commande effectuée"
            headerView.addSubview(label)
        }
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return (section0[indexPath.row].isExpendable) ? UITableView.automaticDimension : 52
        } else {
            return (section1[indexPath.row].isExpendable) ? UITableView.automaticDimension : 52
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            section0[indexPath.row].isExpendable = !(section0[indexPath.row].isExpendable)
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            section1[indexPath.row].isExpendable = !(section1[indexPath.row].isExpendable)
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - TableView Cell Class
class FaqCell: UITableViewCell {
    @IBOutlet weak var spreaterView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
}

// MARK: - Model For Expended cell
class Section0Expend {
    var isExpendable: Bool = false
    init(isExpendable: Bool) {
        self.isExpendable = isExpendable
    }
}
class Section1Expend {
    var isExpendable: Bool = false
    init(isExpendable: Bool) {
        self.isExpendable = isExpendable
    }
}
