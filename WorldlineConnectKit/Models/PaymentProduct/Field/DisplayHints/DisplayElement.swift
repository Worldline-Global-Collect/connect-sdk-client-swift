//
//  DisplayElement.swift
//  Pods
//
//  Created for Worldline Global Collect on 07/07/2017.
//
//

import Foundation

public class DisplayElement: Codable {
    public var id: String
    public var type: DisplayElementType
    public var value: String

    internal init(id: String, type: DisplayElementType, value: String) {
        self.id = id
        self.type = type
        self.value = value
    }
}
