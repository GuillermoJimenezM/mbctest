//
//  Environment.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import Foundation

fileprivate enum PlistKeys: String, CaseIterable {
    case endpointUrl = "ENDPOINT_URL"
    case apiVersion = "API_VERSION"
    case apiSecretKey = "API_SECRET_KEY"
    case apiClientId = "API_CLIENT_ID"
}

final class CurrentEnvironment: NSObject {
    @objc var endpointUrl: String = ""
    @objc var apiVersion: String = ""
    @objc var apiClientId: String = ""
    @objc var apiSecretKey: String = ""
    static let shared = CurrentEnvironment()

    private override init() {
        super.init()

        for configuration in PlistKeys.allCases {
            if let keyValue = self.infoDictionary[configuration.rawValue] {

                if self.responds(to: Selector("\(configuration)")) {
                    self.setValue(keyValue, forKey: "\(configuration)")
                } else {
                    print("Property \(configuration.rawValue) was not found on class CurrentEnvironment")
                }
            }
            else {
                print("\(configuration.rawValue) was not found in plist for class CurrentEnvironment")
            }
        }
    }

    private let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            print("Plist file not found")
            return [:]
        }
        return dict
    }()

    let bundleAppIdentifier: String = {
        return Bundle.main.bundleIdentifier ?? ""
    }()

    let AppVersion: String = {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }()

    let AppBuild: String = {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }()
}
