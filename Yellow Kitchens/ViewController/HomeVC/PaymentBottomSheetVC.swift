//
//  PaymentBottomSheetVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 17/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class PaymentBottomSheetVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblConfirmNpay: TTTAttributedLabel!
    @IBOutlet weak var btnConfirmPay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let baseString = "Confirmer et payer 74,90€"
        let attributedString = NSMutableAttributedString(string: baseString, attributes: nil)
        let str = (attributedString.string as NSString).range(of: "Confirmer et payer ")
        let str1 = (attributedString.string as NSString).range(of: "74,90€")
        attributedString.setAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 14.0)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)], range: str)
        attributedString.setAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 14.0)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)], range: str1)
        btnConfirmPay.setAttributedTitle(attributedString, for: .normal)
    }
    @IBAction func action_MeansOfPayment(_ sender: UIControl) {
        self.dismiss(animated: true) {
            let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "ChoosePaymentVC") as! ChoosePaymentVC
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            if #available(iOS 13.0, *) {
                aboutVC.isModalInPresentation = true
            }
            let rootNavView = UINavigationController(rootViewController: aboutVC)
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
    @IBAction func action_ConfirmAndPay(_ sender: UIButton) {
        self.dismiss(animated: true) {
            let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "NewOrderVC") as! NewOrderVC
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            if #available(iOS 13.0, *) {
                aboutVC.isModalInPresentation = true
            }
            let rootNavView = UINavigationController(rootViewController: aboutVC)
            rootNavView.modalPresentationStyle = .fullScreen
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
    @IBAction func atction_ChooseAddress(_ sender: UIControl) {
        self.dismiss(animated: true) {
            let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "ChooseAddressVC") as! ChooseAddressVC
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            if #available(iOS 13.0, *) {
                aboutVC.isModalInPresentation = true
            }
            let rootNavView = UINavigationController(rootViewController: aboutVC)
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
}
// MARK: - TermsOfUse Label Set
extension PaymentBottomSheetVC: TTTAttributedLabelDelegate {
    func setup() {
        lblConfirmNpay.numberOfLines = 0
        let strPP = "Confirmer et payer"
        let string = "En cliquant sur \(strPP) vous acceptez nos Conditions Générales de Vente."
        let nsString = string as NSString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
            NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 11) ?? UIFont()
        ])
        lblConfirmNpay.textAlignment = .center
        lblConfirmNpay.attributedText = fullAttributedString
        let rangePP = nsString.range(of: strPP)
        let ppLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1),
            NSAttributedString.Key.underlineStyle.rawValue: false,
            NSAttributedString.Key.font.rawValue: UIFont.init(name: "Poppins-SemiBold", size: 11) ?? UIFont()
        ]
        lblConfirmNpay.activeLinkAttributes = ppLinkAttributes
        lblConfirmNpay.linkAttributes = ppLinkAttributes
        let urlPP = URL(string: "action://PP")!
        lblConfirmNpay.addLink(to: urlPP, with: rangePP)
        lblConfirmNpay.textColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        lblConfirmNpay.delegate = self
    }
}
