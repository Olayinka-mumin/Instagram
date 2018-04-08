//
//  ViewController.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/13/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var textfields: [UITextField]!
    
    
    @IBOutlet weak var passwordValidationLabel: UILabel!;
    
    private var authHandler = AuthHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateUI();
        usernameTextField.delegate = self;
        passwordTextField.delegate = self;
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil);
        loginButton.backgroundColor = UIColor(red: 152/255, green: 204/255, blue: 244/255, alpha: 1);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateUI() {
        usernameView.layer.cornerRadius = 5;
        usernameView.layer.masksToBounds = false;
        usernameView.layer.borderColor = UIColor(red: 0.203, green: 0.203, blue: 0.203, alpha: 0.3).cgColor;
        usernameView.layer.borderWidth = 1.0;
        
        passwordView.layer.cornerRadius = 5;
        passwordView.layer.borderColor = UIColor(red: 0.203, green: 0.203, blue: 0.203, alpha: 0.3).cgColor;
        passwordView.layer.borderWidth = 1.0;
        passwordView.layer.masksToBounds = false;
        
        loginButton.layer.cornerRadius = 5;
        
        passwordValidationLabel.isHidden = true;
        loginButton.isEnabled = false;
    }
    

    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true;
        
        for textfield in textfields {
            let (valid, _) = validate(textfield);
            guard valid else {
                formIsValid = false;
                break;
            }
        }
        loginButton.isEnabled = formIsValid;
        loginButton.backgroundColor = formIsValid ? UIColor(red: 0/255, green: 126/255, blue: 246/255, alpha: 1) : UIColor(red: 152/255, green: 204/255, blue: 244/255, alpha: 1);
    }
    
    @IBAction func signUpSegue(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signUpSegue", sender: nil);
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        authHandler.login(username: usernameTextField.text!, password: passwordTextField.text!);
        alertUser(titles: authHandler.title!, message: authHandler.message!);
    }
    
    func alertUser(titles: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);

        if titles == "Success" {
            let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
                self.performSegue(withIdentifier: "signedUpSegue", sender: self);
            }
            alert.addAction(ok)
        } else {
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil);
            alert.addAction(ok);
        }
        
        present(alert, animated: true, completion: nil);
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            let (valid, message) = validate(textField);
            if valid {
                passwordTextField.becomeFirstResponder();
            } else {
                self.passwordValidationLabel.text = message;
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.passwordValidationLabel.isHidden = valid;
            })
        case passwordTextField:
            let (valid, message) = validate(textField);
            if valid {
                passwordTextField.resignFirstResponder()
            }
            self.passwordValidationLabel.text = message;
            UIView.animate(withDuration: 0.25, animations: {
                self.passwordValidationLabel.isHidden = valid;
            })
        default:
            textField.resignFirstResponder();
        }
        return true;
    }
    
    fileprivate func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil);
        }
        if textField == passwordTextField {
            return (text.count >= 6, "Your password is too short");
        } else if textField == usernameTextField {
            return (text.count > 0, "Username field cannot be empty")
        }
        return (text.count > 0, "This field cannot be empty");
    }
}



