import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        self.presentViewController(for: conversation, with: presentationStyle)
    }

    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }

        // Present the view controller appropriate for the conversation and presentation style.
        presentViewController(for: conversation, with: presentationStyle)
    }

    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        // Determine the controller to present.
        let controller: UIViewController
        
        if presentationStyle == .compact {
            controller = instantiateDrawingsController()
        }
        else {
            
            let drawing = Drawing()
            
            if drawing.isComplete {
                controller = instantiateCompletedDrawingController(with: drawing)
            }
            else {
                controller = instantiateBuildDrawingViewController(with: drawing)
            }
        }
        
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }

    private func instantiateDrawingsController() -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: DrawingViewController.storyboardIdentifier) as? DrawingViewController else { fatalError("Unable to instantiate a DrawingViewController from the storyboard") }

        controller.delegate = self
        return controller
    }

    private func instantiateCompletedDrawingController(with drawing: Drawing) -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: CompletedDrawingViewController.storyboardIdentifier) as? CompletedDrawingViewController else { fatalError("Unable to instantiate a CompletedDrawingController from the storyboard") }

        controller.drawing = drawing

        return controller
    }

    private func instantiateBuildDrawingViewController(with drawing: Drawing) -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: BuildDrawingViewController.storyboardIdentifier) as? BuildDrawingViewController else { fatalError("Unable to instantiate a BuildDrawingViewController from the storyboard") }

        controller.drawing = drawing

        return controller
    }
}

extension MessagesViewController: DrawingViewControllerDelegate {
    func drawingViewControllerDidSelectAdd(_ controller: DrawingViewController) {
        requestPresentationStyle(.expanded)
    }
}
