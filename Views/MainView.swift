import SwiftUI

struct MainView: View {
    @StateObject private var alarmManager = AlarmManager()
    @State private var selectedMinutes: Double = 30
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // メインの仮眠ボタン
                NapButton(minutes: Int(selectedMinutes)) {
                    alarmManager.createAlarm(minutes: Int(selectedMinutes))
                }
                
                // 時間調整用スライダー
                TimeSlider(value: $selectedMinutes)
                    .padding()
                
                // アラームリスト（削除機能を追加）
                AlarmListView(
                    alarms: alarmManager.activeAlarms,
                    onDelete: { id in
                        alarmManager.cancelAlarm(id: id)
                    }
                )
                
                Spacer()
            }
            .navigationTitle("Smartnap")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}
