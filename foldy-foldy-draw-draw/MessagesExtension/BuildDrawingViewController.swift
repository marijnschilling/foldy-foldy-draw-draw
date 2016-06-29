import UIKit

class BuildDrawingViewController: UIViewController {
    
    static let storyboardIdentifier = "BuildDrawingViewController"

    var drawing: Drawing?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBAction func foldButtonPressed(_ sender: AnyObject) {
    }
}
