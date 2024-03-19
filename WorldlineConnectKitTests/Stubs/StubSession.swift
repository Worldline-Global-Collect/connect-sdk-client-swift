//
//  StubSession.swift
//  WorldlineConnectKitTests
//
//  Created for Worldline Global Collect on 28/11/2023.
//  Copyright © 2023 Worldline Global Collect. All rights reserved.
//

import UIKit
@testable import WorldlineConnectKit

class StubSession: WorldlineConnectKit.Session {
    override func getLogoByStringURL(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // Create an image existing of only a colour
        // This is done just to have an image available
        let image = UIColor.blue.image()

        completion(image.pngData(), nil, nil)
    }
}
