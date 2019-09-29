//
//  Stack.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct HStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .x, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
}

public struct VStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .y, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
}

public struct ZStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: .z, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
}

public struct WStack: UI3ModifierArray {
    public var objects: [UI3Object]
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    public init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    public func node(frame: UI3Frame) -> SCNNode {
        Stack(axis: nil, { objects }).node(frame: frame)
    }
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
}

struct Stack: UI3ModifierArray {
    
    var axis: UI3Axis? = nil
    var objects: [UI3Object]
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .none
    public var paddingLength: CGFloat = 0.0
    
    // MARK: - Life Cycle
    
    public init(@UI3Builder _ object: () -> (UI3Object)) {
        self.objects = [object()]
    }
    
    init(@UI3Builder _ objects: () -> ([UI3Object])) {
        self.objects = objects()
    }
    
    init(axis: UI3Axis?, @UI3Builder _ objects: () -> ([UI3Object])) {
        self.axis = axis
        self.objects = objects()
    }
    
    // MARK: - Node
    
    func node(frame: UI3Frame) -> SCNNode {
        
        var allObjects: [UI3Object] = []
        for object in objects {
            if let forEach = object as? ForEach {
                for object in forEach.objects {
                    allObjects.append(object)
                }
            } else {
                allObjects.append(object)
            }
        }
        
        let node = SCNNode()
        
        var segments: [CGFloat?] = []
        if let axis = self.axis {
            for object in allObjects {
                let size: CGFloat? = {
                    switch axis {
                    case .x: return object.width
                    case .y: return object.height
                    case .z: return object.length
                    }
                }()
                segments.append(size)
            }
        }
        let totalSegments: CGFloat = segments.compactMap({$0}).reduce(0, { $0 + $1 })
        
        let leftoverTotalFraction: CGFloat = max(1.0 - totalSegments, 0.0)
        let leftoverCount: Int = segments.filter({ $0 == nil }).count
        let lefoverFraction: CGFloat = leftoverCount > 0 ? leftoverTotalFraction / CGFloat(leftoverCount) : 0.0
        
        var position: CGFloat = 0.0
        for object in allObjects {
            
            var subFrame: UI3Frame = .one
            
            if let axis = self.axis {
                
                let size: CGFloat = {
                    switch axis {
                    case .x: return object.width
                    case .y: return object.height
                    case .z: return object.length
                    }
                }() ?? lefoverFraction
                
                subFrame = UI3Frame(origin: UI3Position(x: axis == .x ? position : 0.0,
                                                        y: axis == .y ? position : 0.0,
                                                        z: axis == .z ? position : 0.0),
                                    size: UI3Scale(x: axis == .x ? size : 1.0,
                                                   y: axis == .y ? size : 1.0,
                                                   z: axis == .z ? size : 1.0))
                position += size
                
            }
            
            let comboFrame = frame +* subFrame
            let finalFrame = comboFrame.withPadding(edges: object.paddingEdges, length: object.paddingLength)
            
            let subNode = object.node(frame: finalFrame)
            node.addChildNode(subNode)
            
            if UI3Defaults.debug {
                let box = SCNBox(width: frame.size.x, height: frame.size.y, length: frame.size.z, chamferRadius: 0.0)
                if #available(iOS 11.0, *) {
                    box.firstMaterial!.fillMode = .lines
                }
                box.firstMaterial!.diffuse.contents = UIColor(hue: .random(in: 0.0...1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                let boxNode = SCNNode(geometry: box)
                boxNode.position = frame.position.scnVector3
                node.addChildNode(boxNode)
            }
            
        }
        
        return node
        
    }
    
    // MARK: - Object
    
    public func frame(width: CGFloat?, height: CGFloat?, length: CGFloat?) -> UI3Object {
        var object = self
        if width != nil { object.width = width }
        if height != nil { object.height = height }
        if length != nil { object.length = length }
        return object
    }
    
    public func padding(edges: UI3Edges, length: CGFloat) -> UI3Object {
        var object = self
        object.paddingEdges = edges
        object.paddingLength = length
        return object
    }
    
}
