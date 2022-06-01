//
//  AppIconFromBundle.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 1/2/21.
//

import SwiftUI

extension Bundle {
    var iconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
    }
}

struct AppIconFromBundle: View {
    var body: some View {
        Bundle.main.iconFileName
            .flatMap { UIImage(named: $0) }
            .map { Image(uiImage: $0).resizable() }
    }
}
