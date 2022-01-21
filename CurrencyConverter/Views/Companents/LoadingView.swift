import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
       
            ZStack(alignment: .center) {
                if !self.isShowing {
                    self.content()
                } else {
                    ZStack {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)

                    VStack {
                        ProgressView()
                            .padding()
                            

                        Text("Lütfen bekleyin")
                    }
                    .frame(width: getRect().width / 2.0, height: 180.0)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isShowing: .constant(true)) {
            NavigationView {
                Text("Hello World")
                    .navigationBarTitle(Text("List"), displayMode: .large)
            }
        }
    }
}
