//
//  ViewController.swift
//  Measureify
//
//  Created by Gokul Nair on 10/10/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var distanceLbl: UILabel!
    
    var dotNodes = [SCNNode]()
    
    var textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        configuration.planeDetection = .vertical
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if dotNodes.count >= 2 {
            for dot in dotNodes{
                dot.removeFromParentNode()
            }
            dotNodes = [SCNNode]()
        }
        
        if let touchLocation = touches.first?.location(in: sceneView){
            let hitTestResult = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResult.first {
                addDot(at:hitResult)
            }
        }
    }
    
    
    func addDot(at hitResult: ARHitTestResult){
        let sphere = SCNSphere(radius: 0.002)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.blue
        
        sphere.materials = [material]
        
        let dotNode = SCNNode()
        
        dotNode.geometry = sphere
        
        dotNode.position = SCNVector3(x: hitResult.worldTransform.columns.3.x, y: hitResult.worldTransform.columns.3.y
                                      , z: hitResult.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        
        dotNodes.append(dotNode)
        
        if dotNodes.count >= 2 {
            calculate()
        }
    }
    
    func calculate(){
        let start = dotNodes[0]
        let end = dotNodes[1]
    
       findDistance(point1: start, point2: end)
        
    }
    func findDistance(point1: SCNNode , point2: SCNNode){
        
        let a = point2.position.x - point1.position.x
        let b = point2.position.y - point1.position.y
        let c = point2.position.z - point1.position.z
        
        let distance = sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2))
        
        distanceLbl.text? = String(abs(distance))
        arTextlbl(text: String(abs(distance)) + " m", atPosition: point1.position)
        
    }
    
    
    func arTextlbl(text: String, atPosition position: SCNVector3){
        
        textNode.removeFromParentNode()
        
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.green
        textNode = SCNNode(geometry: textGeometry)
        
        textNode.position = SCNVector3(x: position.x
                                       , y: position.y + 0.0, z: position.z)
        textNode.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        sceneView.scene.rootNode.addChildNode(textNode)
    }
}
