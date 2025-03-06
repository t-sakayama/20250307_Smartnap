import SwiftUI

struct NapButton: View {
    let minutes: Int
    let accentColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("\(minutes)")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 200, height: 200)
                .background(
                    ZStack {
                        // 外側の影
                        Circle()
                            .fill(Color.white.opacity(0.01))
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        // グラデーションの背景（アクセントカラーを使用）
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        accentColor.opacity(0.9),
                                        accentColor
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        // 内側の光沢効果
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.5),
                                        Color.white.opacity(0.0)
                                    ]),
                                    center: .topLeading,
                                    startRadius: 0,
                                    endRadius: 150
                                )
                            )
                            .padding(2)
                        
                        // 外側の縁取り
                        Circle()
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    }
                )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.05 : 0)
    }
}
