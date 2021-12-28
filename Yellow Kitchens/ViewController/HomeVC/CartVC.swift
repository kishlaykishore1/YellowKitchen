//
//  CartVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 17/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import FittedSheets

class CartVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var section0FooterView: UIView!
    @IBOutlet weak var section2FooterView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    // MARK: - Properties
    var arrYourOrder = ["Bagel Fermier", "Bagel Fermier", "Bagel Fermier", "Bagel Fermier"]
    var arrYourgift = ["Mug YK", "Mug YK", "Mug YK"]
    var arrYourgift1 = ["Mug YK"]
    var indexx = IndexPath()
    var somePlus: Int = 0
    var section2Rows = "NotEmpty"
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        footerConfiguration()
        headerConfiguration()
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
        self.title = Messages.CartTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    @IBAction func action_BackToHome(_ sender: UIButton) {
        emptyView.isHidden = true
    }
}
// MARK: - Action Method
extension CartVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_nextStep(_ sender: UIButton) {
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "PaymentBottomSheetVC") as! PaymentBottomSheetVC
        let sheetController = SheetViewController(controller: vc, sizes: [.fixed(370)])
        sheetController.dismissOnBackgroundTap = true
        sheetController.pullBarView.isHidden = true
        sheetController.blurBottomSafeArea = false
        self.present(sheetController, animated: false, completion: nil)
    }
    @IBAction func action_ApplyPromoCode(_ sender: UIControl) {
        applyPromoCode()
    }
    func applyPromoCode() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Code promo", message: "Ajouter un code promo pour obtenir une réduction sur votre commande.", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Code promo"
                textField.autocapitalizationType = .sentences
                textField.isEnabled = false
            }
            let saveAction = UIAlertAction(title: "Ajouter", style: .default, handler: { _ -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                if firstTextField.text?.trim().count == 0 {
                    return
                }
                // self.apiCreateGroup(groupName: firstTextField.text!.trim())
                self.dismiss(animated: true, completion: nil)
            })
            let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: { ( _ : UIAlertAction!) -> Void in
            })
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: {
                let firstTextField = alertController.textFields![0] as UITextField
                firstTextField.isEnabled = true
                firstTextField.becomeFirstResponder()
            })
        }
    }
}
// MARK: - TableView DataSource
extension CartVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrYourOrder.count
        } else if section == 1 {
            return 1
        } else if section == 2 {
            if section2Rows == "NotEmpty" {
                return arrYourgift.count
            } else {
                return 1
            }
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourOrderTableCell", for: indexPath) as! YourOrderTableCell
            cell.btnMinus.tag = indexPath.row
            cell.btnPlus.tag = indexPath.row
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCodeTableCell", for: indexPath) as! PromoCodeTableCell
            cell.promoCodeView.tag = indexPath.row
            return cell
        } else {
            if section2Rows == "NotEmpty" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "YourOrderTableCell", for: indexPath) as! YourOrderTableCell
                cell.lblName.text = "Mug YK"
                cell.lblPrice.text = "1 000 pts"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "YourGiftTableCell", for: indexPath) as! YourGiftTableCell
                return cell
            }
        }
    }
}
// MARK: - TableView Delegate
extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50.0
        } else if section == 1 {
            return 25.0
        } else {
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        if section == 0 {
            let label = UILabel(frame: CGRect(x:16, y:28, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Votre commande"
            headerView.addSubview(label)
        } else if section == 2 {
            let label = UILabel(frame: CGRect(x:16, y:-3, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Poppins-Regular", size: 14.0)
            label.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
            label.text = "Vos cadeaux"
            headerView.addSubview(label)
        } else {
            return UIView()
        }
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return section0FooterView
        } else if section == 2 {
            if section2Rows == "NotEmpty" {
                return section2FooterView
            } else {
                return UIView()
            }
        } else {
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 96.0
        } else  if section == 2 {
            if section2Rows == "NotEmpty" {
                return 70.0
            } else {
                return 0.0
            }
        } else {
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else if indexPath.section == 2 {
            return true
        } else {
            return false
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Supprimer"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete {
                arrYourOrder.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
            }
        } else if indexPath.section == 2 {
            if editingStyle == .delete {
                arrYourgift.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                self.tableView.reloadData()
                if arrYourgift.count == 0 {
                    section2Rows = "Empty"
                    self.tableView.reloadData()
                } else {
                    section2Rows = "NotEmpty"
                }
            }
        } else {
            if editingStyle == .none {
            }
        }
    }
}
// MARK: - TableFooter Header Config
extension CartVC {
    func footerConfiguration() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.height)
        tableView.tableFooterView =  footerView
        tableView.tableFooterView?.frame =  footerView.frame
    }
    func headerConfiguration() {
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerView.frame.height)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.frame =  headerView.frame
    }
}

// MARK: - TableView Cell Class
class YourOrderTableCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    // MARK: - Properties
    var count: Int = 1
    override func awakeFromNib() {
        super.awakeFromNib()
        btnPlus.setImage(#imageLiteral(resourceName: "plusSmall"), for: .normal)
    }
    @IBAction func action_Plus(_ sender: UIButton) {
        count += 1
        lblCount.text = "\(count)"
        btnMinus.setImage(#imageLiteral(resourceName: "minusBlackSmall"), for: .normal)
    }
    @IBAction func action_Minus(_ sender: UIButton) {
        if count == 1 {
            self.lblCount.text = "\(self.count)"
        } else {
            count -= 1
            lblCount.text = "\(count)"
            btnMinus.setImage(#imageLiteral(resourceName: "minusGray"), for: .normal)
        }
    }
}
class PromoCodeTableCell: UITableViewCell {
    @IBOutlet weak var promoCodeView: UIView!
}
class YourGiftTableCell: UITableViewCell {
}
