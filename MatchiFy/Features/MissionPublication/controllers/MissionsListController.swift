import SwiftUI
import Combine

class MissionsListController: ObservableObject {
    @Published var searchText: String = ""
    

    @Published var missions: [MissionListItem] = [
        MissionListItem(
            title: "Social Media Campaign for Fashion Brand",
            description: "Create and manage a 3-month social media campaign for a new fashion collection, including content creation, influencer outreach and weekly reporting.",
            duration: "3 months",
            budget: "€2,500",
            skills: ["Marketing", "Social Media", "Content Creation"]
        ),
        MissionListItem(
            title: "Music Video Editing for Indie Artist",
            description: "Edit a complete music video from raw footage. The style should be dynamic, modern and optimized for YouTube and TikTok.",
            duration: "2 weeks",
            budget: "€800",
            skills: ["Video Editing", "Color Grading", "Storytelling"]
        ),
        MissionListItem(
            title: "Brand Identity for Creative Studio",
            description: "Design a full brand identity including logo, color palette, typography and basic guidelines in a short PDF brandbook.",
            duration: "1 month",
            budget: "€1,200",
            skills: ["Graphic Design", "Branding", "Illustration"]
        )
    ]
    

    var filteredMissions: [MissionListItem] {
        let query = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return missions }
        
        return missions.filter { mission in
            mission.title.lowercased().contains(query) ||
            mission.description.lowercased().contains(query) ||
            mission.duration.lowercased().contains(query) ||
            mission.budget.lowercased().contains(query) ||
            mission.skills.contains { $0.lowercased().contains(query) }
        }
    }
}
