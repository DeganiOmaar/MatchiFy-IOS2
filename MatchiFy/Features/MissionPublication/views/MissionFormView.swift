import SwiftUI

struct MissionFormView: View {
    @StateObject private var controller = MissionFormController()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Publish a Mission")
                    .font(.title.bold())
                
                VStack(alignment: .leading, spacing: 8) {
                                  Text("Title")
                                      .font(.subheadline)
                                      .foregroundStyle(.gray)
                                  
                                  TextField("e.g. Social Media Campaign for a Brand", text: $controller.title)
                                      .textInputAutocapitalization(.sentences)
                                      .padding()
                                      .background(
                                          RoundedRectangle(cornerRadius: 10)
                                              .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                      )
                              }
                
                // DESCRIPTION
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    TextEditor(text: $controller.description)
                        .frame(minHeight: 100)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // DURATION
                VStack(alignment: .leading, spacing: 8) {
                    Text("Duration")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    TextField("e.g. 3 months, 2 weeks", text: $controller.duration)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // BUDGET
                VStack(alignment: .leading, spacing: 8) {
                    Text("Budget")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    TextField("e.g. 1500 dt, 100 dt/day", text: $controller.budget)
                        .keyboardType(.numbersAndPunctuation)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // SKILLS
                VStack(alignment: .leading, spacing: 8) {
                    Text("Required Skills")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        TextField("Add a skill", text: $controller.newSkill)
                            .textInputAutocapitalization(.never)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button(action: {
                            controller.addSkill()
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(
                                    Circle()
                                        .fill(controller.skills.count >= controller.maxSkills
                                              ? Color.gray
                                              : Color.blue)
                                )
                        }
                        .disabled(controller.skills.count >= controller.maxSkills)
                    }
                    
                    if controller.skills.count >= controller.maxSkills {
                        Text("You can add up to \(controller.maxSkills) skills.")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                    
                    // Liste des compétences (chips)
                    if !controller.skills.isEmpty {
                        WrapSkillsView(
                            skills: controller.skills,
                            onRemove: { index in
                                controller.removeSkill(at: index)
                            }
                        )
                        .padding(.top, 4)
                    }
                }
                
                // BUTTON PUBLISH
                Button(action: {
                    controller.submit()
                }) {
                    Text("Publish Mission")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(24)
        }
        .navigationTitle("New Mission")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Vue pour afficher les compétences sous forme de "chips" avec wrap
struct WrapSkillsView: View {
    let skills: [String]
    let onRemove: (Int) -> Void
    
    // Grille adaptative : s’adapte à la largeur et passe à la ligne automatiquement
    private let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 8)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            ForEach(Array(skills.enumerated()), id: \.offset) { index, skill in
                HStack(spacing: 4) {
                    Text(skill)
                        .font(.footnote)
                    Button(action: {
                        onRemove(index)
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.footnote)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.gray.opacity(0.15))
                )
            }
        }
    }
}

#Preview {
    // Préview avec un faux controller si tu veux tester rapidement
    NavigationStack {
        MissionFormView()
    }
}
