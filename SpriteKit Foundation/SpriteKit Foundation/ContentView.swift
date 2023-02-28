//
//  ContentView.swift
//  SpriteKit Foundation
//
//  Created by Aashish Bansal on 27/02/23.
//

import SwiftUI
import SpriteKit

// Creaing the Class GameScene which will have the playing area for the game
class GameScene: SKScene{
    // An SKScene Object represents a scene of content
    // A Scene is a root node in the tree in a SpriteKit Node. A Node is a scene that SpriteKit animates for display. A Node is like a View.
    // In SpriteKit, we need a didMove(to: ) method which is equivalent to viewDidLoad() method in UIKit. This method runs its code when a scene is about to be presented by the View.
    override func didMove(to view: SKView) {
        // Adding Physics to the View using the SKPhysicsBody
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // This gives the whole frame the Physics we need
        // Obtain first touch from the user
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Obtaining the location where user touched first
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        // Creating a SpriteNode and setting it to the Image of dodgeBall
        let ball = SKSpriteNode(imageNamed: "dodgeBall")
        // Adding Physics to the whole Ball around the radius
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2.7)
        ball.physicsBody?.restitution = 0.4 /// This will tell how fast the ball will bounce or respond when it collides with the floor or other balls
        ball.position = location /// Setting the location to where the user touched the screen with its finger
        addChild(ball) /// Adding ball to the scene
    }
    
    // Adding the touchesMoved() method will add dodgeBall to all the locations when we move the finger while touching the screen (during swipe)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let ball = SKSpriteNode(circleOfRadius: ball.size.width / 2.7)
        ball.physicsBody?.restitution = 0.4
        ball.position = location
        addChild(ball)
    }
}

struct ContentView: View {
    // Creating the View
    var scene: SKScene{
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        return scene
    }
    var body: some View {
        ZStack {
            // Coloring the Background with Gradient to Border the Scene
            LinearGradient(gradient: Gradient(colors: [.black, Color.white.opacity(0.8), .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // Creating the Scene to render the SpriteKit View
            VStack{
                SpriteView(scene: scene)
                    .frame(width: 320, height: 650)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
