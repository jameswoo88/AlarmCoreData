//
//  Date Extension.swift
//  AlarmCoreData
//
//  Created by James Chun on 4/29/21.
//

import Foundation

extension Date {
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: self)
    }
    
}//End of extension
