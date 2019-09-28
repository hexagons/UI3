# UI3

3D UI lib for SwiftUI

<img src="https://github.com/hexagons/UI3/blob/master/Images/ui3_stacks_frame.png?raw=true" height="256"/>

~~~~swift
import SwiftUI
import UI3

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            UI3 {
                HStack {
                    Box()
                        .cornerRadius(0.05)
                    Box()
                        .cornerRadius(0.05)
                        .frame(width: 0.25)
                    VStack {
                        Box()
                            .cornerRadius(0.05)
                        Box()
                            .cornerRadius(0.05)
                            .frame(height: 0.25)
                        ZStack {
                            Box()
                                .cornerRadius(0.05)
                            Box()
                                .cornerRadius(0.05)
                                .frame(length: 0.25)
                            Box()
                                .cornerRadius(0.05)
                        }
                    }
                }
            }
        }
    }
}
~~~~
