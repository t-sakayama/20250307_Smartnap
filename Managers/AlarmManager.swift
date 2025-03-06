import Foundation
import UserNotifications
import SwiftUI

class AlarmManager: ObservableObject {
    @Published var activeAlarms: [Alarm] = []
    private let audioManager = AudioManager()
    
    init() {
        requestNotificationPermission()
    }
    
    func createAlarm(minutes: Int) {
        let alarm = Alarm(createdAt: Date(), duration: minutes)
        activeAlarms.append(alarm)
        
        // ローカル通知をスケジュール
        scheduleNotification(for: alarm)
        
        // タイマーを開始
        startTimer(for: alarm)
    }
    
    func cancelAlarm(id: UUID) {
        if let index = activeAlarms.firstIndex(where: { $0.id == id }) {
            // アラームを配列から削除
            activeAlarms.remove(at: index)
            
            // 通知をキャンセル
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("通知の許可リクエストエラー: \(error)")
            }
        }
    }
    
    private func scheduleNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Smartnap"
        content.body = "\(alarm.duration)分の仮眠時間が終了しました"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(alarm.duration * 60), repeats: false)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知スケジュールエラー: \(error)")
            }
        }
    }
    
    private func startTimer(for alarm: Alarm) {
        // 1秒ごとにUIを更新するためのタイマー
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            // UIを更新
            self.objectWillChange.send()
            
            // アラーム時間になったかチェック
            if Date() >= alarm.targetTime {
                if !alarm.isCancelled {
                    self.audioManager.playAlarmSound()
                }
                timer.invalidate()
            }
        }
    }
}
