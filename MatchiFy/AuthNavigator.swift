import SwiftUI

enum AuthScreen {
    case login
    case register
}

struct AuthNavigator: View {
    @State private var currentScreen: AuthScreen = .login
    
    var body: some View {
        NavigationStack {
            Group {
                switch currentScreen {
                case .login:
                    LoginView(onGoToRegister: {
                        currentScreen = .register
                    })
                    .navigationBarBackButtonHidden(true) // pas de flèche

                case .register:
                    RegisterView(onGoToLogin: {
                        currentScreen = .login
                    })
                    .navigationBarBackButtonHidden(true) // pas de flèche
                }
            }
        }
    }
}

#Preview {
    AuthNavigator()
}
