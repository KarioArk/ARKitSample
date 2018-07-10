//
//  ViewController.swift
//  DefaultAR
//
//  Created by thiruvadisamy on 07/07/18.
//  Copyright © 2018 com.framework. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var object: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/Lincoln_rigged.scn")!
//
//        scene.rootNode.position = SCNVector3(0, 0, 0)
        
//        let exterior = scene.rootNode.childNode(withName: "lincoln_exterior", recursively: true)
//        exterior?.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        // Set the scene to the view
//        sceneView.scene = scene
        
//        let exterior1 = scene.rootNode.childNode(withName: "lincoln_exterior", recursively: true)
//        exterior1?.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    func sessionWasInterrupted(_ session: ARSession) {
        //infoLabel.text = "Session was interrupted"
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        //infoLabel.text = "Session interruption ended"
        resetTracking()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        //infoLabel.text = "Session failed: \(error.localizedDescription)"
        resetTracking()
    }
    
    func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        // help us inform the user when the app is ready
//        switch camera.trackingState {
//        case .normal :
//           // infoLabel.text = "Move the device to detect horizontal surfaces."
//
//        case .notAvailable:
//            //infoLabel.text = "Tracking not available."
//
//        case .limited(.excessiveMotion):
//            //infoLabel.text = "Tracking limited - Move the device more slowly."
//
//        case .limited(.insufficientFeatures):
//            //infoLabel.text = "Tracking limited - Point the device at an area with visible surface detail."
//
//        case .limited(.initializing):
//            //infoLabel.text = "Initializing AR session."
//
//        default:
//            //infoLabel.text = ""
//        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Called when any node has been added to the anchor
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            //self.infoLabel.text = "Surface Detected."
        }
        
        let shoesScene = SCNScene(named: "art.scnassets/Lincoln_rigged.scn")
        object = shoesScene?.rootNode.childNode(withName: "Armature", recursively: true)
        object.simdPosition = float3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        sceneView.scene.rootNode.addChildNode(object)
        node.addChildNode(object)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // This method will help when any node has been removed from sceneview
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Called when any node has been updated with data from anchor
    }
    
}
