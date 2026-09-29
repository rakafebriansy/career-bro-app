//
//  RoboChatView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatView: View {
    @State private var inputText: String = ""
    @State private var messages: [ChatMessageModel] = ChatMessageModel.sampleMockupConversation
    @State private var pendingAttachment: ChatAttachmentModel? = nil
    @State private var tokensUsed: Int = 5
    @State private var totalTokens: Int = 25
    @State private var isSidebarOpen: Bool = false
    @State private var showAttachmentMenu: Bool = false
    @State private var showInterviewerSheet: Bool = false
    @State private var showTokenAlert: Bool = false
    @State private var isRoboTyping: Bool = false
    @State private var navigateToManageToken: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Main Chat Screen
                    ZStack(alignment: .bottomLeading) {
                        VStack(spacing: 0) {
                            RoboChatTopBarView(
                                tokensUsed: tokensUsed,
                                totalTokens: totalTokens,
                                onMenuTap: {
                                    withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                                        isSidebarOpen.toggle()
                                        showAttachmentMenu = false
                                    }
                                },
                                onTokenTap: {
                                    showTokenAlert = true
                                }
                            )
                            
                            // Chat & Floating Input Area
                            ZStack(alignment: .bottom) {
                                Color.white
                                    .ignoresSafeArea()
                                
                                if messages.isEmpty {
                                    RoboChatPromptSuggestionsView { selectedPrompt in
                                        sendMessage(text: selectedPrompt, attachment: nil)
                                    }
                                } else {
                                    chatMessagesScrollView
                                }
                                
                                // Floating Input Bar
                                RoboChatInputBarView(
                                    text: $inputText,
                                    attachedDocument: pendingAttachment,
                                    onRemoveAttachment: {
                                        pendingAttachment = nil
                                    },
                                    onSend: {
                                        let textToSend = inputText
                                        let attachmentToSend = pendingAttachment
                                        inputText = ""
                                        pendingAttachment = nil
                                        showAttachmentMenu = false
                                        sendMessage(text: textToSend, attachment: attachmentToSend)
                                    },
                                    onAttachmentTap: {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                            showAttachmentMenu.toggle()
                                        }
                                    },
                                    onProfileContextTap: {
                                        showAttachmentMenu = false
                                        showInterviewerSheet = true
                                    }
                                )
                                .padding(.bottom, 12)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                hideKeyboard()
                            }
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 10)
                                    .onChanged { value in
                                        if abs(value.translation.height) > 8 {
                                            hideKeyboard()
                                        }
                                    }
                            )
                        }
                        
                        // Floating Attachment / Action Menu Popup
                        if showAttachmentMenu {
                            Color.black.opacity(0.001)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        showAttachmentMenu = false
                                    }
                                }
                            
                            RoboChatAttachmentMenuView(
                                onUpgradeToken: {
                                    navigateToManageToken = true
                                },
                                onSelectPhoto: {
                                    pendingAttachment = ChatAttachmentModel(fileName: "Portfolio_Design.png", fileSize: "1.4 MB")
                                },
                                onOpenCamera: {
                                    pendingAttachment = ChatAttachmentModel(fileName: "Snapshot_Document.jpg", fileSize: "820 KB")
                                },
                                onSelectFile: {
                                    pendingAttachment = ChatAttachmentModel(fileName: "Flyer.pdf", fileSize: "200 KB")
                                },
                                onClose: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        showAttachmentMenu = false
                                    }
                                }
                            )
                            .padding(.leading, 16)
                            .padding(.bottom, 78)
                            .transition(.scale(scale: 0.85, anchor: .bottomLeading).combined(with: .opacity))
                            .zIndex(10)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    // Dimmed Backdrop Overlay
                    if isSidebarOpen {
                        Color.black.opacity(0.35)
                            .ignoresSafeArea()
                            .transition(.opacity)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                                    isSidebarOpen = false
                                }
                            }
                        
                        // History Sidebar Drawer
                        RoboChatHistorySidebarView(
                            onNewChat: {
                                withAnimation {
                                    messages.removeAll()
                                    pendingAttachment = nil
                                    isSidebarOpen = false
                                }
                            },
                            onSelectChat: { title in
                                loadRecentChat(title: title)
                                withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                                    isSidebarOpen = false
                                }
                            },
                            onClose: {
                                withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                                    isSidebarOpen = false
                                }
                            },
                            onSearchTap: {
                                // Search filter trigger
                            },
                            onMediaTap: { mediaType in
                                sendMessage(text: "Tampilkan riwayat \(mediaType)", attachment: nil)
                            },
                            onNewNotebook: {
                                sendMessage(text: "Buat Notebook Baru", attachment: nil)
                            }
                        )
                        .frame(width: min(geometry.size.width * 0.84, 320))
                        .frame(maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    if value.translation.width < -40 {
                                        withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                                            isSidebarOpen = false
                                        }
                                    }
                                }
                        )
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
            .sheet(isPresented: $showInterviewerSheet) {
                InterviewPersonaSelectionSheetView { selectedPersona in
                    sendMessage(
                        text: "I want to practice interview with \(selectedPersona.name)",
                        attachment: nil
                    )
                }
            }
            .alert("AI Token Balance", isPresented: $showTokenAlert) {
                Button("Manage Tokens") {
                    navigateToManageToken = true
                }
                Button("Close", role: .cancel) { }
            } message: {
                Text("You have used \(tokensUsed) of your \(totalTokens) daily queries. Reset occurs at midnight.")
            }
            .navigationDestination(isPresented: $navigateToManageToken) {
                ManageTokenView()
            }
        }
    }
    
    private var chatMessagesScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(messages) { message in
                        RoboChatMessageBubbleView(message: message)
                            .id(message.id)
                    }
                    
                    if isRoboTyping {
                        typingIndicator
                            .id("typingIndicator")
                    }
                }
                .padding(.top, 16)
                .padding(.bottom, 84)
            }
            .scrollDismissesKeyboard(.interactively)
            .simultaneousGesture(
                DragGesture(minimumDistance: 10)
                    .onChanged { value in
                        if abs(value.translation.height) > 8 {
                            hideKeyboard()
                        }
                    }
            )
            .onChange(of: messages.count) {
                if let lastMessage = messages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .onChange(of: isRoboTyping) {
                if isRoboTyping {
                    withAnimation {
                        proxy.scrollTo("typingIndicator", anchor: .bottom)
                    }
                }
            }
        }
    }
    
    private var typingIndicator: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.bgPrimary)
                    .frame(width: 32, height: 32)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
            }
            
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color(hex: "9CA3AF"))
                        .frame(width: 6, height: 6)
                        .opacity(0.8)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background(Color(hex: "F3F4F6"))
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
    
    private func sendMessage(text: String, attachment: ChatAttachmentModel?) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty || attachment != nil else { return }
        
        let userMessage = ChatMessageModel(
            text: trimmed,
            isUser: true,
            attachment: attachment
        )
        
        withAnimation(.spring(duration: 0.3)) {
            messages.append(userMessage)
            if tokensUsed < totalTokens {
                tokensUsed += 1
            }
        }
        
        isRoboTyping = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let replyText = generateRoboReply(for: trimmed, hasAttachment: attachment != nil)
            let roboMessage = ChatMessageModel(text: replyText, isUser: false)
            withAnimation(.spring(duration: 0.3)) {
                isRoboTyping = false
                messages.append(roboMessage)
            }
        }
    }
    
    private func loadSession(_ session: ChatSessionModel) {
        withAnimation {
            messages = [
                ChatMessageModel(text: session.title, isUser: true),
                ChatMessageModel(text: session.preview, isUser: false)
            ]
        }
    }
    
    private func loadRecentChat(title: String) {
        withAnimation {
            messages = [
                ChatMessageModel(text: title, isUser: true),
                ChatMessageModel(text: generateRoboReply(for: title, hasAttachment: false), isUser: false)
            ]
        }
    }
    
    private func generateRoboReply(for prompt: String, hasAttachment: Bool) -> String {
        let lower = prompt.lowercased()
        
        if hasAttachment || lower.contains("review") || lower.contains("cv") || lower.contains("resume") {
            return "Your CV is excellent, but let’s make it more perfect\n\npart of introduction better be like this\n“Hi, Im Maya, Digital Marketer for 5+ years experience……”"
        } else if lower.contains("practice interview with hr") || (lower.contains("interview") && lower.contains("hr")) {
            return "Awesome! I'm now acting as your HR Interviewer. 🤝\n\n**Question:** *'Tell me about a time when you experienced a major conflict in your team. What was the situation and how did you resolve it?'*"
        } else if lower.contains("practice interview with tech lead") || (lower.contains("interview") && lower.contains("tech lead")) {
            return "Great! I'm now acting as your Tech Lead Interviewer. 💻\n\n**Question:** *'How do you design scalable component architectures in SwiftUI, and how do you ensure zero-leak lifecycle management in async tasks?'*"
        } else if lower.contains("career path") || lower.contains("fits me") {
            return "That's okay, let's find out\n\nwhat you like or what you're best at?"
        } else if lower.contains("interview") || lower.contains("ui/ux") {
            return "Sure, but before that, let’s choose with whom you wanna interview!"
        } else if lower.contains("skills") || lower.contains("dream job") {
            return "For high-tier tech and design roles in 2026, recruiters prioritize:\n\n• **Core**: Design Systems, Micro-interactions, Accessibility (WCAG 2.2)\n• **Strategic**: Product Metrics, Conversion Funnels, User Research\n• **Emerging**: AI Tooling Workflows & Generative UX\n\nYour profile already shows strength in visual design. Let's sharpen your quantitative metrics presentation!"
        } else if lower.contains("tell me about yourself") {
            return "The best framework to answer 'Tell me about yourself' is the **Present-Past-Future Formula**:\n\n1. **Present**: Where you are now & your main specialty.\n2. **Past**: 1-2 notable career milestones or achievements.\n3. **Future**: Why you are excited specifically about this company and role.\n\nKeep it between 90 to 120 seconds!"
        } else {
            return "I understand you're looking for guidance on: *\"\(prompt)\"*\n\nI can help you break this down into actionable career steps, review your portfolio artefacts, or prepare tailored interview responses. How would you like to proceed?"
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    RoboChatView()
}
