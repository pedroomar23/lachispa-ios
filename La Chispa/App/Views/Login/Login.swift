//
//  Login.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/12/25.
//

import SwiftUI

struct Login : View {
    
    @StateObject var loginRequest = LoginRequests()
    @Environment(\.colorScheme) var colorScheme
    @State var showPassword : Bool = true
    
    var body : some View {
        if !loginRequest.isAuth {
            ContentNavigation {
                VStack {
                   _preview(label: LabelImage(text: "LaunchImage"))
                        .padding()
                    
                    MutiTextfield(text: $loginRequest.loginModel.username, placeholder: "username")
                        .frame(height: 55)
                        .padding(.horizontal)
                    
                    ZStack {
                        HStack {
                            if showPassword {
                                MutiTextfield(text: $loginRequest.loginModel.password, placeholder: "*********", isSecure: true)
                            } else {
                                MutiTextfield(text: $loginRequest.loginModel.password, placeholder: "Password", isSecure: false)
                            }
                            Button {
                                self.showPassword.toggle()
                            } label: {
                                _showPass(label: LabelPass(icon: "eye.slash", icon1: "eye"))
                            }
                        }.frame(height: 53)
                    }.padding(.horizontal)
                    
                    NavigationLink {
                        ChangePasswords()
                    } label: {
                        _labelText(label: LabelText(text: "¿Forgot Password?"))
                    }
                    .padding(.top)
                    
                    Button {
                        loginRequest.loginRequest()
                    } label: {
                        if loginRequest.isLoading {
                            ProgressBar(color: .blue)
                        } else {
                            _labelButton(label: LabelText(text: "Sign In"))
                        }
                    }
                    .disabled(loginRequest.isValid || loginRequest.isLoading)
                    .opacity((!loginRequest.isValid && !loginRequest.isLoading) ? 1.0 : 0.5)
                    .alert("Error", isPresented: $loginRequest.alertMsg) {
                        
                    } message: {
                        Text(loginRequest.message)
                    }
                    .task {
                        loginRequest.closeSession()
                    }
                    
                    NavigationLink {
                        Registers()
                    } label: {
                        _label(label: LabelTexts(text: "¿No tienes Cuenta?", text1: "Registrate"))
                    }
                   
                    Spacer()
                }
                .padding(.horizontal)
                .listRowBackground(Color.clear)
            }
        } else {
            ContentView().environmentObject(loginRequest)
        }
    }
    
    @ViewBuilder
    private func _preview(label: LabelImage) -> some View {
        Image(label.text)
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(20)
            .padding(.top)
    }
    
    @ViewBuilder
    func _showPass(label: LabelPass) -> some View {
        Image(systemName: showPassword ? label.icon : label.icon1)
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            .font(.system(size: 18))
    }
    
    @ViewBuilder
    private func _labelButton(label: LabelText) -> some View {
        Text(label.text)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 150)
            .background(Color(colorScheme == .dark ? .gray : .blue))
            .clipShape(Capsule())
            .padding()
    }
    
    @ViewBuilder
    private func _labelText(label: LabelText) -> some View {
        Text(label.text)
            .foregroundStyle(colorScheme == .dark ? .blue : .blue)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    private func _label(label: LabelTexts) -> some View {
        HStack (alignment: .center, spacing: 5) {
            Text(label.text)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Text(label.text1)
                .foregroundStyle(colorScheme == .dark ? .blue : .blue)
        }
    }
}

#Preview {
    Login()
}
