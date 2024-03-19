//
//  StubUtil.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

@testable import WorldlineConnectKit

class StubUtil: Util {
  override func base64EncodedClientMetaInfo(withAppIdentifier appIdentifier: String?, ipAddress: String?) -> String? {
    return "base64encodedclientmetainfo"
  }
}
