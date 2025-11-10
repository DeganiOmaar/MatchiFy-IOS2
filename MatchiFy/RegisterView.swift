import SwiftUI
import PhotosUI

struct RegisterView: View {
    // 🔹 closure pour revenir à Login
    var onGoToLogin: (() -> Void)? = nil
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var role: String = "talent"
    @State private var showPassword: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
 
                // UPLOAD PROFILE IMAGE
                VStack {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.blue, lineWidth: 2)
                            )
                    } else {
                        Circle()
                            .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                            .background(Circle().fill(Color.gray.opacity(0.1)))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text(selectedImage == nil ? "Upload Profile Image" : "Change Image")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                }
                
                // INPUT FIELDS
                Group {
                    InputField(title: "Full Name", placeholder: "Enter your name", text: $name)
                    InputField(title: "Phone", placeholder: "Enter your phone number", text: $phone)
                    InputField(title: "Email", placeholder: "Enter your email", text: $email)
                    
                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        ZStack {
                            if showPassword {
                                TextField("Enter your password", text: $password)
                                    .textInputAutocapitalization(.never)
                            } else {
                                SecureField("Enter your password", text: $password)
                                    .textInputAutocapitalization(.never)
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 12)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
                
                // ROLE PICKER
                VStack(alignment: .leading, spacing: 8) {
                    Text("Role")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Picker("Select Role", selection: $role) {
                        Text("Talent").tag("talent")
                        Text("Recruiter").tag("recruiter")
                    }
                    .pickerStyle(.segmented)
                }
                
                // REGISTER BUTTON
                Button(action: {
                    print("Register tapped")
                }) {
                    Text("Register")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 8)
                
                // LOGIN TEXT
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        onGoToLogin?()   // ⬅️ retour vers Login
                    }) {
                        Text("Login")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                }
                .font(.footnote)
                .padding(.top, 4)
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .navigationBarBackButtonHidden(true) // pas de flèche
    }
}

// Champs réutilisables
struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

// Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.selectedImage = image as? UIImage
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
