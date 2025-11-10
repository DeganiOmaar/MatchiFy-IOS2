import Foundation

struct MissionListItem: Identifiable, Hashable {
    let id = UUID()
    
    var title: String
    var description: String
    var duration: String
    var budget: String
    var skills: [String]
}
