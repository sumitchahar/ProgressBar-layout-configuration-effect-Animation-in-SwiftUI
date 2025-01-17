//
//  ProgreshBarAnimations.swift
//  ProgreshBar
//
//  Created by Sumit on 13/01/25.
//

import SwiftUI

 struct ProgressBarAnimations: View {
    
// different state of progressBar...0.0 to 1.0 means 0% to 100% ratio factor..
    @State var progressBarCount:CGFloat = 0.0
     
    @State var progressBarFillRatioTextCount:String?
    @State var progressBarWidth:CGFloat = 0.0
//
    @State private var startAnimation = true
    @State private var duration = 0.8
//
    @State private var lineduration = 3.4
    @State private var thinking: Bool = false
//
    let letters = Array("@-Progress title")
    var body: some View {
         GeometryReader { proxy in
             VStack(alignment:.leading) {
                    Spacer()
                 ZStack {
                    HStack {
                        Rectangle()
                            .fill(Color(red: 211 / 255, green: 211 / 255, blue: 211 / 255))
                            .stroke(.red,lineWidth: 1.0)
                            .frame(width:proxy.size.width,height:5.0)
                            .cornerRadius(5.0/2)
                            .phaseAnimator([false, true]) { wwdc24, chromaRotate in
                                wwdc24
                                    .hueRotation(.degrees(chromaRotate ? 360 : 0))
                            } animation: { chromaRotate in
                                    .easeInOut(duration: 0.1)
                            }
                        Spacer()
                    }
                    HStack {
                        RoundedRectangle(cornerRadius: 5.0/2)
                            .strokeBorder(style: StrokeStyle(lineWidth: 3,lineCap: .round,lineJoin: .round, dash: [40,400],dashPhase: startAnimation ? 220 : -220))
                            .frame(width:proxy.size.width,height:7.0)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.indigo, .white,.purple,.mint,.white,.orange,.indigo]), startPoint: .trailing, endPoint: .leading))
                            .animation(.easeInOut(duration: lineduration).repeatForever(autoreverses: false),
                                       value: startAnimation
                            )
                    }
                    HStack {
                        Rectangle()
                            .fill(.red)
                            .frame(width:progressBarWidth,height:4.0)
                            .background(.red)
                            .cornerRadius(4.0/2)
                            .phaseAnimator([false, true]) { wwdc24, chromaRotate in
                                wwdc24
                                    .hueRotation(.degrees(chromaRotate ? 360 : 0))
                            } animation: { chromaRotate in
                                    .easeInOut(duration: 0.1)
                            }
                        Spacer()
                    }
                    .onChange(of: progressBarCount, initial: true) {
                        progressBarWidth = proxy.size.width * progressBarCount
                        let finalRatio = 100 * progressBarCount
                        progressBarFillRatioTextCount = Int(finalRatio).description + "%"
                    }
                }
                HStack {
                    HStack(spacing: 0) {
                        ForEach(0..<letters.count, id: \.self) { think in
                            Text(String(letters[think]))
                                .foregroundStyle(.blue)
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .hueRotation(.degrees(thinking ? 220 : 0))
                                .opacity(thinking ? 0 : 1)
                                .scaleEffect(x: thinking ? 0.75 : 1, y: thinking ? 1.25 : 1, anchor: .bottom)
                                .animation(.easeInOut(duration: 0.5).delay(1).repeatForever(autoreverses: false).delay(Double(think) / 20), value: thinking)
                        }
                    }
                    .padding(.top)
                    ZStack {
                        Circle()
                            .strokeBorder(.brown, lineWidth: 2)
                            .cornerRadius(progressBarCount == 1.0 ? 98/2 : 80/2)
                            .frame(width:progressBarCount == 1.0 ? 48: 38,height:progressBarCount == 1.0 ? 48: 38)
                            .shadow(color:.clear,radius: 5)
                            .overlay(content: {
                                Text(progressBarFillRatioTextCount ?? "")
                                    .frame(width:progressBarCount == 1.0 ? 48: 38,height:progressBarCount == 1.0 ? 48: 38)
                                    .font(.system(size: 12, weight: .bold, design: .default))
                                    .cornerRadius(140/2)
                                    .clipped()
                            })
                        Circle()
                            .fill(.white)
                            .frame(width: 3, height: 3, alignment: .center)
                            .cornerRadius(6/2)
                            .offset(x: progressBarCount == 1.0 ? -23 : -19)
                            .rotationEffect(.degrees(startAnimation ? 360 : 0))
                            .animation(.easeInOut(duration: duration).repeatForever(autoreverses: false),
                                       value: startAnimation
                        )
                    }
                    .padding(.top)
                }
                    Spacer()
            }
            .padding()
        }
        .onAppear {
         // input or outPut Ratio of progressBar 0.0 to 1.0 //
            self.progressBarCount = 0.7
            withAnimation {
                self.startAnimation.toggle()
                thinking = true
             }
         }
     }
  }
 #Preview {
     ProgressBarAnimations()
         .preferredColorScheme(.dark)
 }





