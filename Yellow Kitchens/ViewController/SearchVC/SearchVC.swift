//
//  SearchVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 17/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bcakView: UIView!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tableView.isHidden = false
        bcakView.isHidden = true
        navSearchBar()
    }
    // MARK: - Navigation Bar Inside Search Bar
    func navSearchBar() {
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        searchBar.placeholder = "Rechercher une cuisine, un plat..."
        searchBar.tintColor = .black
        searchBar.barStyle = .default
        searchBar.isTranslucent = false
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: 0)
        searchBar.showsCancelButton = true
        searchBar.setImage(#imageLiteral(resourceName: "search3D"), for: .search, state: .normal)
        let searchFont = UIFont(name: "Poppins-Regular", size: 12)
        let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Poppins-Medium", size: 14)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 1)], for: .normal)
        cancelButton.setTitle("Annuler", for: .normal)
        cancelButton.titleLabel!.font = searchFont
    }
}
// MARK: - Action Method
extension SearchVC {
}
// MARK: - Table View DataSource
extension SearchVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialtiesTableCell", for: indexPath) as! SpecialtiesTableCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeOfDishesTableCell", for: indexPath) as! TypeOfDishesTableCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OurRestaurantsSearchTableCell", for: indexPath) as! OurRestaurantsSearchTableCell
            return cell
        }
    }
}
// MARK: - Table View Delegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60.0
        } else if section == 1 {
            return 40.0
        } else {
            return 40
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if section == 0 {
            let label = UILabel(frame: CGRect(x:16, y:32, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Spécialités"
            headerView.addSubview(label)
        } else if section == 1 {
            let label = UILabel(frame: CGRect(x:16, y:12, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Type de plats"
            headerView.addSubview(label)
        } else {
            let label = UILabel(frame: CGRect(x:16, y:12, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Nos restaurants"
            headerView.addSubview(label)
        }
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
// MARK: - SearchBar Delegate
extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            bcakView.isHidden = true
            tableView.isHidden = false
            return
        }
        tableView.isHidden = true
        bcakView.isHidden = false
    }
}
