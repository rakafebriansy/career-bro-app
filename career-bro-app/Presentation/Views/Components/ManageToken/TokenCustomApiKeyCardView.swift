//
//  TokenCustomApiKeyCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct TokenCustomApiKeyCardView: View {
    @Binding var isCustomKeyEnabled: Bool
    @Binding var selectedProvider: String
    @Binding var apiKey: String
    @State private var isKeyVisible: Bool = false
    @State private var isSaved: Bool = false

    var onSaveKey: ((String, String) -> Void)? = nil

    let providers = ["OpenAI", "Anthropic", "Gemini"]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("API Key Integration")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Use Custom API Key")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textPrimary)

                        Text("Bypass in-app quota with your own key")
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "#737373"))
                    }

                    Spacer()

                    Toggle("", isOn: $isCustomKeyEnabled)
                        .labelsHidden()
                        .tint(Color.bgPrimary)
                }

                if isCustomKeyEnabled {
                    Divider()
                        .foregroundStyle(Color.baseStroke)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Provider")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textPrimary)

                        HStack(spacing: 8) {
                            ForEach(providers, id: \.self) { provider in
                                Button {
                                    selectedProvider = provider
                                } label: {
                                    Text(provider)
                                        .font(.caption)
                                        .fontWeight(selectedProvider == provider ? .bold : .medium)
                                        .foregroundStyle(selectedProvider == provider ? Color.white : .textPrimary)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(selectedProvider == provider ? Color.bgPrimary : Color(hex: "#F1F5F9"))
                                        .clipShape(Capsule())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("API Secret Key")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textPrimary)

                        HStack {
                            if isKeyVisible {
                                TextField("Enter \(selectedProvider) API Key", text: $apiKey)
                                    .font(.system(size: 13, design: .monospaced))
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                            } else {
                                SecureField("Enter \(selectedProvider) API Key", text: $apiKey)
                                    .font(.system(size: 13, design: .monospaced))
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                            }

                            Button {
                                isKeyVisible.toggle()
                            } label: {
                                Image(systemName: isKeyVisible ? "eye.slash" : "eye")
                                    .font(.caption)
                                    .foregroundStyle(Color(hex: "#737373"))
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color(hex: "#F8FAFC"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.baseStroke, lineWidth: 1)
                        )
                    }

                    HStack(spacing: 6) {
                        Image(systemName: "lock.shield.fill")
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "#16A34A"))

                        Text("Stored securely in iOS Keychain")
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "#737373"))

                        Spacer()

                        Button {
                            onSaveKey?(selectedProvider, apiKey)
                            withAnimation {
                                isSaved = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    isSaved = false
                                }
                            }
                        } label: {
                            HStack(spacing: 4) {
                                if isSaved {
                                    Image(systemName: "checkmark")
                                        .font(.caption2)
                                    Text("Saved")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                } else {
                                    Text("Save Key")
                                        .font(.caption2)
                                        .fontWeight(.bold)
                                }
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(isSaved ? Color(hex: "#16A34A") : Color.bgPrimary)
                            .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                        .disabled(apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .opacity(apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
                    }
                }
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
    }
}

#Preview {
    TokenCustomApiKeyCardView(
        isCustomKeyEnabled: .constant(true),
        selectedProvider: .constant("OpenAI"),
        apiKey: .constant("sk-proj-sample123456789")
    )
    .padding()
}
