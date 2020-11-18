//
//  GKWYWidgetView.swift
//  WidgetDemo
//
//  Created by xxf on 2020/11/18.
//

import SwiftUI
import WidgetKit

struct GKWYWidgetView: View {
    let data: GKWYData
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                Image(uiImage: data.bgImage!)
                    .resizable()

                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.15), Color.black.opacity(0.35)]),
                               startPoint: .top,
                               endPoint: .bottom)

                Image("cm2_clock_logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .position(x: geo.size.width - (20/2) - 10, y: (20/2) + 10)
                    .ignoresSafeArea(.all)

                VStack(alignment: .leading, spacing: 5) {
                    HStack() {
                        Image(data.icon)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(data.title)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }

                    Text(data.desc)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }.padding()
            }
        }
    }
}

struct GKWYWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        GKWYWidgetView(data: defaultData).previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
