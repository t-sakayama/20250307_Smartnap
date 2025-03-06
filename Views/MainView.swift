import SwiftUI

struct MainView: View {
    @StateObject private var alarmManager = AlarmManager()
    @State private var selectedMinutes: Double = 30
    @EnvironmentObject private var themeSettings: ThemeSettings
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                // 背景色
                themeSettings.background()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // メインの仮眠ボタン（アクセントカラーを適用）
                    NapButton(minutes: Int(selectedMinutes), accentColor: themeSettings.accent()) {
                        alarmManager.createAlarm(minutes: Int(selectedMinutes))
                    }
                    
                    // 時間調整用スライダー（アクセントカラーを適用）
                    TimeSlider(value: $selectedMinutes, accentColor: themeSettings.accent())
                        .padding()
                    
                    // アラームリスト
                    AlarmListView(
                        alarms: alarmManager.activeAlarms,
                        accentColor: themeSettings.accent(),
                        textColor: themeSettings.textColor(),
                        onDelete: { id in
                            alarmManager.cancelAlarm(id: id)
                        }
                    )
                    
                    Spacer()
                }
            }
            .navigationTitle("Smartnap")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .foregroundColor(themeSettings.accent())
                    }
                }
            }
        }
    }
}
