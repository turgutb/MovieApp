import UIKit
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let devCourses = [("Laravel"),("Swift"),("Apple"),("Window"),("Android")]
    let devCousesImages = [UIImage(named: "Laravel"), UIImage(named: "swift"), UIImage(named: "Laravel"), UIImage(named: "window"), UIImage(named: "Android")]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devCourses.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableTableViewCell
        cell.photo.image=self.devCousesImages[indexPath .row]
        cell.label.text=self.devCourses[indexPath .row]
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegue(withIdentifier: "SendDataSegue", sender: self)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SendDataSegue" {
            let indexPaths = self.tableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destinationViewController as! ThirdViewController
            vc.image = self.devCousesImages[indexPath.row]!
            vc.textt = self.devCourses[indexPath.row]
        }
    }
}
