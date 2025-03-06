import SwiftUI

struct AlarmListView: View {
    let alarms: [Alarm]
    let accentColor: Color
    let textColor: Color
    var onDelete: (UUID) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            if !alarms.isEmpty {
                Text("アクティブなアラーム")
                    .font(.headline)
                    .foregroundColor(textColor)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(alarms) { alarm in
                            AlarmRow(alarm: alarm, accentColor: accentColor, textColor: textColor, onDelete: onDelete)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("アクティブなアラームはありません")
                    .font(.subheadline)
                    .foregroundColor(textColor.opacity(0.7))
                    .padding()
            }
        }
    }
}

struct AlarmRow: View {
    let alarm: Alarm
    let accentColor: Color
    let textColor: Color
    let onDelete: (UUID) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(alarm.timeString)
                    .font(.headline)
                    .foregroundColor(textColor)
                Text(alarm.remainingTimeString)
                    .font(.subheadline)
                    .foregroundColor(textColor.opacity(0.7))
            }
            
            Spacer()
            
            Button(action: {
                onDelete(alarm.id)
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title2)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground).opacity(0.3))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}
