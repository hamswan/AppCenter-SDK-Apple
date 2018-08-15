import UIKit

class MSAuthenticationViewController : UITableViewController, AppCenterProtocol {

  var appCenter: AppCenterDelegate!
  var currentAction = MSSignInViewController.AuthAction.login

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let signInController = segue.destination as? MSSignInViewController {
      signInController.action = currentAction
      signInController.onAuthDataReceived = { [weak self](token, userId, expiresAt) in
        if let vc = self {
          vc.appCenter.addAuthenticationProvider(withUserId: userId, expiryDate: expiresAt, andAccessToken: token)
        }
      }
    }
  }

  @IBAction func login() {
    showSignInController(action: MSSignInViewController.AuthAction.login)
  }

  @IBAction func signOut() {
    showSignInController(action: MSSignInViewController.AuthAction.signout)
  }

  @IBAction func dismiss() {
    dismiss(animated: true, completion: nil)
  }

  func showSignInController(action: MSSignInViewController.AuthAction) {
    currentAction = action
    self.performSegue(withIdentifier: "ShowSignIn", sender: self)
  }
}

