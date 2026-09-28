//
//  InterviewPersonaSelectionSheetView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct InterviewPersonaSelectionSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    var personas: [InterviewerPersonaModel] = InterviewerPersonaModel.samplePersonas
    @State private var selectedPersonaId: UUID
    var onConfirm: ((InterviewerPersonaModel) -> Void)? = nil
    
    init(
        personas: [InterviewerPersonaModel] = InterviewerPersonaModel.samplePersonas,
        initialSelected: InterviewerPersonaModel? = nil,
        onConfirm: ((InterviewerPersonaModel) -> Void)? = nil
    ) {
        self.personas = personas
        let defaultId: UUID
        if let initial = initialSelected {
            defaultId = initial.id
        } else if personas.indices.contains(2) {
            defaultId = personas[2].id
        } else {
            defaultId = personas.first?.id ?? UUID()
        }
        _selectedPersonaId = State(initialValue: defaultId)
        self.onConfirm = onConfirm
    }
    
    private var currentSelectedPersona: InterviewerPersonaModel? {
        personas.first { $0.id == selectedPersonaId }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            headerSection
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(personas) { persona in
                        InterviewPersonaItemView(
                            persona: persona,
                            isSelected: persona.id == selectedPersonaId
                        ) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedPersonaId = persona.id
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
            }
            
            HStack {
                Spacer()
                
                Button {
                    if let selected = currentSelectedPersona {
                        onConfirm?(selected)
                    }
                    dismiss()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .bold))
                        Text("Choose")
                            .font(.system(size: 15, weight: .bold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(Color.bgPrimary)
                    .clipShape(Capsule())
                    .shadow(color: Color.bgPrimary.opacity(0.25), radius: 6, y: 3)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .padding(.top, 20)
        .background(Color.white)
        .presentationDetents([.height(230), .medium])
        .presentationDragIndicator(.visible)
    }
    
    private var headerSection: some View {
        HStack {
            Text("Interview")
                .font(.system(size: 19, weight: .bold))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color(hex: "6B7280"))
                    .frame(width: 32, height: 32)
                    .background(Color(hex: "F3F4F6"))
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    InterviewPersonaSelectionSheetView()
}
