//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by James Chun on 4/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    //MARK: - Outlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledbutton: UIButton!

    //MARK: - Properties
    var alarm: Alarm?
    var isAlarmOn: Bool = true
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        isAlarmOn.toggle()
        designIsEnabledButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, !title.isEmpty else { return }
        
        if let alarm = alarm {
            AlarmController.sharedInstance.update(alarm: alarm, newTitle: title, newFireDate: alarmFireDatePicker.date, isEnabled: isAlarmOn)
        } else {
            AlarmController.sharedInstance.createAlarm(withTitle: title, and: alarmFireDatePicker.date)
        }
        
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let alarm = alarm else { return }
        
        alarmFireDatePicker.date = alarm.fireDate ?? Date()
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        designIsEnabledButton()
    }
    
    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabledbutton.backgroundColor = .black
            alarmIsEnabledbutton.setTitle("Enabled", for: .normal)
        case false :
            alarmIsEnabledbutton.backgroundColor = .darkGray
            alarmIsEnabledbutton.setTitle("Disabled", for: .normal)
        }
    }
    

}//End of class
