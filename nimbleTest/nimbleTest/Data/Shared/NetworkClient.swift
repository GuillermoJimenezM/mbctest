//
//  NetworkClient.swift
//  nimbleTest
//
//  Created by Guillermo Jimenez on 2/11/23.
//

import Foundation

final class NetworkClient {

    static var shared: NetworkClient = NetworkClient()

    /// Performs a GET request to a specified API endpoint and decodes the response into a Swift type.
    ///
    /// Use this function to make a GET request to a web service API and decode the response
    /// into a specified Swift type conforming to the `Decodable` protocol.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to which the GET request will be made.
    ///   - headers: Optional HTTP headers to include in the request.
    ///   - saveToken: A Boolean value indicating whether to save the authentication token (if applicable).
    ///
    /// - Returns: The decoded result of the GET request as a Swift type conforming to `Decodable`.
    ///
    /// - Throws:
    ///   - An error of type `NetworkError` if the request fails or the response cannot be decoded.
    ///   - An error of type `TokenError` if there's an issue with saving the authentication token (if `saveToken` is true).
    func get <T: Decodable>(
        endpoint: String,
        headers: [String: String] = [:],
        saveToken: Bool = false
    ) async throws -> T {

        let url = try self.buildUrl(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        addHeaders(urlRequest: &request, headers: headers)

        do {

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let responseData = response as? HTTPURLResponse else {
                throw ApiError.invalidServerResponse
            }

            switch responseData.statusCode {
                case 200..<300:

                    print("Response body ===========================")
                    print("\(String(decoding: data, as: UTF8.self))")
                    print("=========================================")

                    handleAuthToken(with: responseData, saveToken: saveToken)

                    let parsedResponseBody = try JSONDecoder().decode(T.self, from: data)
                    return parsedResponseBody

                case 400..<500:
                
                    throw ApiError.tempError

                default:
                    throw ApiError.tempError
            }
        } catch {
            print(error)
            throw error
        }
    }

    /// Performs an asynchronous HTTP POST request.
    ///
    /// - Parameters:
    ///   - endpoint: The URL endpoint to which the POST request will be made.
    ///   - headers: Optional custom HTTP headers to include with the request. Default is an empty dictionary.
    ///   - saveToken: A boolean value indicating whether to save the token. Default is `false`.
    ///   - requestBody: The data to be included in the body/ Must conform to the Encodable protocol.
    ///
    /// - Returns: A decoded object of type `T` representing the response data from the server.
    ///
    /// - Throws: An error of type `Error` if the request encounters an issue or if decoding the response fails.
    ///
    /// - Note: This function uses Swift's asynchronous programming features, allowing non-blocking network requests.
    ///
    /// - Example:
    ///   ```
    ///   let requestBody = MyRequestStruct(...)
    ///   do {
    ///       let response: MyResponseStruct = try await post(endpoint: "https://example.com/api/resource",
    ///       requestBody: requestBody)
    ///       // Handle response
    ///   } catch {
    ///       // Handle error
    ///   }
    ///   ```
    func post <T: Decodable, Q: Encodable>(
        endpoint: String,
        headers: [String: String] = [:],
        saveToken: Bool = false,
        requestBody: Q
    ) async throws -> T {

        let url = try self.buildUrl(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post.rawValue
        addHeaders(urlRequest: &request, headers: headers)

        do {

            let encodedBody = try JSONEncoder().encode(requestBody)

#if DEBUG
            if let jsonRequest = String(data: encodedBody, encoding: .utf8) {
                print("Request body ============================")
                print("\(jsonRequest)")
                print("=========================================")
            }
#endif
            request.httpBody = encodedBody

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let responseData = response as? HTTPURLResponse else {
                throw ApiError.invalidServerResponse
            }

#if DEBUG
            print("Response body ===========================")
            print("\(String(decoding: data, as: UTF8.self))")
            print("=========================================")
#endif

            switch responseData.statusCode {
                case 200..<300:

                    handleAuthToken(with: responseData, saveToken: saveToken)

                    let parsedResponseBody = try JSONDecoder().decode(T.self, from: data)
                    return parsedResponseBody

                case 400..<500:

                    throw ApiError.tempError

                default:
                    throw ApiError.tempError
            }
        } catch {
            print(error)
            throw error
        }
    }

    /// Performs an asynchronous HTTP POST request.
    ///
    /// - Parameters:
    ///   - endpoint: The URL endpoint to which the POST request will be made.
    ///   - headers: Optional custom HTTP headers to include with the request. Default is an empty dictionary.
    ///   - saveToken: A boolean value indicating whether to save the token. Default is `false`.
    ///   - requestBody: The data to be included in the body/ Must conform to the Encodable protocol.
    ///
    /// - Returns: A decoded object of type `T` representing the response data from the server.
    ///
    /// - Throws: An error of type `Error` if the request encounters an issue or if decoding the response fails.
    ///
    /// - Note: This function uses Swift's asynchronous programming features, allowing non-blocking network requests.
    ///
    /// - Example:
    ///   ```
    ///   let requestBody = MyRequestStruct(...)
    ///   do {
    ///       let response: MyResponseStruct = try await post(endpoint: "https://example.com/api/resource",
    ///       requestBody: requestBody)
    ///       // Handle response
    ///   } catch {
    ///       // Handle error
    ///   }
    ///   ```
    func post <Q: Encodable>(
        endpoint: String,
        headers: [String: String] = [:],
        saveToken: Bool = false,
        requestBody: Q
    ) async throws {

        let url = try self.buildUrl(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post.rawValue
        addHeaders(urlRequest: &request, headers: headers)

        do {

            let encodedBody = try JSONEncoder().encode(requestBody)

#if DEBUG
            if let jsonRequest = String(data: encodedBody, encoding: .utf8) {
                print("Request body ============================")
                print("\(jsonRequest)")
                print("=========================================")
            }
#endif
            request.httpBody = encodedBody

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let responseData = response as? HTTPURLResponse else {
                throw ApiError.invalidServerResponse
            }

#if DEBUG
            if !data.isEmpty {
                print("Response body ===========================")
                print("\(String(decoding: data, as: UTF8.self))")
                print("=========================================")

            }
#endif

            switch responseData.statusCode {
                case 200..<300:
                    handleAuthToken(with: responseData, saveToken: saveToken)

                case 400..<500:
                    throw ApiError.tempError

                default:
                    throw ApiError.tempError
            }
        } catch {
            print(error)
            throw error
        }
    }

    /// Performs an asynchronous HTTP PUT request.
    ///
    /// - Parameters:
    ///   - endpoint: The URL endpoint to which the PUT request will be made.
    ///   - headers: Optional custom HTTP headers to include with the request. Default is an empty dictionary.
    ///   - requestBody: The data to be included in the body of the PUT request. Must conform to the Encodable protocol.
    ///
    /// - Returns: A decoded object of type `T` representing the response data from the server.
    ///
    /// - Throws: An error of type `Error` if the request encounters an issue or if decoding the response fails.
    ///
    /// - Note: This function uses Swift's asynchronous programming features, allowing non-blocking network requests.
    ///
    /// - Example:
    ///   ```
    ///   let requestBody = MyRequestStruct(...)
    ///   do {
    ///       let response: MyResponseStruct = try await put(endpoint: "https://example.com/api/resource",
    ///       requestBody: requestBody)
    ///       // Handle response
    ///   } catch {
    ///       // Handle error
    ///   }
    ///   ```
    func put <T: Decodable, Q: Encodable>(
        endpoint: String,
        headers: [String: String] = [:],
        saveToken: Bool = false,
        requestBody: Q
    ) async throws -> T {

        let url = try self.buildUrl(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.put.rawValue
        self.addHeaders(urlRequest: &request, headers: headers)

        do {

            let encodedBody = try JSONEncoder().encode(requestBody)

#if DEBUG
            if let jsonRequest = String(data: encodedBody, encoding: .utf8) {
                print("Request body ============================")
                print("\(jsonRequest)")
                print("=========================================")
            }
#endif

            request.httpBody = encodedBody

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let responseData = response as? HTTPURLResponse else {
                throw ApiError.invalidServerResponse
            }

#if DEBUG
            print("Response body ===========================")
            print("\(String(decoding: data, as: UTF8.self))")
            print("=========================================")
#endif

            switch responseData.statusCode {
                case 200..<300:

                    handleAuthToken(with: responseData, saveToken: saveToken)
                    let parsedResponseBody = try JSONDecoder().decode(T.self, from: data)
                    return parsedResponseBody

                case 400..<500:
                    throw ApiError.tempError
                default:
                    throw ApiError.tempError
            }
        } catch {
            print(error)
            throw error
        }
    }

    fileprivate func buildUrl(_ url: String) throws -> URL {
        guard let parsedUrl = URL(string: url) else {
            throw ApiError.invalidURL
        }
#if DEBUG
        print(parsedUrl)
#endif
        return parsedUrl
    }

    fileprivate func addHeaders(urlRequest: inout URLRequest, headers: [String: String]) {
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func handleAuthToken(with responseData: HTTPURLResponse, saveToken: Bool) {

        if !saveToken {
            return
        }

        if let tokenHeader = responseData.allHeaderFields["Authorization"],
           let parsedToken = tokenHeader as? String {
          //  TokenHandlingService.shared.saveToken(bearerToken: parsedToken)
        }
    }
}
