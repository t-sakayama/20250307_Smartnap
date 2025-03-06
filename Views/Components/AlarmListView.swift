import SwiftUI

struct AlarmListView: View {
    let alarms: [Alarm]
    var onDelete: (UUID) -> Void  // 削除用のコールバック関数を追加
    
    var body: some View {
        VStack(alignment: .leading) {
            if !alarms.isEmpty {
                Text("アクティブなアラーム")
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(alarms) { alarm in
                            AlarmRow(alarm: alarm, onDelete: onDelete)
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                Text("アクティブなアラームはありません")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
    }
}

struct AlarmRow: View {
    let alarm: Alarm
    let onDelete: (UUID) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(alarm.timeString)
                    .font(.headline)
                Text(alarm.remainingTimeString)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                onDelete(alarm.id)  // 削除アクション
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title2)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}
