//
//  InfoPanelView.swift
//  PinchApp
//
//  Created by Mac on 03/08/2024.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale: CGFloat ;
    var offset: CGSize;
    
    @State private var isShowInfoPanel: Bool = false;
    
    var body: some View {
        HStack(){
            Image(systemName: "circle.circle")
                .symbolRenderingMode(SymbolRenderingMode.hierarchical)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .onLongPressGesture(maximumDistance: 1) {
                    withAnimation(.easeOut) {
                        isShowInfoPanel.toggle()
                    }
                }
            
            Spacer()
            
            HStack(spacing: 2){
                Image(systemName: "arrow.up.left.arrow.down.right")
                Text("\(scale)")
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
               
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isShowInfoPanel ? 1 : 0)
            
            Spacer()
        }
        
        
        
        
        
        
    }
}

#Preview {
    InfoPanelView(scale: 1, offset: .zero)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
