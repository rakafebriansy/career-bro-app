//
//  EmailTemplateTagSelectorView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct EmailTemplateTagSelectorView: View {
    @Binding var selectedTags: [String]

    @State private var availableTags: [String] = ["Fullstack", "Front-End", "Back-End", "UI/UX", "Mobile", "DevOps", "Data Analyst"]
    @State private var customTagInput: String = ""
    @State private var showCustomTagField: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Role & Category Tags")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.textPrimary)

                Spacer()

                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showCustomTagField.toggle()
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: showCustomTagField ? "minus" : "plus")
                        Text(showCustomTagField ? "Done" : "Add Custom")
                    }
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.bgPrimary)
                }
                .buttonStyle(.plain)
            }

            if showCustomTagField {
                HStack(spacing: 8) {
                    TextField("Enter tag name (e.g. QA Engineer)", text: $customTagInput)
                        .font(.system(size: 13))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(hex: "#F8FAFC"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.baseStroke, lineWidth: 1)
                        )

                    Button {
                        addCustomTag()
                    } label: {
                        Text("Add")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color.bgPrimary)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .disabled(customTagInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(availableTags, id: \.self) { tag in
                        let isSelected = selectedTags.contains(tag)
                        Button {
                            toggleTag(tag)
                        } label: {
                            HStack(spacing: 4) {
                                if isSelected {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 10, weight: .bold))
                                }
                                Text(tag)
                                    .font(.system(size: 12, weight: .medium))
                            }
                            .foregroundStyle(isSelected ? Color.white : Color(hex: "#4B5563"))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(isSelected ? Color.bgPrimary : Color(hex: "#F1F5F9"))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(isSelected ? Color.bgPrimary : Color.clear, lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }

    private func toggleTag(_ tag: String) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }

    private func addCustomTag() {
        let trimmed = customTagInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        if !availableTags.contains(trimmed) {
            availableTags.append(trimmed)
        }
        if !selectedTags.contains(trimmed) {
            selectedTags.append(trimmed)
        }
        customTagInput = ""
        showCustomTagField = false
    }
}

#Preview {
    EmailTemplateTagSelectorView(
        selectedTags: .constant(["Fullstack", "UI/UX"])
    )
    .padding()
}
