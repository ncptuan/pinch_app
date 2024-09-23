//
//  ContentView.swift
//  PinchApp
//
//  Created by Mac on 27/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimation: Bool = false;
    @State private var scaleImage: CGFloat = 1;
    @State private var imageOffset: CGSize = CGSize.zero;
    @State private var isShowThumbnail: Bool = true;
    
    let pages : [Page] = pagesData;
    @State private var pageIndex = 0;
    
    func resetFunction() {
        return withAnimation (.spring) {
            scaleImage = 1
            imageOffset = CGSize.zero
        }
    }
    
    func currentImage() -> String {
        return pages[pageIndex].imageName;
    }
    
    var body: some View {
        NavigationView{
            ZStack(){
                Color.clear
                Image(self.currentImage())
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 10, x:2, y:2)
                    .opacity(isAnimation ? 1 : 0)
                    .scaleEffect(scaleImage)
                    .onTapGesture(count: 2, perform: {
                        if scaleImage == 1 {
                            withAnimation(.spring){
                                scaleImage = 5;
                            }
                        }else{
                            resetFunction()
                            
                        }
                    })
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                withAnimation (.spring) {
                                    imageOffset = gesture.translation;
                                }
                            })
                            .onEnded({ end in
                                if scaleImage < 1 {
                                    resetFunction()
                                    withAnimation (.spring) {
                                        scaleImage = 1
                                        imageOffset = CGSize.zero
                                    }
                                    
                                }
                                
                            })
                        
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ magnify in
                                withAnimation {
                                    if magnify > 1 {
                                        scaleImage = magnify;
                                    }
                                }
                            })
                    )
                
            }//: ZStacks
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimation = true;
                }
            })
            //            MARK: Position display
            .overlay (
                InfoPanelView(scale: scaleImage, offset: imageOffset)
                    .padding(16)
                ,
                alignment: .top
            )
            
            
            // MARK: Control button
            .overlay (
                Group{
                    HStack(
                        spacing: 12
                    ){
                        Button{
                            withAnimation {
                                if scaleImage > 1{
                                    scaleImage -= 1;
                                    if scaleImage < 1 {
                                        scaleImage  = 1;
                                    }
                                }
                            }
                        }label: {
                            Image(systemName: "minus.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        
                        Button{
                            resetFunction()
                        }label: {
                            Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        
                        Button{
                            withAnimation {
                                scaleImage += 1;
                            }
                            
                        }label: {
                            Image(systemName: "plus.magnifyingglass")
                            
                                .font(.system(size: 36))
                        }
                    }
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .padding(.bottom, 40)
                    
                },
                alignment: .bottom
            )
            
            // MARK: Thumbnail
            
            .overlay (
                HStack (
                    spacing: 12
                ){
                    
                    Button{
                        withAnimation {
                            isShowThumbnail.toggle()
                        }
                        
                    } label : {
                        Image(systemName: isShowThumbnail ?  "chevron.compact.right" : "chevron.compact.left")
                            .padding(8)
                            .font(.system(size: 40))
                    }
                    ForEach(pages){ item in
                        Image(item.thumbnail)
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 12)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .onTapGesture {
                                pageIndex = item.id - 1;
                            }
                    }
                    Spacer()
                }
                .background(.ultraThinMaterial)
                .frame(width: 200)
                .cornerRadius(8)
                .offset(x: isShowThumbnail ? 15: 165)
                .padding(.top, UIScreen.main.bounds.height/12),
                alignment: .topTrailing
            )
            
            
            
        }//: Navigation
        .navigationViewStyle(.stack) // avoid show side bar on ipad
        
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
