import Foundation
import AVFoundation

class AudioManager {
    private var audioPlayer: AVAudioPlayer?
    private var sleepSoundPlayer: AVAudioPlayer?
    
    // Bluetoothオーディオ出力の設定
    func configureAudioSession(useBluetoothIfAvailable: Bool) {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            if useBluetoothIfAvailable {
                try audioSession.setCategory(.playback, options: [.allowBluetooth, .allowBluetoothA2DP])
            } else {
                try audioSession.setCategory(.playback)
            }
            try audioSession.setActive(true)
        } catch {
            print("オーディオセッション設定エラー: \(error)")
        }
    }
    
    func playAlarmSound() {
        // デフォルトのシステムサウンドを使用
        let systemSoundID: SystemSoundID = 1005
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    func stopAlarmSound() {
        audioPlayer?.stop()
    }
    
    func playSleepSound(named: String) {
        guard let soundURL = Bundle.main.url(forResource: named, withExtension: "mp3") else {
            return
        }
        
        do {
            sleepSoundPlayer = try AVAudioPlayer(contentsOf: soundURL)
            sleepSoundPlayer?.numberOfLoops = -1 // 無限ループ
            sleepSoundPlayer?.play()
        } catch {
            print("睡眠導入音再生エラー: \(error)")
        }
    }
    
    func stopSleepSound() {
        sleepSoundPlayer?.stop()
    }
} 
