//
//  ViewController.swift
//  CombinePractice
//
//  Created by 竹ノ内愛斗 on 2020/09/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let notificationCenter = NotificationCenter.default

    private var subscribers = Set<AnyCancellable>()
    @Published private var height: Double?
    @Published private var weight: Double?

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        observeTextFields()
    }

    private func observeTextFields() {
        notificationCenter
            .publisher(for: UITextField.textDidChangeNotification, object: heightTextField).sink {
                guard let textField = $0.object as? UITextField,
                      let text = textField.text,
                      !text.isEmpty,
                      let height = Double(text) else {
                    self.height = nil
                    return }
                print(height)
                self.height = height
            }.store(in: &subscribers)

        notificationCenter
            .publisher(for: UITextField.textDidChangeNotification, object: weightTextField).sink {
                guard let textField = $0.object as? UITextField,
                      let text = textField.text,
                      !text.isEmpty,
                      let weight = Double(text) else { self.weight = nil
                    return }
                print(weight)
                self.weight = weight
            }.store(in: &subscribers)

        Publishers.CombineLatest($height, $weight).sink {[weak self] (height, weight) in
            guard let this = self else { return }
            guard let height = height, let weight = weight else {
                this.resultLabel.text = ""
                return
            }
            this.resultLabel.text = "h: \(height), w: \(weight)"

        }.store(in: &subscribers)
    }
}

