//
//  StringUtils.swift
//  RandomUser
//
//  Created by Anca Arhip on 01.08.2024.
//

import Foundation

extension String {
    func timeWithGMTOffset() -> String? {
        let now = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let components = self.split(separator: ":").map { String($0) }
        guard components.count == 2,
              let hours = Int(components[0].replacingOccurrences(of: "+", with: "")),
              let minutes = Int(components[1]) else {
            return nil
        }
        
        let totalOffsetSeconds = (hours * 3600) + (minutes * 60)
        
        let offsetInSeconds = self.hasPrefix("-") ? -totalOffsetSeconds : totalOffsetSeconds
        
        let offsetDate = Calendar.current.date(byAdding: .second, value: offsetInSeconds, to: now)
        
        guard let dateWithOffset = offsetDate else { return nil }
        return formatter.string(from: dateWithOffset)
    }
}
