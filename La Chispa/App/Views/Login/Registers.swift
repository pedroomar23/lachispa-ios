//
//  Registers.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/15/25.
//

import SwiftUI

struct Registers : View {
    
    @StateObject var register = Register()
    @Environment(\.colorScheme) var colorScheme
    @State var showPassword : Bool = true
    
    var body: some View {
        if #available(iOS 16, *) {
            ContentNavigation {
                VStack {
                    MutiTextfield(text: $register.registerRequest.email, placeholder: "email")
                        .frame(height: 55)
                        .padding(.horizontal)
                   
                    MutiTextfield(text: $register.registerRequest.username, placeholder: "username")
                        .frame(height: 55)
                        .padding(.horizontal)
                    
                    ZStack {
                        HStack {
                            if showPassword {
                                MutiTextfield(text: $register.registerRequest.password_repeat, placeholder: "********", isSecure: true)
                            } else {
                                MutiTextfield(text: $register.registerRequest.password_repeat, placeholder: "Password", isSecure: false)
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
                                MutiTextfield(text: $register.registerRequest.password, placeholder: "********", isSecure: true)
                            } else {
                                MutiTextfield(text: $register.registerRequest.password, placeholder: "Password", isSecure: false)
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
                        register.registersRequest()
                    } label: {
                        if register.isLoading {
                            ProgressBar(color: .blue)
                        } else {
                            _label(label: LabelText(text: "Registrarse"))
                        }
                    }
                    .padding(.top)
                    .disabled(register.isValid || register.isLoading)
                    .opacity((register.isValid && register.isLoading) ? 1.0 : 0.5)
                    .alert("Register", isPresented: $register.failureMsg) {
                        
                    } message: {
                        Text(register.registerMsg)
                    }
                    .alert("Error", isPresented: $register.alertMsg) {
                        
                    } message: {
                        Text(register.message)
                    }
                  
                    Spacer()
                }
                .padding(.horizontal)
                .toolbar {
                   _toolbar(label: LabelText(text: "Registrarse"))
                }
                .environmentObject(register)
            }
        } else {
            VStack {
                MutiTextfield(text: $register.registerRequest.email, placeholder: "email")
                    .frame(height: 55)
                    .padding(.horizontal)
                
                MutiTextfield(text: $register.registerRequest.username, placeholder: "username")
                    .frame(height: 55)
                    .padding(.horizontal)
                
                ZStack {
                    HStack {
                        if showPassword {
                            MutiTextfield(text: $register.registerRequest.password_repeat, placeholder: "********", isSecure: true)
                        } else {
                            MutiTextfield(text: $register.registerRequest.password_repeat, placeholder: "Password", isSecure: false)
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
                            MutiTextfield(text: $register.registerRequest.password, placeholder: "********", isSecure: true)
                        } else {
                            MutiTextfield(text: $register.registerRequest.password, placeholder: "Password", isSecure: false)
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
                    register.registersRequest()
                } label: {
                    if register.isLoading {
                        ProgressBar(color: .blue)
                    } else {
                        _label(label: LabelText(text: "Registrase"))
                    }
                }
                .padding(.top)
                .disabled(register.isValid)
                .opacity((register.isValid && register.isLoading) ? 1.0 : 0.5)
                .alert("Register", isPresented: $register.failureMsg) {
                    
                } message: {
                    Text(register.registerMsg)
                }
                .alert("Error", isPresented: $register.alertMsg) {
                    
                } message: {
                    Text(register.message)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
               _toolbar(label: LabelText(text: "Registrarse"))
            }
            .environmentObject(register)
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
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            .font(.system(size: 18))
    }
    
    @ViewBuilder
    private func _label(label: LabelText) -> some View {
        Text(label.text)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 150)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding()
    }
}

#Preview {
    Registers()
}
