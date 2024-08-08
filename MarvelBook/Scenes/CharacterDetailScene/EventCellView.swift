//
//  EventCellView.swift
//  MarvelBook
//
//  Created by Hasan Ali Şişeci on 8.08.2024.
//

import Kingfisher
import SwiftUI

struct EventCellView: View {
    let event: Event
    var body: some View {
        HStack {
            let imageURL = URL(string: "\(event.thumbnail.path).\(event.thumbnail.extension)")
            KFImage(imageURL)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(24)
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.title3)
                    .bold()
                Text(event.description)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
            }
        }
        .padding()
        .frame(width: UI.Size.Screen.width, height: 150)
    }
}

#Preview {
    EventCellView(event: Event(id: 0, title: "", description: "", thumbnail: MarvelImage(path: "", extension: "")))
}
