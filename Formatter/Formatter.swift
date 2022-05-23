//
//  Formatter.swift
//  Formatter
//
//  Created by Emil Shpeklord on 23.05.2022.
//

import UIKit

public class Formatter {

    // MARK: - Properties

    private var pattern: String

    private let digit: Character = "#"
    private let alphabetic: Character = "*"

    // MARK: - Lifecycle

    public init(pattern: String) {
        self.pattern = pattern
    }
}

extension Formatter: InputMaskProtocol {
    public func mask(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
        let string = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let formatted = formattedString(from: string)
        textField.text = formatted
        return formatted.isEmpty
    }

    public func formattedString(from plainString: String) -> String {
        guard !pattern.isEmpty else { return plainString }

        let pattern: [Character] = Array(self.pattern) //making array of chars
        let allowedCharachters = CharacterSet.alphanumerics
        let filteredInput = String(plainString.unicodeScalars.filter(allowedCharachters.contains))
        let input: [Character] = Array(filteredInput)
        var formatted: [Character] = []

        var patternIndex = 0
        var inputIndex = 0

        while inputIndex < input.count {
            let inputCharacter = input[inputIndex]
            let allowed: CharacterSet

            guard patternIndex < pattern.count else { break }

            switch pattern[patternIndex] {
            case digit:
                allowed = .decimalDigits
            case alphabetic:
                allowed = .letters
            default:
                formatted.append(pattern[patternIndex])
                patternIndex += 1
                continue
            }

            guard inputCharacter.unicodeScalars.allSatisfy(allowed.contains) else {
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
