//
//  InputMaskProtocol.swift
//  Formatter
//
//  Created by Emil Shpeklord on 23.05.2022.
//

import UIKit

public protocol InputMaskProtocol {
    func formattedString(from plainString: String) -> String
    func mask(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool
}
