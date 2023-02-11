//
//  TestView.swift
//  NaverMapDemo
//
//  Created by 강창현 on 2023/01/27.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Hello, World!")
                Text("Hello, World!")
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text("Hello, World!")
                Text("Hello, World!")
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
//            .navigationTitle("둘러보기")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
