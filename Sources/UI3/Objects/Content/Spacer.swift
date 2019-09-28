//
//  Spacer.swift
//  UI3
//
//  Created by Hexagons on 2019-09-27.
//

import SceneKit

public struct Spacer: UI3Content {
    
    public var width: CGFloat? = nil
    public var height: CGFloat? = nil
    public var length: CGFloat? = nil
    public var paddingEdges: UI3Edges = .all
    public var paddingLength: CGFloat? = nil
    
    // MARK: - Life Cycle
    
    public init() {}
    
    // MARK: - Node
    
    public func node(frame: UI3Frame) -> SCNNode {
        
        return SCNNode()
        
    }
    
    // MARK: - Object
    
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil, length: CGFloat? = nil) -> UI3Object {
        return self
    }
    
    public func padding(edges: UI3Edges = .all, length: CGFloat = UI3Defaults.paddingLength) -> UI3Object {
        return self
    }
    
    // MARK: - Content
    
    public func color(_ value: UIColor) -> UI3Content {
        return self
    }
    
    public func shading(_ value: UI3Shading) -> UI3Content {
        return self
    }
    
    public func isDoubleSided(_ value: Bool) -> UI3Content {
        return self
    }
    
}