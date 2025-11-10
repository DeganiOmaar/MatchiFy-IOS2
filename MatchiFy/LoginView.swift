import SwiftUI

struct LoginView: View {
    // 🔹 closure pour aller à l'écran Register
    var onGoToRegister: (() -> Void)? = nil
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 40)
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .padding(.bottom, 10)
            
            // EMAIL
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                TextField("Enter your email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            
            // PASSWORD
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
            
            // LOGIN BUTTON
            Button(action: {
                print("Login tapped")
            }) {
                Text("Login")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.top, 8)
            
            // SIGNUP TEXT
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button(action: {
                    onGoToRegister?()   // ⬅️ on appelle la navigation
                }) {
                    Text("SignUp")
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                }
            }
            .font(.footnote)
            .padding(.top, 4)
            
            // SOCIAL CIRCLES
            VStack(spacing: 12) {
                Text("Or continue with")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                HStack(spacing: 24) {
                    SocialCircle(imageName: "googleLogo")
                    SocialCircle(imageName: "linkedInLogo")
                    SocialCircle(imageName: "githubLogo")
                }
            }
            .padding(.top, 16)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden(true) // par sécurité
    }
}

struct SocialCircle: View {
    let imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                .frame(width: 50, height: 50)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
    }
}

#Preview {
    LoginView()
}
