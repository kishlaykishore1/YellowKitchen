//
//  ContactUsVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 09/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit
import MapKit
class ContactUsVC: UIViewController {
    // MARK: - Outlets
    // MARK: - Properties
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.ContactUsTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnMoveToMap(_ sender: UIView) {
        let lati: CLLocationDegrees = 48.864716
        let longi: CLLocationDegrees = 2.349014
        UIApplication.shared.open(NSURL(string: "http://maps.apple.com/?address=\(lati),\(longi)")! as URL)
    }
    @IBAction func btnMoveToPhone(_ sender: UIView) {
       callThisNo(phone: "1010101010")
    }
    @IBAction func btnMoveToEmail(_ sender: UIView) {
        sendMail(email: "contact@yellow-kitchens.com")
    }
}
