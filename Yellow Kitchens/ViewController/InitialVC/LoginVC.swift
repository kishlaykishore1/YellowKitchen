//
//  LoginVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 03/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lblTermNPolicy: TTTAttributedLabel!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.LoginTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
}

// MARK: - Action Method
extension LoginVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_ContinueWithApple(_ sender: UIControl) {
    }
    @IBAction func action_ContinueWithGoogle(_ sender: UIControl) {
    }
    @IBAction func action_ContinueWithFacebook(_ sender: UIControl) {
    }
    @IBAction func action_ContinueWithEmail(_ sender: UIControl) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "SignUpWithEmailVC") as! SignUpWithEmailVC
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
// MARK: - TermsOfUse Label Set
extension LoginVC {
    func setup() {
        lblTermNPolicy.numberOfLines = 0
        let strPP = "Politique de confidentialité"
        let strTC = "Conditions générales d'utilisation."
        let string = "En appuyant sur Continuer vous reconnaissez avoir lu notre \(strPP) et vous acceptez nos \(strTC)"
        let nsString = string as NSString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 11) ?? UIFont()
        ])
        lblTermNPolicy.textAlignment = .center
        lblTermNPolicy.attributedText = fullAttributedString
        let rangeTC = nsString.range(of: strTC)
        let rangePP = nsString.range(of: strPP)
        let ppLinkAttributes: [String: Any] = [
            NSAttributedString.Key.foregroundColor.rawValue: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.underlineStyle.rawValue: false,
            NSAttributedString.Key.font.rawValue: UIFont.init(name: "Poppins-SemiBold", size: 11) ?? UIFont()
        ]
        lblTermNPolicy.activeLinkAttributes = ppLinkAttributes
        lblTermNPolicy.linkAttributes = ppLinkAttributes
        let urlTC = URL(string: "action://TC")!
        let urlPP = URL(string: "action://PP")!
        lblTermNPolicy.addLink(to: urlTC, with: rangeTC)
        lblTermNPolicy.addLink(to: urlPP, with: rangePP)
        lblTermNPolicy.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblTermNPolicy.delegate = self
    }
}
// MARK: - TTTAttributedLabelDelegate
extension LoginVC: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString == "action://TC" {
            let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            webViewController.titleString = "Conditions générales d'utilisation"
            webViewController.url = "https://www.apple.com"
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present(rootNavView, animated: true, completion: nil)
        } else {
            let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            webViewController.titleString = "Politique de confidentialité"
            webViewController.url = "https://www.apple.com"
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
}
