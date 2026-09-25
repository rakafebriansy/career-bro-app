import SwiftUI

enum ProfileMenuTrailingType {
    case navigation
    case toggle(Binding<Bool>)
}

struct ProfileMenuRowView: View {
    let iconName: String
    let title: String
    let trailingType: ProfileMenuTrailingType
    var action: (() -> Void)? = nil
    
    var body: some View {
        Group {
            switch trailingType {
            case .navigation:
                Button {
                    action?()
                } label: {
                    content
                }
                .buttonStyle(.plain)
            case .toggle(let binding):
                HStack(spacing: 14) {
                    Image(systemName: iconName)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(Color(hex: "4B5563"))
                        .frame(width: 24, alignment: .center)
                    
                    Text(title)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                    
                    Toggle("", isOn: binding)
                        .labelsHidden()
                        .tint(Color.blue)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
        }
    }
    
    private var content: some View {
        HStack(spacing: 14) {
            Image(systemName: iconName)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color(hex: "4B5563"))
                .frame(width: 24, alignment: .center)
            
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.blue)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }
}
