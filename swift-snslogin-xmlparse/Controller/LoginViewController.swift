//
//  LoginViewController.swift
//  swift-snslogin-xmlparse
//
//  Created by macbook on 2021/03/06.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    var provider:OAuthProvider?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang":"ja"]

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    

    
    @IBAction func twitterLogin(_ sender: Any) {
        self.provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["force_login":"true"]
        provider?.getCredentialWith(nil, completion: { (credential, error) in
            
            //ActivityIndicatorView
            let activityView = NVActivityIndicatorView(frame: self.view.bounds, type: .ballBeat, color: .magenta, padding: .none)
            self.view.addSubview(activityView)
            activityView.startAnimating()
            
            //ログイン
            Auth.auth().signIn(with: credential!) { (result, error) in
                
                if error != nil {
                    return
                }
                
                activityView.stopAnimating()
                
                //画面遷移
                let viewVC = self.storyboard?.instantiateViewController(identifier: "viewVC") as! ViewController
                
                viewVC.userName = (result?.user.displayName)!
                
                self.navigationController?.pushViewController(viewVC, animated: true)
                
            }
            
        })
    }
    
}
