//
//  SearchResultItemCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct SearchResultItemCardView: View {
    let item: UniversalSearchResultEntity
    var onSelect: (() -> Void)? = nil

    var body: some View {
        Group {
            switch item.category {
            case .jobs:
                jobCard
            case .emails:
                emailCard
            case .chats:
                chatCard
            case .careerDNA:
                careerDNACard
            case .navigation:
                navigationCard
            case .settings:
                settingsCard
            case .all:
                navigationCard
            }
        }
        .contentShape(Rectangle())
    }

    private var jobCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "briefcase.fill")
                    .font(.system(size: 12, weight: .bold))

                Text(item.badgeText?.uppercased() ?? "LAMARAN KERJA")
                    .font(.system(size: 11, weight: .heavy))
                    .tracking(0.5)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .bold))
            }
            .foregroundStyle(Color.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Color(hex: item.badgeColorHex))

            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)

                Text(item.subtitle)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.secondary)
                    .lineLimit(2)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemGroupedBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color(hex: item.badgeColorHex).opacity(0.3), lineWidth: 1.5)
        )
        .shadow(color: Color(hex: item.badgeColorHex).opacity(0.12), radius: 6, x: 0, y: 3)
    }

    private var emailCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(hex: "6366F1"))
                            .frame(width: 32, height: 32)
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.white)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.title)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.primary)
                            .lineLimit(1)

                        Text("Template Surat Lamaran")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color(hex: "6366F1"))
                    }
                }

                Spacer()

                if let badge = item.badgeText {
                    Text(badge)
                        .font(.system(size: 11, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color(hex: "6366F1").opacity(0.15))
                        .foregroundStyle(Color(hex: "4338CA"))
                        .clipShape(Capsule())
                }
            }

            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "text.quote")
                    .font(.system(size: 11))
                    .foregroundStyle(Color(hex: "6366F1"))

                Text(item.subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color.primary.opacity(0.8))
                    .lineLimit(2)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: "EEECFE"))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color(hex: "C7D2FE"), lineWidth: 1)
            )
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color(hex: "6366F1").opacity(0.25), lineWidth: 1.5)
        )
        .shadow(color: Color(hex: "6366F1").opacity(0.08), radius: 6, x: 0, y: 2)
    }

    private var chatCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "818CF8"), Color(hex: "C084FC")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 48, height: 48)
                    .shadow(color: Color(hex: "818CF8").opacity(0.4), radius: 6, x: 0, y: 2)

                Image(systemName: item.systemImage)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color.white)
                        .lineLimit(1)

                    Spacer()

                    if let badge = item.badgeText {
                        Text(badge)
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(Color.white.opacity(0.2))
                            .foregroundStyle(Color.white)
                            .clipShape(Capsule())
                    }
                }

                Text(item.subtitle)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color(hex: "C7D2FE"))
                    .lineLimit(2)
            }

            Image(systemName: "sparkles")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color(hex: "FDE047"))
        }
        .padding(14)
        .background(
            LinearGradient(
                colors: [Color(hex: "1E1B4B"), Color(hex: "312E81")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: Color(hex: "1E1B4B").opacity(0.25), radius: 8, x: 0, y: 4)
    }

    private var careerDNACard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(hex: "10B981"))
                            .frame(width: 32, height: 32)
                        Image(systemName: "star.hexagonpath.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.white)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.title)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.white)
                            .lineLimit(1)

                        Text("Potensi & Roadmap Karir")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color(hex: "6EE7B7"))
                    }
                }

                Spacer()

                if let badge = item.badgeText {
                    Text(badge)
                        .font(.system(size: 11, weight: .bold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color(hex: "10B981"))
                        .foregroundStyle(Color.white)
                        .clipShape(Capsule())
                }
            }

            Text(item.subtitle)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color(hex: "D1FAE5"))
                .lineLimit(2)

            HStack {
                Text("Lihat Analisis Lengkap →")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color(hex: "6EE7B7"))
                Spacer()
            }
        }
        .padding(14)
        .background(
            LinearGradient(
                colors: [Color(hex: "064E3B"), Color(hex: "065F46")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: Color(hex: "064E3B").opacity(0.25), radius: 8, x: 0, y: 4)
    }

    private var navigationCard: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(hex: "2563EB"))
                    .frame(width: 44, height: 44)
                    .shadow(color: Color(hex: "2563EB").opacity(0.3), radius: 4, x: 0, y: 2)

                Image(systemName: item.systemImage)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.white)
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color.primary)

                    Spacer()

                    if let badge = item.badgeText {
                        Text(badge)
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.12))
                            .foregroundStyle(Color.blue)
                            .clipShape(Capsule())
                    }
                }

                Text(item.subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.secondary)
                    .lineLimit(1)
            }

            Image(systemName: "arrow.right.circle.fill")
                .font(.system(size: 20))
                .foregroundStyle(Color(hex: "2563EB"))
        }
        .padding(12)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.blue.opacity(0.15), lineWidth: 1.5)
        )
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 2)
    }

    private var settingsCard: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "F59E0B"), Color(hex: "D97706")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 44, height: 44)
                    .shadow(color: Color(hex: "F59E0B").opacity(0.35), radius: 4, x: 0, y: 2)

                Image(systemName: item.systemImage)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.white)
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color.primary)

                    Spacer()

                    if let badge = item.badgeText {
                        Text(badge)
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(Color(hex: "F59E0B").opacity(0.2))
                            .foregroundStyle(Color(hex: "B45309"))
                            .clipShape(Capsule())
                    }
                }

                Text(item.subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.secondary)
                    .lineLimit(1)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color(hex: "D97706"))
        }
        .padding(12)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color(hex: "F59E0B").opacity(0.3), lineWidth: 1.5)
        )
        .shadow(color: Color(hex: "F59E0B").opacity(0.08), radius: 6, x: 0, y: 2)
    }
}
