import SwiftUI

struct MissionsListView: View {
    @StateObject private var controller = MissionsListController()
    
    @State private var showActions = false
    @State private var selectedMission: MissionListItem? = nil
    @State private var showMissionForm = false
    
    var body: some View {
        VStack(spacing: 16) {
            
            // 🔍 Barre de recherche
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search missions", text: $controller.searchText)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            // 📋 Liste des missions
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(controller.filteredMissions) { mission in
                        NavigationLink {
                            MissionDetailsView(mission: mission)
                        } label: {
                            MissionCardView(
                                mission: mission,
                                onMoreTapped: {
                                    selectedMission = mission
                                    showActions = true
                                }
                            )
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 8)
                }
                .padding(.bottom, 16)
            }
        }
        .navigationTitle("Missions")
        .navigationBarTitleDisplayMode(.inline)
        
        // 🧭 TopBar : avatar + +
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: ProfileView()) {
                    Image("avatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showMissionForm = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 26)
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationDestination(isPresented: $showMissionForm) {
            MissionFormView()
        }
        
        // ⚙️ Popup Edit/Delete
        .confirmationDialog(
            "Actions",
            isPresented: $showActions,
            titleVisibility: .visible
        ) {
            Button {
                if let mission = selectedMission {
                    print("Edit tapped for mission: \(mission.title)")
                }
            } label: {
                Text("Edit")
                    .foregroundColor(.green)
            }
            
            Button(role: .destructive) {
                if let mission = selectedMission {
                    print("Delete tapped for mission: \(mission.title)")
                }
            } label: {
                Text("Delete")
                    .foregroundColor(.red)
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
}

// 🌟 Carte mission (inchangée)
struct MissionCardView: View {
    let mission: MissionListItem
    let onMoreTapped: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(.systemBackground),
                            Color(.systemGray6)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Text(mission.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        onMoreTapped()
                    }) {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                }
                
                Text(mission.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 6) {
                    ForEach(mission.skills.prefix(3), id: \.self) { skill in
                        Text(skill)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.15))
                            .foregroundColor(.blue)
                            .clipShape(Capsule())
                    }
                    Spacer()
                }
                .padding(.top, 4)
                
                HStack(spacing: 12) {
                    Label(mission.duration, systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Label(mission.budget, systemImage: "creditcard")
                        .font(.caption)
                        .foregroundColor(.green)
                    
                    Spacer()
                }
                .padding(.top, 6)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        MissionsListView()
    }
}
