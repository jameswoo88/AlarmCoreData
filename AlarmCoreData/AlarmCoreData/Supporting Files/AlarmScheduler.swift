//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by James Chun on 4/29/21.
//

import Foundation
import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {
        guard let fireDate = alarm.fireDate,
              let alarmTitle = alarm.title,
              let identifier = alarm.uuidString else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "It is time for: \(alarmTitle)"
        content.sound = .default
        
        let dateCompoments = Calendar.current.dateComponents([.hour, .minute], from: fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompoments, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        guard let identifier = alarm.uuidString else { return }
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
    }
    
}//End of extension
