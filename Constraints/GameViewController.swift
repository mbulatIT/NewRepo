//
//  GameViewController.swift
//  Constraints
//
//  Created by Maksim Bulat on 9/29/20.
//

import UIKit

class GameViewController: UIViewController {
    
    private enum Direction {
        case left, right
    }
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    let backgroundImageView = UIImageView()
    let backgroundImageView1 = UIImageView()
    let carImageView = UIImageView()
    private var isGameInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.addSubview(backgroundImageView)
        leftButton.layer.borderWidth = 1
        rightButton.layer.borderWidth = 1
        leftButton.layer.borderColor = UIColor.black.cgColor
        rightButton.layer.borderColor = UIColor.black.cgColor
        backgroundView.addSubview(backgroundImageView1)
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.image = UIImage(named: "road_image")
        backgroundImageView1.contentMode = .scaleToFill
        backgroundImageView1.image = UIImage(named: "road_image")
        
        carImageView.frame.size = CGSize(width: view.frame.width / 10, height: view.frame.width / 5)
        carImageView.center.y = view.center.y * 1.5
        carImageView.contentMode = .scaleToFill
        carImageView.image = UIImage(named: "car_image")
        backgroundView.addSubview(carImageView)
        startNewGame()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundImageView.frame = CGRect(x: 0, y: -view.frame.height, width: view.frame.width, height: view.frame.height)
        backgroundImageView1.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    func startRoadAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveLinear], animations: {
            self.backgroundImageView.frame.origin = CGPoint(x: 0, y: 0)
            self.backgroundImageView1.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
        }) { (isFinished) in
            if isFinished {
                self.backgroundImageView.frame.origin = CGPoint(x: 0, y: -self.view.frame.height)
                self.backgroundImageView1.frame.origin = CGPoint(x: 0, y: 0)
                if self.isGameInProgress {
                    self.startRoadAnimation()
                }
            }
        }
    }
    
    private func animateCarMove(_ sender: UIButton, direction: Direction) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            var delta: CGFloat = 0
            switch direction {
            case .left:
                delta = -40
            case .right:
                delta = 40
            }
            self.carImageView.center.x += delta
        }) { _ in
            guard self.carImageView.frame.origin.x > 0,
                self.carImageView.frame.origin.x + self.carImageView.frame.width < self.view.frame.width else {
                self.gameOver()
                return
            }
            if sender.isHighlighted {
                self.animateCarMove(sender, direction: direction)
            }
        }
    }
    
    private func gameOver() {
        isGameInProgress = false
        let alert = UIAlertController(title: "Boom", message: "Game Over", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_) in
            self.startNewGame()
        }))
        present(alert, animated: true)
    }
    
    private func startNewGame() {
        isGameInProgress = true
        carImageView.center.x = view.center.x
        startRoadAnimation()
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        animateCarMove(sender, direction: .left)
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        animateCarMove(sender, direction: .right)
    }
    
}
