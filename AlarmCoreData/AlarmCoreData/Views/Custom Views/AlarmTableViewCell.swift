//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by James Chun on 4/29/21.
//

import UIKit

//MARK: - Protocol
protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - Properties
    weak var delegate: AlarmTableViewCellDelegate?
    
    //MARK: - Actions
    @IBAction func isEnabledSwitchToggled(_ sender: Any) {
        delegate?.alarmWasToggled(sender: self)
    }
    
    //MARK: - Functions
    func updateViews(withAlarm alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate!.formatToString()
        isEnabledSwitch.isOn = alarm.isEnabled
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //JCHUN -
    }
    
}//End of class
