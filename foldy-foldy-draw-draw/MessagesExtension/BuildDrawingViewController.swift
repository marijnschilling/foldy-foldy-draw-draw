import UIKit

protocol BuildDrawingViewControllerDelegate: class {

}

class BuildDrawingViewController: UIViewController {
    
    static let storyboardIdentifier = "BuildDrawingViewController"

    var drawing: Drawing?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var drawingView: NWADrawingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "Draw a head!"
        self.instructionLabel.text = "Extend the neck under the line"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    @IBAction func foldButtonPressed(_ sender: AnyObject) {

    }
}
