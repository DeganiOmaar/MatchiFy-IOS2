import SwiftUI

enum MainTab {
    case missions
    case profile
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .missions
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
          
            Group {
                switch selectedTab {
                case .missions:
                    NavigationStack {
                        MissionsListView()
                    }
                case .profile:
                    NavigationStack {
                        ProfileView()
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
            
          
            CustomBottomBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    MainTabView()
}


struct CustomBottomBar: View {
    @Binding var selectedTab: MainTab
    
    var body: some View {
        HStack(spacing: 28) {
            
            BottomBarItem(
                icon: "list.bullet.rectangle",
                title: "Missions",
                isSelected: selectedTab == .missions
            ) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    selectedTab = .missions
                }
            }
            
            BottomBarItem(
                icon: "person.crop.circle",
                title: "Profile",
                isSelected: selectedTab == .profile
            ) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    selectedTab = .profile
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
           
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal, 24)
        .padding(.bottom, 10)
    }
}


struct BottomBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.white.opacity(0.9))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            .frame(width: 60, height: 36)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(isSelected ? .blue : .gray)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}
