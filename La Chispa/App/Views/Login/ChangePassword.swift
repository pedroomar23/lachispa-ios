//
//  ChangePassword.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/15/25.
//

import SwiftUI

struct ChangePasswords : View {
    
    @StateObject var passRequest = ChangePassword()
    @Environment(\.colorScheme) var colorScheme
    @State var showPassword : Bool = true
    
    var body : some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                VStack {
                    _preView(label: LabelImage(text: "LaunchImage"))
                  
                    ZStack {
                        HStack {
                            if showPassword {
                                MutiTextfield(text: $passRequest.passRequest.password, placeholder: "********", isSecure: true)
                            } else {
                                MutiTextfield(text: $passRequest.passRequest.password, placeholder: "Password", isSecure: false)
                            }
                            Button {
                                self.showPassword.toggle()
                            } label: {
                                _labelButton(label: LabelPass(icon: "eye.slash", icon1: "eye"))
                            }
                        }.frame(height: 55)
                    }.padding(.horizontal)
                    
                    ZStack {
                        HStack {
                            if showPassword {
                                MutiTextfield(text: $passRequest.passRequest.password_repeat, placeholder: "********", isSecure: true)
                            } else {
                                MutiTextfield(text: $passRequest.passRequest.password_repeat, placeholder: "Password", isSecure: false)
                            }
                            Button {
                                self.showPassword.toggle()
                            } label: {
                                _labelButton(label: LabelPass(icon: "eye.slash", icon1: "eye"))
                            }
                        }.frame(height: 55)
                    }.padding(.horizontal)
                    
                    Button {
                        passRequest.changePassRequest()
                    } label: {
                        _buttonText(label: LabelText(text: "Cambiar Contraseña"))
                    }
                    .padding(.top)
                    .disabled(passRequest.isValid || passRequest.isLoading)
                    .opacity((!passRequest.isValid && !passRequest.isLoading) ? 1.0 : 0.5)
                    .alert("Change", isPresented: $passRequest.successMsg) {
                        
                    } message: {
                        Text(passRequest.acceptMsg)
                    }
                    .alert("Error", isPresented: $passRequest.failureMsg) {
                        
                    } message: {
                        Text(passRequest.message)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .toolbar {
                    _toolbar(label: LabelText(text: "Cambiar Contraseña"))
                }
                .environmentObject(passRequest)
            }
        } else {
            VStack {
                _preView(label: LabelImage(text: "LaunchImage"))
              
                ZStack {
                    HStack {
                        if showPassword {
                            MutiTextfield(text: $passRequest.passRequest.password, placeholder: "********", isSecure: true)
                        } else {
                            MutiTextfield(text: $passRequest.passRequest.password, placeholder: "Password", isSecure: false)
                        }
                        Button {
                            self.showPassword.toggle()
                        } label: {
                            _labelButton(label: LabelPass(icon: "eye.slash", icon1: "eye"))
                        }
                    }
                    .frame(height: 55)
                }.padding(.horizontal)
                
                ZStack {
                    HStack {
                        if showPassword {
                            MutiTextfield(text: $passRequest.passRequest.password_repeat, placeholder: "********", isSecure: true)
                        } else {
                            MutiTextfield(text: $passRequest.passRequest.password_repeat, placeholder: "Password", isSecure: false)
                        }
                        Button {
                            self.showPassword.toggle()
                        } label: {
                            _labelButton(label: LabelPass(icon: "eye.slash", icon1: "eye"))
                        }
                    }
                    .frame(height: 55)
                }.padding(.horizontal)
                
                Button {
                    passRequest.changePassRequest()
                } label: {
                    _buttonText(label: LabelText(text: "Cambiar Contraseña"))
                }
                .padding(.top)
                .disabled(passRequest.isValid || passRequest.isLoading)
                .opacity((!passRequest.isValid && !passRequest.isLoading) ? 1.0 : 0.5)
                .alert("Change", isPresented: $passRequest.successMsg) {
                    
                } message: {
                    Text(passRequest.acceptMsg)
                }
                .alert("Error", isPresented: $passRequest.failureMsg) {
                    
                } message: {
                    Text(passRequest.message)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                _toolbar(label: LabelText(text: "Cambiar Contraseña"))
            }
            .environmentObject(passRequest)
        }
    }
    
    @ToolbarContentBuilder
    private func _toolbar(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 18, weight: .medium))
        }
    }
    
    @ViewBuilder
    private func _labelButton(label: LabelPass) -> some View {
        Image(systemName: showPassword ? label.icon : label.icon1)
            .font(.system(size: 18))
            .foregroundStyle(colorScheme == .dark ? .white : .black)
    }
    
    @ViewBuilder
    private func _buttonText(label: LabelText) -> some View {
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
    private func _preView(label: LabelImage) -> some View {
        Image(label.text)
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(20)
            .padding()
    }
}

#Preview {
    ChangePasswords()
}
