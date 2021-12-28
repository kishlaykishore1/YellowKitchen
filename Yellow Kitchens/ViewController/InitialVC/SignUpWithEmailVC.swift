//
//  SignUpWithEmailVC.swift
//  Yellow Kitchens
//
//  Created by angrej singh on 04/09/20.
//  Copyright © 2020 com.agency55. All rights reserved.
//

import UIKit

class SignUpWithEmailVC: UIViewController {
    // MARK: - OutLets
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var lblTermNPolicy: TTTAttributedLabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var btnSignUpSignIn: UIButton!
    @IBOutlet weak var passwordViewHeight: NSLayoutConstraint!
    @IBOutlet weak var forgotPasswordHeight: NSLayoutConstraint!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let attr = NSDictionary(object: UIFont(name: "Poppins-Medium", size: 16.0)!, forKey: NSAttributedString.Key.font as NSCopying)
        segmentView.setTitleTextAttributes(attr as [NSObject : AnyObject] as? [NSAttributedString.Key : Any] , for: .normal)
        setNavShadow(shadowRadius: 4.0, shadowOpacity: 0.15, shadowColor: UIColor.black.cgColor)
        passwordViewHeight.constant = 24
        forgotPasswordHeight.constant = 0
        segmentView.addTarget(self, action: #selector(changeAndRepeat(sender:)), for:.allEvents)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = Messages.SignUpTitle
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 15)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    }
}

// MARK: - Action Method
extension SignUpWithEmailVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func changeAndRepeat(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            passwordViewHeight.constant = 24
            forgotPasswordHeight.constant = 0
            btnForgotPass.isHidden = true
            passwordView.isHidden = true
            lblTermNPolicy.isHidden = false
            btnSignUpSignIn.setTitle("Inscription avec email", for: .normal)
            btnSignUpSignIn.borderWidth = 0.5
        } else {
            passwordViewHeight.constant = 56
            forgotPasswordHeight.constant = 30
            btnForgotPass.isHidden = false
            passwordView.isHidden = false
            lblTermNPolicy.isHidden = true
            btnSignUpSignIn.setTitle("Connexion à votre compte", for: .normal)
            btnSignUpSignIn.borderWidth = 0
        }
    }
    @IBAction func action_ForgotPassword(_ sender: UIButton) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "EditPasswordVC") as! EditPasswordVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    @IBAction func action_SignUpSignIn(_ sender: UIButton) {
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "CartVC") as! CartVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}
// MARK: - TermsOfUse Label Set
extension SignUpWithEmailVC {
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
extension SignUpWithEmailVC: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString == "action://TC" {
            let webViewController: WebViewVC = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
            webViewController.titleString = "Conditions générales d'utilisation"
            webViewController.url = "https://www.apple.com"
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
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
