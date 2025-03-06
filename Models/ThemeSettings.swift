import SwiftUI

class ThemeSettings: ObservableObject {
    @AppStorage("backgroundColor") var backgroundColor: String = "white"
    @AppStorage("accentColor") var accentColor: String = "green"
    
    // 背景色を取得（名前も変更）
    func background() -> Color {
        switch backgroundColor {
        case "white":
            return Color.white
        case "black":
            return Color.black
        case "gray":
            return Color(.systemGray6)
        case "beige":
            return Color(red: 0.95, green: 0.95, blue: 0.9)
        case "lightBlue":
            return Color(red: 0.9, green: 0.95, blue: 1.0)
        case "lightPink":
            return Color(red: 1.0, green: 0.9, blue: 0.95)
        default:
            return Color.white
        }
    }
    
    // アクセントカラーを取得
    func accent() -> Color {
        switch accentColor {
        case "black": return Color.black
        case "white": return Color.white
        case "gray": return Color.gray
        case "blue": return Color.blue
        case "red": return Color.red
        case "green": return Color(.systemGreen)
        case "pink": return Color.pink
        case "yellow": return Color.yellow
        case "orange": return Color.orange
        case "cyan": return Color.cyan
        default: return Color(.systemGreen)
        }
    }
    
    // テキストカラーを取得（背景色に合わせて）
    func textColor() -> Color {
        switch backgroundColor {
        case "white", "beige", "lightBlue", "lightPink": return Color.black
        case "black", "gray": return Color.white
        default: return Color.primary
        }
    }
} 
