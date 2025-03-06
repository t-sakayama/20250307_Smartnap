import SwiftUI

struct TimeSlider: View {
    @Binding var value: Double
    let minValue: Double = 1
    let maxValue: Double = 60
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(Int(value))分")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Slider(value: $value, in: minValue...maxValue, step: 1)
                .accentColor(Color(.systemGreen))
                .padding(.horizontal)
            
            HStack {
                Text("\(Int(minValue))分")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(Int(maxValue))分")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
