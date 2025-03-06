import SwiftUI

struct SettingsView: View {
    @AppStorage("themeColor") private var themeColor: String = "green"
    @AppStorage("accentColor") private var accentColor: String = "green"
    @AppStorage("useBluetoothAudio") private var useBluetoothAudio: Bool = false
    @AppStorage("alarmSound") private var alarmSound: String = "default"
    @AppStorage("sleepSound") private var sleepSound: String = "none"
    
    let themeColors = ["light", "dark", "beige"]
    let accentColors = ["black", "white", "gray", "blue", "red", "green", "pink", "yellow", "orange", "cyan"]
    
    var body: some View {
        Form {
            Section(header: Text("テーマ設定")) {
                Picker("メインカラー", selection: $themeColor) {
                    Text("ライト").tag("light")
                    Text("ダーク").tag("dark")
                    Text("ベージュ").tag("beige")
                }
                
                Picker("アクセントカラー", selection: $accentColor) {
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
