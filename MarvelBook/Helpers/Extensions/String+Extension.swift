//
//  String+Extension.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import CommonCrypto
import UIKit

import CryptoKit

extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
