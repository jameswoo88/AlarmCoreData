//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by James Chun on 4/29/21.
//

import CoreData

class AlarmController {
    //MARK: - Properties
    static let sharedInstance = AlarmController()
    
    //SOT
    var alarms: [Alarm] {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    //MARK: - Functions
    //CRUD
    func createAlarm(withTitle title: String, and fireDate: Date) {
        let alarm = Alarm(title: title, fireDate: fireDate)
        saveToPersistentStore()
        scheduleUserNotifications(for: alarm)
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        cancelUserNotifications(for: alarm)
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        saveToPersistentStore()
        scheduleUserNotifications(for: alarm)
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        alarm.isEnabled.toggle()
        saveToPersistentStore()
        
        if alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }
    
    func delete(alarm: Alarm) {
        CoreDataStack.context.delete(alarm)
        saveToPersistentStore()
        cancelUserNotifications(for: alarm)
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error as NSError {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}//End of class

extension AlarmController: AlarmScheduler {
    
}//End of extension
