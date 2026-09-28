//
//  RoboChatHistorySidebarView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

enum RoboChatSidebarTab: String, CaseIterable {
    case percakapan = "Percakapan"
    case spark = "Spark"
}

struct RoboChatHistoryItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    var isPinned: Bool = false
}

struct RoboChatHistorySidebarView: View {
    @State private var selectedTab: RoboChatSidebarTab = .percakapan
    
    var onNewChat: (() -> Void)? = nil
    var onSelectChat: ((String) -> Void)? = nil
    var onClose: (() -> Void)? = nil
    var onSearchTap: (() -> Void)? = nil
    var onMediaTap: ((String) -> Void)? = nil
    var onNewNotebook: (() -> Void)? = nil
    
    private let sampleRecentChats: [RoboChatHistoryItem] = [
        RoboChatHistoryItem(title: "Web Developer CV Job Description", isPinned: true),
        RoboChatHistoryItem(title: "Portfolio Project", isPinned: true),
        RoboChatHistoryItem(title: "2d platformer", isPinned: true),
        RoboChatHistoryItem(title: "Design System Warna Hijau Tosca", isPinned: false),
        RoboChatHistoryItem(title: "Daftar 100 Kripto Teratas", isPinned: false),
        RoboChatHistoryItem(title: "Creating a Next.js Project", isPinned: false),
        RoboChatHistoryItem(title: "Strategi Mempermudah Operasional Pe...", isPinned: false),
        RoboChatHistoryItem(title: "Ekstrak Teks Data Penjualan", isPinned: false),
        RoboChatHistoryItem(title: "Memperjelas Visi Produk POS", isPinned: false),
        RoboChatHistoryItem(title: "Koreksi dan Penjelasan Istilah Posaic", isPinned: false),
        RoboChatHistoryItem(title: "Panduan Pembuatan POS Murah", isPinned: false),
        RoboChatHistoryItem(title: "Alternatif Kalimat Disrupsi POS", isPinned: false),
        RoboChatHistoryItem(title: "Ekstrak Teks Web3 dan Blockchain", isPinned: false)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top Tab Switcher: Percakapan vs Spark BETA
            topSegmentedTab
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 14)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    // Quick Action Menu Items
                    quickActionsSection
                    
                    // Notebook Section
                    notebookSection
                    
                    // Terbaru (Recent) Section
                    recentChatsSection
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(hex: "F8FAFC"))
        .overlay(
            Rectangle()
                .frame(width: 1)
                .foregroundColor(Color.baseStroke),
            alignment: .trailing
        )
    }
    
    // MARK: - Top Segmented Tab Switcher
    private var topSegmentedTab: some View {
        HStack(spacing: 4) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedTab = .percakapan
                }
            } label: {
                Text("Percakapan")
                    .font(.system(size: 14, weight: selectedTab == .percakapan ? .bold : .medium))
                    .foregroundStyle(selectedTab == .percakapan ? Color(hex: "0F172A") : Color(hex: "64748B"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 38)
                    .background(
                        selectedTab == .percakapan ? Color.white : Color.clear
                    )
                    .clipShape(Capsule())
                    .shadow(color: selectedTab == .percakapan ? Color.black.opacity(0.06) : Color.clear, radius: 4, y: 2)
            }
            .buttonStyle(.plain)
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedTab = .spark
                }
            } label: {
                HStack(spacing: 5) {
                    Text("Spark")
                        .font(.system(size: 14, weight: selectedTab == .spark ? .bold : .medium))
                        .foregroundStyle(selectedTab == .spark ? Color(hex: "0F172A") : Color(hex: "64748B"))
                    
                    Text("BETA")
                        .font(.system(size: 9.5, weight: .bold))
                        .foregroundStyle(Color(hex: "64748B"))
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Color(hex: "CBD5E1"))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 38)
                .background(
                    selectedTab == .spark ? Color.white : Color.clear
                )
                .clipShape(Capsule())
                .shadow(color: selectedTab == .spark ? Color.black.opacity(0.06) : Color.clear, radius: 4, y: 2)
            }
            .buttonStyle(.plain)
        }
        .padding(4)
        .background(Color(hex: "E2E8F0"))
        .clipShape(Capsule())
    }
    
    // MARK: - Quick Actions Section
    private var quickActionsSection: some View {
        VStack(spacing: 4) {
            // Percakapan Baru (Prominent pill item)
            Button {
                onNewChat?()
                onClose?()
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(hex: "0F172A"))
                    
                    Text("Percakapan baru")
                        .font(.system(size: 14.5, weight: .semibold))
                        .foregroundStyle(Color(hex: "0F172A"))
                    
                    Spacer()
                }
                .padding(.horizontal, 14)
                .frame(height: 44)
                .background(Color(hex: "E2E8F0").opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            
            // Telusuri percakapan
            sidebarActionRow(
                iconName: "magnifyingglass",
                title: "Telusuri percakapan"
            ) {
                onSearchTap?()
                onClose?()
            }
            
            // Gambar
            sidebarActionRow(
                iconName: "photo",
                title: "Gambar"
            ) {
                onMediaTap?("Gambar")
                onClose?()
            }
            
            // Video
            sidebarActionRow(
                iconName: "video",
                title: "Video"
            ) {
                onMediaTap?("Video")
                onClose?()
            }
            
            // Koleksi
            sidebarActionRow(
                iconName: "square.grid.2x2",
                title: "Koleksi"
            ) {
                onMediaTap?("Koleksi")
                onClose?()
            }
        }
    }
    
    // MARK: - Notebook Section
    private var notebookSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Notebook")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color(hex: "64748B"))
                .padding(.leading, 6)
                .padding(.top, 4)
            
            Button {
                onNewNotebook?()
                onClose?()
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "0F172A"))
                    
                    Text("Notebook baru")
                        .font(.system(size: 14.5, weight: .medium))
                        .foregroundStyle(Color(hex: "0F172A"))
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                .frame(height: 38)
            }
            .buttonStyle(.plain)
        }
    }
    
    // MARK: - Terbaru Section
    private var recentChatsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Terbaru")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color(hex: "64748B"))
                .padding(.leading, 6)
                .padding(.top, 4)
            
            VStack(spacing: 2) {
                ForEach(sampleRecentChats) { item in
                    Button {
                        onSelectChat?(item.title)
                        onClose?()
                    } label: {
                        HStack(spacing: 10) {
                            Text(item.title)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Color(hex: "1E293B"))
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Spacer()
                            
                            if item.isPinned {
                                Image(systemName: "pin.fill")
                                    .font(.system(size: 11.5))
                                    .foregroundStyle(Color(hex: "64748B"))
                                    .rotationEffect(.degrees(45))
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 9)
                        .background(Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    // Helper action row
    private func sidebarActionRow(
        iconName: String,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: iconName)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color(hex: "0F172A"))
                    .frame(width: 20)
                
                Text(title)
                    .font(.system(size: 14.5, weight: .medium))
                    .foregroundStyle(Color(hex: "0F172A"))
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(height: 38)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    RoboChatHistorySidebarView()
        .frame(width: 300)
}
