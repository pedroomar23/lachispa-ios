//
//  FaceID.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/16/25.
//

import SwiftUI

struct FaceID : View {
    
    @StateObject var security = Security()
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("passcode") var passcode : String = "0"
    
    let passcodeTime = ["0", "1", "5", "15", "30"]
    
    var body : some View {
        List {
            Section {
                
            }
            Section {
                Toggle(isOn: $security.authenticated) {
                    _labelTooggle(label: LabelPass(icon: "lock", icon1: "lock.open"))
                }
            }
            Section {
                if security.authenticated {
                    Picker("", selection: $passcode) {
                        ForEach(passcodeTime, id: \.self) { time in
                            Text(passcodeTitle(time)).tag(time)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                    .task(id: security.authenticated) {
                        security.authenticated = true 
                    }
                }
            }
        }
        .environmentObject(security)
        .listStyle(.insetGrouped)
        .toolbar {
            _titleView(label: LabelText(text: "Face ID & Passcode"))
        }
    }
    
    @ToolbarContentBuilder
    private func _titleView(label: LabelText) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(label.text)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
    
    @ViewBuilder
    private func _labelTooggle(label: LabelPass) -> some View {
        HStack (alignment: .center, spacing: 12) {
            if security.authenticated {
                Image(systemName: label.icon)
                    .foregroundStyle(colorScheme == .dark ? .green : .green)
                    .font(.system(size: 20, weight: .medium))
            } else {
                Image(systemName: label.icon1)
                    .foregroundStyle(colorScheme == .dark ? .green : .green)
                    .font(.system(size: 20, weight: .medium))
            }
            Text("Enable Face ID")
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
   private func passcodeTitle(_ time: String) -> LocalizedStringKey {
        switch time {
        case "0":
            return "settings-biometric-immediatley"
        case "1":
            return "settings-biometric-1"
        case "5":
            return "settings-biometric-5"
        case "15":
            return "settings-biometric-15"
        case "30":
            return "settings-biometric-30"
        default:
            return "settings-biometric-immediatley"
        }
    }
}

#Preview {
    FaceID()
}
