//
//  ViewController.swift
//  Constraints
//
//  Created by Maksim Bulat on 9/28/20.
//

import UIKit

class ViewController: UIViewController {

    enum Direction {
        case up, down
    }
    @IBOutlet weak var purpleView: UIView!
    let greenView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        purpleView.frame.size = CGSize(width: 100, height: 100)
        purpleView.layer.cornerRadius = 50
        greenView.backgroundColor = .green
        greenView.frame.size = purpleView.frame.size
        greenView.layer.cornerRadius = 50
        view.addSubview(greenView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        purpleView.center.y = view.center.y
        purpleView.center.x = view.frame.width / 3
        
        greenView.center.y = view.center.y
        greenView.center.x = view.frame.width * 2 / 3
    }
    
    func animateCircle(direction: Direction, completion: @escaping () -> ()) {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
            self.purpleView.center.y = 0
            switch direction {
            case .up:
                self.purpleView.center.y = 0
            case .down:
                self.purpleView.center.y = self.view.center.y
            }
        }) { (_) in
            completion()
        }
    }

    @IBAction func animateButtonPressed(_ sender: Any) {
        animateCircle(direction: .up) {
            print("Reverse")
            self.animateCircle(direction: .down) {
                print("I'm ready")
            }
        }
    }
    
}

