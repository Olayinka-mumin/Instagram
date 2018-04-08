//
//  SignUpVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/20/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var signUpTabCV: UICollectionView!
    @IBOutlet weak var signUpNumberView: UIView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signUpPasswordView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var textFields: [UITextField]!
    
    
    let cellId = "signUpTabCell";
    
    private var authHandler = AuthHandler();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpTabCV.delegate = self;
        signUpTabCV.dataSource = self;
        
        usernameTextField.delegate = self;
        passwordTextField.delegate = self;
        
        updateViewUI();
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0);
        signUpTabCV.selectItem(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: [])
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil);
        
        signUpBtn.isEnabled = false;
//        signUpPasswordView.isHidden = true;
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        var formIsValid = true;
        
        for textfield in textFields {
            let (valid, _) = validate(textfield);
            guard valid else {
                formIsValid = false;
                break;
            }
        }
        signUpBtn.isEnabled = formIsValid;
        signUpBtn.backgroundColor = formIsValid ? UIColor(red: 0/255, green: 126/255, blue: 246/255, alpha: 1) : UIColor(red: 152/255, green: 204/255, blue: 244/255, alpha: 1);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var cellArray = ["Phone", "Email address"];
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SignUpTabCell;
        cell.cellLabel.text = cellArray[indexPath.item];
        return cell;
    }
    
    func updateViewUI() {
        signUpNumberView.layer.cornerRadius = 6;
        signUpNumberView.layer.borderWidth = 1.0;
        signUpNumberView.layer.borderColor = UIColor(red: 0.232, green: 0.232, blue: 0.232, alpha: 0.1).cgColor;
        
        signUpPasswordView.layer.cornerRadius = 6;
        signUpPasswordView.layer.borderWidth = 1.0;
        signUpPasswordView.layer.borderColor = UIColor(red: 0.232, green: 0.232, blue: 0.232, alpha: 0.1).cgColor;
        
        signUpBtn.layer.cornerRadius = 5;
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.item == 1 {
//            signUpNumberView.isHidden = true;
//            signUpPasswordView.isHidden = false;
//        } else {
//            signUpNumberView.isHidden = false;
//            signUpPasswordView.isHidden = true;
//        }
//    }
    
    @IBAction func signInSegue(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signInSegue", sender: nil);
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        authHandler.signUp(username: usernameTextField.text!, password: passwordTextField.text!);
        alertUser(titles: authHandler.title!, message: authHandler.message!);
    }
    
    func alertUser(titles: String, message: String) {
        let alert = UIAlertController(title: titles, message: message, preferredStyle: .alert);

        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            if titles == "Success" {
                self.performSegue(withIdentifier: "signedUpSegue", sender: self);
                print("success");
            } else {
                print("failed");
            }
        }
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            let (valid, message) = validate(textField);
            if valid {
                passwordTextField.becomeFirstResponder();
            } else {
                alertUser(titles: "Invalid Authentication", message: message!)
            }
        case passwordTextField:
            let (valid, message) = validate(textField);
            if valid {
                passwordTextField.resignFirstResponder()
            } else {
                alertUser(titles: "Invalid Authentication", message: message!);
            }
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
            return (text.count > 0, "This field cannot be empty");
        }
        return (text.count > 0, "This field cannot be empty");
    }
}

















