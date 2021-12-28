//
//  ContactUsPartnerVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 09/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class ContactUsPartnerVC: UIViewController {
    // MARK: - Outlets
    // MARK: - Properties
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.ContactUsPartnerTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnMoveToPhone(_ sender: UIView) {
      callThisNo(phone: "1010101010")
    }
    @IBAction func btnMoveToEmail(_ sender: UIView) {
      sendMail(email: "contact@yellow-kitchens.com")
    }
    
}
