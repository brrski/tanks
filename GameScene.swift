//
//  GameScene.swift
//  tankz
//
//  Created by Solomon Poku on 2022-12-23.
//

import SpriteKit

class GameScene: SKScene {
    // Initialize tank sprite and position it on the screen
    let tank = SKSpriteNode(imageNamed: "tank")
    
    override func didMove(to view: SKView) {
        tank.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(tank)
        
        
        
        // Initialize left and right buttons for tank movement
        let leftButton = SKSpriteNode(imageNamed: "leftButton")
        leftButton.position = CGPoint(x: 100, y: 100)
        addChild(leftButton)
        
        let rightButton = SKSpriteNode(imageNamed: "rightButton")
        rightButton.position = CGPoint(x: 300, y: 100)
        addChild(rightButton)
        
        // Initialize fire button for tank firing
        let fireButton = SKSpriteNode(imageNamed: "fireButton")
        fireButton.position = CGPoint(x: size.width - 100, y: 100)
        addChild(fireButton)
        
        class GameScene: SKScene {
          // Initialize array to store enemy tanks
          var enemyTanks: [SKSpriteNode] = []
          
            // Initialize timer for enemy tank spawning
            var enemySpawnTimer: Timer?
          
          override func didMove(to view: SKView) {
            // Set up enemy tank spawning timer
            enemySpawnTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
              // Create enemy tank sprite and position it at a random location on the top of the screen
              let enemyTank = SKSpriteNode(imageNamed: "enemyTank")
              enemyTank.position = CGPoint(x: Int.random(in: 0...Int(self.size.width)), y: Int(self.size.height))
              self.addChild(enemyTank)
              
              // Add enemy tank to array
              self.enemyTanks.append(enemyTank)
            }
          }
        }





        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            // Loop through all touches
            for touch in touches {
                // Get the location of the touch
                let location = touch.location(in: self)
                
                // Check if the touch was on the left button
                if leftButton.frame.contains(location) {
                    // Move the tank left
                    tank.position.x -= 10
                }
                
                // Check if the touch was on the right button
                if rightButton.frame.contains(location) {
                    // Move the tank right
                    tank.position.x += 10
                }
                
                // Check if the touch was on the fire button
                if fireButton.frame.contains(location) {
                    // Fire the tank's cannon
                    let cannonball = SKSpriteNode(imageNamed: "cannonball")
                    cannonball.position = tank.position
                    addChild(cannonball)
                    
                    // Create a movement action for the cannonball
                    let moveAction = SKAction.moveTo(y: size.height, duration: 1)
                    cannonball.run(moveAction)
                }
            }
        }
        
    }
}
