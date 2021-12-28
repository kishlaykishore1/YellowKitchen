//
//  ChoosePaymentVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 18/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class ChoosePaymentVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    // MARK: - Properties
    var arrImg = [ #imageLiteral(resourceName: "visa"), #imageLiteral(resourceName: "cardLogo"), #imageLiteral(resourceName: "american-express"), #imageLiteral(resourceName: "mastercard")]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        footerConfiguration()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.ChoosePaymenytTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
}
// MARK: - Action Method
extension ChoosePaymentVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_AddNewCard(_ sender: UIControl) {
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
        aboutVC.ChoosePayment = self
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    @IBAction func action_Paypal(_ sender: UIControl) {
    }
}
// MARK: - TableView DataSource
extension ChoosePaymentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImg.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCardCell", for: indexPath) as! ChooseCardCell
        cell.cardImg.image = arrImg[indexPath.row]
        return cell
    }
}
// MARK: - TableView Delegate
extension ChoosePaymentVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Supprimer"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrImg.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            if editingStyle == .none {
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
// MARK: - TableFooter Config
extension ChoosePaymentVC {
    func footerConfiguration() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.height)
        tableView.tableFooterView =  footerView
        tableView.tableFooterView?.frame =  footerView.frame
    }
}
// MARK: - TableView Cell Class
class ChooseCardCell: UITableViewCell {
    @IBOutlet weak var cardImg: UIImageView!
}
