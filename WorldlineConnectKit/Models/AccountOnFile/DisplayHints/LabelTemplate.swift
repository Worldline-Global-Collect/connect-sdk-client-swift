//
//  LabelTemplate.swift
//  WorldlineConnectKit
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2016 Worldline Global Collect. All rights reserved.
//

import Foundation

public class LabelTemplate {

    public var labelTemplateItems = [LabelTemplateItem]()

    public func mask(forAttributeKey key: String) -> String? {
        for labelTemplateItem in labelTemplateItems where labelTemplateItem.attributeKey.isEqual(key) {
            return labelTemplateItem.mask
        }
        return nil
    }

}
