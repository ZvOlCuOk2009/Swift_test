//
//  StartViewController.swift
//  Swift_test
//
//  Created by Admin on 20.12.17.
//  Copyright © 2017 Tsvigun Aleksander. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class StartViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.layer.borderColor = UIColor.init(colorLiteralRed: 177/255.0, green: 177/255.0, blue: 177/255.0, alpha: 1).cgColor
        emailTextField.layer.borderColor = UIColor.init(colorLiteralRed: 177/255.0, green: 177/255.0, blue: 177/255.0, alpha: 1).cgColor
        passwordTextField.layer.borderColor = UIColor.init(colorLiteralRed: 177/255.0, green: 177/255.0, blue: 177/255.0, alpha: 1).cgColor
        registrationButton.layer.borderColor = UIColor.init(colorLiteralRed: 177/255.0, green: 177/255.0, blue: 177/255.0, alpha: 1).cgColor
        continueButton.layer.borderColor = UIColor.init(colorLiteralRed: 177/255.0, green: 177/255.0, blue: 177/255.0, alpha: 1).cgColor
        
        navigationController?.isNavigationBarHidden = true
        
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGestureRegognizer)))
        self.profileImageView.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func actionRegistrationButton(_ sender: Any) {
        
        self.showActivityIndicator()
        self.handleRegister()
    }

    @IBAction func actionAuthorizationButton(_ sender: Any) {
        
        self.showActivityIndicator()
        
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            
            if (self.emailTextField.text! == "" && self.passwordTextField.text! == "") {
                self.showAlert(title: "Добавьте имя, почту и пароль")
            } else {
                if (error == nil) {
                    let uid = String(describing: user?.uid)
                    self.openMainVC(uid: uid)
                } else {
                    self.showAlert(title: "Не верный логин или пароль!")
                }
            }
        }
    }
    
    @IBAction func actionForgotPassButton(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) {
            (error) in
            
        }
    }
    
    @IBAction func actionLogInGoogleButton(_ sender: Any) {
        
        
    }
    
    func showActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func openMainVC(uid: String) {
        
        print(uid)
        UserDefaults.standard.set(uid, forKey: "uid")
        let mainViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as UIViewController
        self.present(mainViewController, animated: true, completion: nil)
        self.dismissAlert()
    }
    
    func showAlert(title: String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        self.dismissAlert()
    }
    
    func dismissAlert() {
        activityIndicator.stopAnimating()
    }
}


