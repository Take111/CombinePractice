//
//  FormViewController.swift
//  CombinePractice
//
//  Created by 竹ノ内愛斗 on 2020/09/24.
//

import UIKit
import Combine

class FormViewController: UIViewController {

    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordAgainTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.isEnabled = false
            registerButton.layer.masksToBounds = true
            registerButton.layer.cornerRadius = registerButton.frame.height / 2
        }
    }
}
