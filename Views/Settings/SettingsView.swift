import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var themeSettings: ThemeSettings
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("useBluetoothAudio") private var useBluetoothAudio: Bool = false
    @AppStorage("alarmSound") private var alarmSound: String = "default"
    @AppStorage("sleepSound") private var sleepSound: String = "none"
    
    let backgroundColors = ["white", "black", "gray", "beige", "lightBlue", "lightPink"]
    let accentColors = ["black", "white", "gray", "blue", "red", "green", "pink", "yellow", "orange", "cyan"]
    
    var body: some View {
        ZStack {
            // 背景色
            themeSettings.background()
                .ignoresSafeArea()
            
            Form {
                Section(header: Text("テーマ設定")) {
                    Picker("背景色", selection: $themeSettings.backgroundColor) {
                        Text("白").tag("white")
                        Text("黒").tag("black")
                        Text("グレー").tag("gray")
                        Text("ベージュ").tag("beige")
                        Text("ライトブルー").tag("lightBlue")
                        Text("ライトピンク").tag("lightPink")
                    }
                    
                    Picker("アクセントカラー", selection: $themeSettings.accentColor) {
                        ForEach(accentColors, id: \.self) { color in
                            Text(colorName(color)).tag(color)
                        }
                    }
                }
                
                Section(header: Text("オーディオ設定")) {
                    Toggle("Bluetoothイヤホンを使用", isOn: $useBluetoothAudio)
                    
                    Picker("アラーム音", selection: $alarmSound) {
                        Text("デフォルト").tag("default")
                        Text("ベル").tag("bell")
                        Text("電子音").tag("electronic")
                    }
                    
                    Picker("睡眠導入音", selection: $sleepSound) {
                        Text("なし").tag("none")
                        Text("自然音").tag("nature")
                        Text("ホワイトノイズ").tag("white_noise")
                    }
                }
                
                Section(header: Text("アプリについて")) {
                    HStack {
                        Text("バージョン")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("設定")
            .accentColor(themeSettings.accent())
        }
    }
    
    func colorName(_ color: String) -> String {
        switch color {
        case "black": return "黒"
        case "white": return "白"
        case "gray": return "灰色"
        case "blue": return "青"
        case "red": return "赤"
        case "green": return "緑"
        case "pink": return "ピンク"
        case "yellow": return "黄色"
        case "orange": return "オレンジ"
        case "cyan": return "水色"
        default: return color
        }
    }
}
