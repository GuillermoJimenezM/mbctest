//
//  String.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 3/11/23.
//

import Foundation

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
    
    func fromLocale() -> String {
        return String.localizedStringWithFormat(NSLocalizedString(self, comment: ""));
    }
}
