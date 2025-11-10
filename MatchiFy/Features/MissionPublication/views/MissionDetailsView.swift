import SwiftUI

struct MissionDetailsView: View {
    let mission: MissionListItem
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Contenu scrollable
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Titre
                    Text(mission.title)
                        .font(.title2.bold())
                        .multilineTextAlignment(.leading)
                    
                    // Durée + Budget
                    HStack(spacing: 12) {
                        Label(mission.duration, systemImage: "clock")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        
                        Label(mission.budget, systemImage: "creditcard")
                            .font(.subheadline)
                            .foregroundColor(.green)
                        
                        Spacer()
                    }
                    
                    // Compétences
                    if !mission.skills.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Required skills")
                                .font(.subheadline.bold())
                            
                            HStack(spacing: 8) {
                                ForEach(mission.skills, id: \.self) { skill in
                                    Text(skill)
                                        .font(.caption)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.12))
                                        .foregroundColor(.blue)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                            }
                        }
                    }
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.subheadline.bold())
                        
                        Text(mission.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
            }
            
            // Bouton Postuler
            Button(action: {
                print("Apply tapped for mission: \(mission.title)")
            }) {
                Text("Apply to this mission")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
        .navigationTitle("Mission Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Cœur en haut à droite
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // Juste visuel pour l'instant
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MissionDetailsView(
            mission: MissionListItem(
                title: "Social Media Campaign for Fashion Brand",
                description: "Create and manage a 3-month social media campaign for a new fashion collection, including content creation, influencer outreach and weekly reporting.",
                duration: "3 months",
                budget: "€2,500",
                skills: ["Marketing", "Social Media", "Content Creation"]
            )
        )
    }
}
