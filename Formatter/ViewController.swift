//
//  ViewController.swift
//  Formatter
//
//  Created by Emil Shpeklord on 23.05.2022.
//

import UIKit

class ViewController: UIViewController {

    private var formatter: Formatter?
    private var numberFormatter: NumberFormatter?

    private let pattern: String = "A###-***"
    private let numberPattern: String = "DDD+DD-DD"

    private lazy var textField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 25)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.isAccessibilityElement = true
        textField.keyboardType = .numberPad
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        setUpUI()
        formatter = Formatter(pattern: pattern)
        numberFormatter = NumberFormatter(pattern: numberPattern)


    }

    private func setUpUI() {
        view.backgroundColor = .blue
        view.addSubview(textField)

        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16).isActive = true
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let formatter = formatter else { return true }
//        return formatter.mask(textField, range: range, replacementString: string)
        guard let numberFormatter = numberFormatter else { return true }
        return numberFormatter.mask(textField, range: range, replacementString: string)
    }
}
