//
//  EditAccountVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 08/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class EditAccountVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    // MARK: - Properties
    let picker = ADCountryPicker()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.EditAccountTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        picker.searchBarBackgroundColor = UIColor.white
        picker.hidesNavigationBarWhenPresentingSearch = false
        picker.defaultCountryCode = "FR"
        picker.delegate = self
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Action Method
extension EditAccountVC {
    @IBAction func action_CountryPicker(_ sender: UIControl) {
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    @IBAction func action_ChangeMyPassword(_ sender: UIControl) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "EditPasswordVC") as! EditPasswordVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    @IBAction func action_SponsorshipCode(_ sender: UIControl) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ajouter un code parrainage", message: "Ajouter un code parrainage", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Ajouter un code parrainage"
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
// MARK: - Country Picker Delegate
extension EditAccountVC: ADCountryPickerDelegate {
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        lblCountryCode.text = "\(dialCode)"
        picker.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.txtMobile.becomeFirstResponder()
            }
        }
    }
}
