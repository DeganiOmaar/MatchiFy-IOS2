import Foundation

struct Mission: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var duration: String
    var budget: String
    var skills: [String]
}
