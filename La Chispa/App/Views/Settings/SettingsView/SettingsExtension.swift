//
//  SettingsExtension.swift
//  La Chispa
//
//  Created by Pedro Omar  on 9/16/25.
//

import SwiftUI

extension Settings {
    @ViewBuilder
    func _labelFaceId(label: LabelIcon) -> some View {
        HStack (alignment: .center, spacing: 12) {
            ZStack (alignment: .center) {
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .fill(colorScheme == .dark ? .black : .green)
                    .frame(width: 30, height: 30)
                Image(systemName: label.icon)
                    .foregroundStyle(colorScheme == .dark ? .green : .white)
                    .font(.system(size: 20, weight: .medium))
            }
            Text(label.text)
                .lineLimit(1)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}
