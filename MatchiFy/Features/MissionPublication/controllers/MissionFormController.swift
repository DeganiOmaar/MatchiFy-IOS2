import Foundation
import Combine
import SwiftUI

class MissionFormController: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var duration: String = ""
    @Published var budget: String = ""
    
    @Published var skills: [String] = []
    @Published var newSkill: String = ""
    
    let maxSkills = 6
    
    // Ajouter une compétence
    func addSkill() {
        let trimmed = newSkill.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard skills.count < maxSkills else { return }
        guard !skills.contains(trimmed) else { return } // éviter les doublons
        
        skills.append(trimmed)
        newSkill = ""
    }
    
    // Supprimer une compétence
    func removeSkill(at index: Int) {
        guard skills.indices.contains(index) else { return }
        skills.remove(at: index)
    }
    
    // Construction d'un objet Mission (statique pour l'instant)
    func buildMission() -> Mission {
        Mission(
            title: title,
            description: description,
            duration: duration,
            budget: budget,
            skills: skills
        )
    }
    
    // Soumission (pour l'instant : juste un print)
    func submit() {
        let mission = buildMission()
        print("Mission created: \(mission)")
        // plus tard : appel API NestJS ici
    }
}

