import Foundation

struct Alarm: Identifiable {
    let id = UUID()
    let createdAt: Date
    let duration: Int // 分単位
    var isCancelled: Bool = false
    
    var targetTime: Date {
        return createdAt.addingTimeInterval(Double(duration * 60))
    }
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: targetTime)
    }
    
    var remainingTimeString: String {
        let remaining = Int(targetTime.timeIntervalSinceNow)
        if remaining <= 0 {
            return "時間になりました"
        }
        
        let minutes = remaining / 60
        let seconds = remaining % 60
        
        if minutes > 0 {
            return "睡眠時間 \(minutes)分 \(seconds)秒"
        } else {
            return "睡眠時間 \(seconds)秒"
        }
    }
}
