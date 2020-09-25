//
//  CustomModifier.swift
//  RRSwiftUIDemo
//
//  Created by Rahul Mayani on 25/09/20.
//

import SwiftUI

struct ListingTextModifier : ViewModifier {
    
    var fontSize: CGFloat = 16.0
    var color: Color = .black
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .foregroundColor(color)
    }
}

struct DetailsTextModifier : ViewModifier {
    
    var fontSize: CGFloat = 15.0
    var padding:Edge.Set = .leading
    var alignment: TextAlignment = .leading
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
            .foregroundColor(.black)
            .padding(padding, 10.0)
            .multilineTextAlignment(alignment)
    }
}
