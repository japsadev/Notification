//
//  ViewController.swift
//  Notification
//
//  Created by Salih Yusuf Göktaş on 26.05.2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
	
	@IBOutlet weak var bildirimStyle: UIButton!
	
	var izinKontrol:Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UNUserNotificationCenter.current().delegate = self
		
		UNUserNotificationCenter.current().delegate = self
	   
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (granted,error) in
			
			self.izinKontrol = granted
			
			if granted {
				print("İzin alma işlemi başarılı")
			}else{
				print("İzin alma işlemi başarısız!!!!")
			}
			
		})
		
		bildirimStyle.layer.cornerRadius = 15.0
		bildirimStyle.layer.shadowColor = UIColor.darkGray.cgColor
		bildirimStyle.layer.shadowRadius = 4
		bildirimStyle.layer.shadowOpacity = 0.5
		bildirimStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
	}
	
	@IBAction func bildirimOlustur(_ sender: Any) {
		
		if izinKontrol {
			let icerik = UNMutableNotificationContent()
			icerik.title = "Başlık"
			icerik.subtitle = "Alt Başlık"
			icerik.body = "Mesaj"
			icerik.badge = 1
			icerik.sound = UNNotificationSound.default
			
			var date = DateComponents()
			date.minute = 30
			date.hour = 8               // Her ayın 20 sinde saat 8.30 da bildirim gönderecek
			date.day = 20
			
			let tetikleme = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
			
			// let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
			
			let bildirimİstegi = UNNotificationRequest(identifier: "Bildirim Olusturma", content: icerik, trigger: tetikleme)
			
			UNUserNotificationCenter.current().add(bildirimİstegi, withCompletionHandler: nil)
			
		}
		
	}
	
}

extension ViewController:UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		
		completionHandler([.banner, .sound, .badge])
	}
}
