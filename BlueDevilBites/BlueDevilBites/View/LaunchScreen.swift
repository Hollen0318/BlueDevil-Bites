import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color.black // Set the background color to black
                .ignoresSafeArea()

            VStack {
                Image("appicon") // Use your app icon image here
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color.blue) // Set the image color to blue
                
                Text("Loading...")
                    .font(.custom("Zapfino", size: 30)) // Use a custom stylish font
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .foregroundColor(Color.blue) // Set the text color to blue
            }.offset(y:-80)
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
