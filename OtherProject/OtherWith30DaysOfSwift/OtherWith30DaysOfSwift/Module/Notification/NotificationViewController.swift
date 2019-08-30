//
//  NotificationViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/8/27.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (accepted, errir) in
            if !accepted {
                print("Notification authorization denied")
            }
        }
        
        let action = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: [.destructive])
        let category = UNNotificationCategory(identifier: "category", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        self.view.backgroundColor = .white
        let datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(didPickDate(_:)), for: .valueChanged)
        self.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc func didPickDate(_ sender: UIDatePicker) {
        scheduleNotification(date: sender.date)
    }
    
    func scheduleNotification(date: Date) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print(settings)
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let dateComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "This is title"
        content.body = "This is body"
        content.sound = .default
        content.categoryIdentifier = "category"
        
        let request = UNNotificationRequest(identifier: "requestNotificationIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}

extension NotificationViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "remindLater" {
            let date = Date(timeInterval: 60, since: Date())
            scheduleNotification(date: date)
        }
    }
}
