//
//  AIService.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol AIServiceProtocol {
    func generateChatResponse(for prompt: String, hasAttachment: Bool) async -> String
}

final class AIService: AIServiceProtocol {
    init() {}
    
    func generateChatResponse(for prompt: String, hasAttachment: Bool) async -> String {
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
}
