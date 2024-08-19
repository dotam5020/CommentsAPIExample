//
//  Extensions.swift
//  CommentsAPIExample
//
//  Created by Thanh Le on 19/08/2024.
//

import Foundation

extension Encodable {
    func toEncodable() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {return [:]}
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let dictionary = jsonObject as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
