//
//  NumberFormatter.swift
//  Formatter
//
//  Created by Emil Shpeklord on 23.05.2022.
//

import UIKit

final class NumberFormatter {

    // MARK: - Properties

    private var pattern: String

    private let digit: Character = "D"

    // MARK: - Lifecycle

    public init(pattern: String) {
        self.pattern = pattern
    }
}

extension NumberFormatter: InputMaskProtocol {
    public func mask(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
        let string = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let formatted = formattedString(from: string)
        textField.text = formatted
        return formatted.isEmpty
    }

    public func formattedString(from plainString: String) -> String {
        guard !pattern.isEmpty else { return plainString }

        let pattern: [Character] = Array(self.pattern) // making array of chars
        let allowedCharachters = CharacterSet.decimalDigits // allows only digits
        let filteredInput = String(plainString.unicodeScalars.filter(allowedCharachters.contains))
        // takin a unicode representation of string
        // filtering the string
        let input: [Character] = Array(filteredInput) // making an array of our new string
        var formatted: [Character] = [] //making a result array

        var patternIndex = 0
        var inputIndex = 0

        while inputIndex < input.count {
            let inputCharacter = input[inputIndex]

            guard patternIndex < pattern.count else { break } // stops cycle when users string is longer than pattern

            if pattern[patternIndex] != digit {
                formatted.append(pattern[patternIndex])
                patternIndex += 1
                continue
            }

            guard inputCharacter.unicodeScalars.allSatisfy(allowedCharachters.contains) else { // checks if user char is allowed
                inputIndex += 1
                continue
            }

            formatted.append(inputCharacter)
            patternIndex += 1
            inputIndex += 1
        }

        return String(formatted)
    }
}
