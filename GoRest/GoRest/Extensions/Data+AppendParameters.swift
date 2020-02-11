//
//  UIImageView+DownloadImage.swift
//  GoRest
//
//  Created by Alexander Grishin on 10.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit

extension Data {

    init(parameters: Parameters) {
        self = parameters.map { "\($0.key)=\($0.value)&" }.joined().data(using: .utf8)!
    }
}
