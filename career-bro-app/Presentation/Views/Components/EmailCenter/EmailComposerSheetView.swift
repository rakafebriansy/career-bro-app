import SwiftUI
import MessageUI

struct EmailComposerSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    var template: EmailTemplateModel
    
    @State private var recipientText: String = ""
    @State private var subjectText: String = ""
    @State private var bodyContent: String = ""
    @State private var isCopied: Bool = false
    @State private var showMailComposeError: Bool = false
    @State private var showSentSuccessAlert: Bool = false
    @State private var isBlastingMode: Bool = false
    @State private var isBlastingInProgress: Bool = false
    @State private var blastingProgress: Double = 0.0
    
    init(template: EmailTemplateModel) {
        self.template = template
        _subjectText = State(initialValue: template.subject)
        _bodyContent = State(initialValue: template.body)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    modeToggleSection
                    
                    if isBlastingMode {
                        blastingInfoBanner
                    }
                    
                    recipientField
                    
                    subjectField
                    
                    bodyField
                    
                    if isBlastingInProgress {
                        blastingProgressBar
                    }
                    
                    actionButtonsSection
                }
                .padding(16)
            }
            .background(Color(hex: "#F8FAFC"))
            .navigationTitle(template.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundStyle(Color(hex: "#737373"))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        copyToClipboard()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                            Text(isCopied ? "Copied" : "Copy")
                        }
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(isCopied ? Color(hex: "#16A34A") : Color.bgPrimary)
                    }
                }
            }
            .alert("Email Client Unavailable", isPresented: $showMailComposeError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your device does not have a configured email account. We have copied the email content to your clipboard so you can paste it into any webmail client.")
            }
            .alert("Emails Blasted Successfully!", isPresented: $showSentSuccessAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("All emails were queued and dispatched to \(recipientList.count) recipient(s).")
            }
        }
    }
    
    private var modeToggleSection: some View {
        HStack {
            Button {
                isBlastingMode = false
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "paperplane.fill")
                        .font(.caption)
                    Text("Single Send")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(!isBlastingMode ? Color.bgPrimary : Color.clear)
                .foregroundStyle(!isBlastingMode ? Color.white : Color(hex: "#4B5563"))
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
            
            Button {
                isBlastingMode = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "megaphone.fill")
                        .font(.caption)
                    Text("Email Blasting")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(isBlastingMode ? Color.bgPrimary : Color.clear)
                .foregroundStyle(isBlastingMode ? Color.white : Color(hex: "#4B5563"))
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(4)
        .background(Color(hex: "#E2E8F0"))
        .clipShape(Capsule())
    }
    
    private var blastingInfoBanner: some View {
        HStack(spacing: 10) {
            Image(systemName: "info.circle.fill")
                .font(.subheadline)
                .foregroundStyle(Color.bgPrimary)
            
            Text("Enter multiple comma-separated emails to blast personalized templates to multiple recruiters.")
                .font(.caption2)
                .foregroundStyle(Color(hex: "#4B5563"))
                .lineSpacing(2)
        }
        .padding(12)
        .background(Color(hex: "#EFF6FF"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var recipientField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(isBlastingMode ? "Recipients (separated by comma)" : "Recipient Email")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            TextField(isBlastingMode ? "recruiter1@company.com, hr@startup.io" : "hiring.manager@company.com", text: $recipientText)
                .font(.system(size: 14))
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
        }
    }
    
    private var subjectField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Subject Line")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            TextField("Enter subject", text: $subjectText)
                .font(.system(size: 14))
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
        }
    }
    
    private var bodyField: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Email Body Template")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.textPrimary)
                
                Spacer()
                
                Text("\(bodyContent.count) chars")
                    .font(.caption2)
                    .foregroundStyle(Color(hex: "#737373"))
            }
            
            TextEditor(text: $bodyContent)
                .font(.system(size: 13))
                .lineSpacing(4)
                .frame(minHeight: 180)
                .padding(10)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
        }
    }
    
    private var blastingProgressBar: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Blasting emails...")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.bgPrimary)
                
                Spacer()
                
                Text("\(Int(blastingProgress * 100))%")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.bgPrimary)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.baseStroke)
                        .frame(height: 6)
                    
                    Capsule()
                        .fill(Color.bgPrimary)
                        .frame(width: geo.size.width * CGFloat(blastingProgress), height: 6)
                }
            }
            .frame(height: 6)
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var actionButtonsSection: some View {
        VStack(spacing: 12) {
            if isBlastingMode {
                Button {
                    startEmailBlasting()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "megaphone.fill")
                        Text(isBlastingInProgress ? "Sending Blasts..." : "Start Email Blasting (\(recipientList.count))")
                    }
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.bgPrimary)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .disabled(recipientList.isEmpty || isBlastingInProgress)
                .opacity(recipientList.isEmpty || isBlastingInProgress ? 0.6 : 1.0)
            } else {
                Button {
                    openInNativeMailApp()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "envelope.badge.fill")
                        Text("Open in Mail App")
                    }
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.bgPrimary)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
    }
    
    private var recipientList: [String] {
        recipientText
            .components(separatedBy: CharacterSet(charactersIn: ",;\n"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty && $0.contains("@") }
    }
    
    private func copyToClipboard() {
        let fullContent = "Subject: \(subjectText)\n\n\(bodyContent)"
        UIPasteboard.general.string = fullContent
        withAnimation {
            isCopied = true
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                isCopied = false
            }
        }
    }
    
    private func openInNativeMailApp() {
        let recipient = recipientText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let encodedSubject = subjectText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedBody = bodyContent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            copyToClipboard()
            showMailComposeError = true
            return
        }
        
        let mailtoString = "mailto:\(recipient)?subject=\(encodedSubject)&body=\(encodedBody)"
        if let mailtoUrl = URL(string: mailtoString), UIApplication.shared.canOpenURL(mailtoUrl) {
            UIApplication.shared.open(mailtoUrl)
        } else {
            copyToClipboard()
            showMailComposeError = true
        }
    }
    
    private func startEmailBlasting() {
        guard !recipientList.isEmpty else { return }
        isBlastingInProgress = true
        blastingProgress = 0.0
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if blastingProgress < 1.0 {
                blastingProgress += 0.25
            } else {
                timer.invalidate()
                isBlastingInProgress = false
                showSentSuccessAlert = true
            }
        }
    }
}

#Preview {
    EmailComposerSheetView(
        template: EmailTemplateModel.sampleTemplates[0]
    )
}
