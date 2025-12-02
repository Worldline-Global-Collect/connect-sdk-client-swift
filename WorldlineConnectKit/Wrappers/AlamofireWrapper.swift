//
//  AlamofireWrapper.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireWrapper {

    static let shared = AlamofireWrapper()

    func getResponse<T: Codable>(forURL URL: String,
                                          headers: HTTPHeaders?,
                                          withParameters parameters: Parameters? = nil,
                                          additionalAcceptableStatusCodes: IndexSet?,
                                          success: @escaping ((responseObject: T?, statusCode: Int?)) -> Void,
                                          failure: @escaping (_ error: Error) -> Void,
                                          apiFailure: @escaping (_ errorResponse: ApiErrorResponse) -> Void
    ) {
        let acceptableStatusCodes = NSMutableIndexSet(indexesIn: NSRange(location: 200, length: 100))
        if let additionalAcceptableStatusCodes = additionalAcceptableStatusCodes {
            acceptableStatusCodes.add(additionalAcceptableStatusCodes)
        }

        AF.request(URL, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: acceptableStatusCodes)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    if error.responseCode != nil {
                        // Error related to unacceptable status code
                        // If decoding fails, return a failure instead of api failure
                        guard let apiError =
                                try? JSONDecoder().decode(ApiErrorResponse.self, from: response.data ?? Data()) else {
                            failure(error)
                            return
                        }

                        apiFailure(apiError)
                    } else {
                        // Error unrelated to status codes
                        Macros.DLog(
                            message: "Error while retrieving response for URL \(URL): \(error.localizedDescription)"
                        )
                        failure(error)
                    }
                } else {
                    success((response.value, response.response?.statusCode))
                }
            }
    }

    func postResponse<T: Codable>(forURL URL: String,
                                           headers: HTTPHeaders?,
                                           withParameters parameters: Parameters?,
                                           additionalAcceptableStatusCodes: IndexSet?,
                                           success: @escaping ((responseObject: T?, statusCode: Int?)) -> Void,
                                           failure: @escaping (_ error: Error) -> Void,
                                           apiFailure: @escaping (_ errorResponse: ApiErrorResponse) -> Void
    ) {
        let acceptableStatusCodes = NSMutableIndexSet(indexesIn: NSRange(location: 200, length: 100))
        if let additionalAcceptableStatusCodes = additionalAcceptableStatusCodes {
            acceptableStatusCodes.add(additionalAcceptableStatusCodes)
        }

        AF.request(URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: acceptableStatusCodes)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    if error.responseCode != nil {
                        // Error related to unacceptable status code
                        // If decoding fails, return a failure instead of api failure
                        guard let apiError =
                                try? JSONDecoder().decode(ApiErrorResponse.self, from: response.data ?? Data()) else {
                            failure(error)
                            return
                        }

                        apiFailure(apiError)
                    } else {
                        // Error unrelated to status codes
                        Macros.DLog(
                            message: "Error while retrieving response for URL \(URL): \(error.localizedDescription)"
                        )
                        failure(error)
                    }
                } else {
                    success((response.value, response.response?.statusCode))
                }
            }
    }
    // swiftlint:enable function_parameter_count
}
