//
//  AboutUsVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 08/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class AboutUsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    // MARK: - Properties
    var arrImage = [ #imageLiteral(resourceName: "facebook"), #imageLiteral(resourceName: "instagram"), #imageLiteral(resourceName: "internet")]
    var section0 = ["Suivez-nous sur Facebook", "Suivez-nous sur Instagram", "Consulter notre site internet"]
    var section1 = ["Nous contacter au sujet de votre commande", "Notez l’application !", "Signalez un problème", "Conditions Générales de Ventes", "Politique de Confidentialité"]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        FooterConfiguration()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.AboutUsTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - TableView DataSource
extension AboutUsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrImage.count
        } else {
            return section1.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
            cell.imgView.image = arrImage[indexPath.row]
            cell.lblName.text = section0[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell1", for: indexPath) as! AboutCell1
            cell.lblName.text = section1[indexPath.row]
            return cell
        }
    }
}
// MARK: - TableView Delegate
extension AboutUsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30.0
        } else {
            return 10.0
        }
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
                let title0 = self.section0[indexPath.row]
                switch indexPath.row {
                case 0:
                    let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
                    webViewController.titleString = title0
                    webViewController.url = "https://www.facebook.com/"
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: webViewController)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 1:
                    let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
                    webViewController.titleString = title0
                    webViewController.url = "https://www.instagram.com/"
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: webViewController)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 2:
                    let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
                    webViewController.titleString = title0
                    webViewController.url = "https://www.mediawiki.org/wiki/MediaWiki"
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: webViewController)
                    getNav.present( rootNavView, animated: true, completion: nil)
                default:
                    break
                }
            case 1:
                switch indexPath.row {
                case 0:
                    let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: aboutVC)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 1:
                    SKStoreReviewController.requestReview()
                case 2:
                     self.showReportMessagePopup()
                case 3:
                    let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
                    webViewController.titleString = "Conditions Générales de Ventes"
                    webViewController.url = "https://www.apple.com"
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: webViewController)
                    getNav.present( rootNavView, animated: true, completion: nil)
                case 4:
                    let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
                    webViewController.titleString = "Politique de Confidentialité"
                    webViewController.url = "https://www.apple.com"
                    guard let getNav = UIApplication.topViewController()?.navigationController else {
                        return
                    }
                    let rootNavView = UINavigationController(rootViewController: webViewController)
                    getNav.present( rootNavView, animated: true, completion: nil)
                default:
                    break
                }
            default:
                break
            }
        }
    }
}
// MARK: - Table Footer Configuration
extension AboutUsVC {
    func FooterConfiguration() {
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.height)
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.frame = footerView.frame
    }
}
// MARK: - Report Popup
extension AboutUsVC {
    func showReportMessagePopup() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Messages.txtSettingReportBug, message: Messages.bugReportTitle, preferredStyle: .alert)
            let saveAction = UIAlertAction(title: Messages.txtSettingSend, style: .destructive, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                if firstTextField.text?.trim().count == 0 {
                    Common.showAlertMessage(message: Messages.txtSettingBugDetail, alertType: .error)
                    return
                }
               // self.apiBugReport(firstTextField.text!)
            })
            let cancelAction = UIAlertAction(title: Messages.txtDeleteCancel, style: .default, handler: { (action : UIAlertAction!) -> Void in
    
            })
            alertController.addTextField { (textField : UITextField!) -> Void in
                saveAction.isEnabled = false
                textField.placeholder = Messages.txtSettingReportTextField
                textField.autocapitalizationType = .sentences
                textField.isEnabled = false
                NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using: {_ in
                        let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                        let textIsNotEmpty = textCount > 0
                        saveAction.isEnabled = textIsNotEmpty
                })
            }
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: {
                let firstTextField = alertController.textFields![0] as UITextField
                firstTextField.isEnabled = true
                firstTextField.becomeFirstResponder()
            })
        }
    }
}

// MARK: - TableView Cell Class
class AboutCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
}
class AboutCell1: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
}
