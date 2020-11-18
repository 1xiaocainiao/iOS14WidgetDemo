//
//  ContentView.swift
//  WidgetDemo
//
//  Created by xxf on 2020/11/18.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        
        if let imageData = try? Data(contentsOf: URL(string: "http://qukufile2.qianqian.com/data2/pic/8b1aab6be81f10639c01c1401a20463c/675021896/675021896.jpg@s_2,w_90,h_90")!) {
            Image(uiImage: UIImage(data: imageData)!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
