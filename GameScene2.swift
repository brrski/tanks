import SpriteKit

class GameScene: SKScene {
    // MARK: - Properties
    private let tank = SKSpriteNode(imageNamed: "tank")
    private var leftButton: SKSpriteNode!
    private var rightButton: SKSpriteNode!
    private var fireButton: SKSpriteNode!
    private var enemyTanks: [SKSpriteNode] = []

    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        setupTank()
        setupButtons()
        setupEnemySpawning()
    }

    // MARK: - Setup Functions
    private func setupTank() {
        tank.position = CGPoint(x: size.width / 2, y: size.height / 4)
        addChild(tank)
    }

    private func setupButtons() {
        leftButton = createButton(named: "leftButton", at: CGPoint(x: 100, y: 100))
        rightButton = createButton(named: "rightButton", at: CGPoint(x: 300, y: 100))
        fireButton = createButton(named: "fireButton", at: CGPoint(x: size.width - 100, y: 100))
    }

    private func createButton(named imageName: String, at position: CGPoint) -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: imageName)
        button.position = position
        addChild(button)
        return button
    }

    private func setupEnemySpawning() {
        let spawnAction = SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run { self.spawnEnemyTank() },
                SKAction.wait(forDuration: 2.0)
            ])
        )
        run(spawnAction)
    }

    private func spawnEnemyTank() {
        let enemyTank = SKSpriteNode(imageNamed: "enemyTank")
        enemyTank.position = CGPoint(
            x: CGFloat.random(in: 0...size.width),
            y: size.height
        )
        addChild(enemyTank)
        enemyTanks.append(enemyTank)

        // Move the enemy tank down
        let moveAction = SKAction.moveTo(y: 0, duration: 4)
        let removeAction = SKAction.removeFromParent()
        enemyTank.run(SKAction.sequence([moveAction, removeAction]))
    }

    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        switch location {
        case _ where leftButton.contains(location):
            tank.position.x = max(tank.position.x - 10, 0)
        case _ where rightButton.contains(location):
            tank.position.x = min(tank.position.x + 10, size.width)
        case _ where fireButton.contains(location):
            fireCannon()
        default:
            break
        }
    }

    // MARK: - Cannon Fire
    private func fireCannon() {
        let cannonball = SKSpriteNode(imageNamed: "cannonball")
        cannonball.position = tank.position
        addChild(cannonball)

        let moveAction = SKAction.moveTo(y: size.height, duration: 1)
        let removeAction = SKAction.removeFromParent()
        cannonball.run(SKAction.sequence([moveAction, removeAction]))
    }
}