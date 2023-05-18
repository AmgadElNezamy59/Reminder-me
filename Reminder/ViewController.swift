
//  Created by Amgad ElNezamy on 10/02/2023.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var reminderTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func notificationPressedButton(_ sender: UIButton) {
        if reminderTextField.text != nil {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
                if granted{
                    print("Accepted")
                    DispatchQueue.main.async {
                        self.scheduleNotification()
                    }
                 
                }else{
                    print("denied")
                }
            }
        }
    }
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Its time to "
        content.body = reminderTextField.text!
        content.sound = .default
        content.badge = 1
        reminderTextField.text = ""
        
        
        let date = datePicker.date
        let trigger = UNCalendarNotificationTrigger (dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date), repeats: false)
        
        let request = UNNotificationRequest(identifier: "TestID", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
}

