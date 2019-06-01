//
//  DrawerUtils.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/31/19.
//  Copyright © 2019 CA. All rights reserved.
//

import UIKit

extension CGFloat {
  // Spring animation
  static let springDampingRatio: CGFloat = 0.7
  static let springInitialVelocityY: CGFloat =  10
}

extension Double {
  // Spring animation
  static let animationDuration: Double = 0.8
}

enum DragDirection {
  case up
  case down
}

enum DraggablePosition {
  case collapsed
  case half
  case open
  
  var heightMultiplier: CGFloat {
    switch self {
    case .collapsed: return 0.2
    case .half: return 0.48
    case .open: return 1
    }
  }
  
  var downBoundary: CGFloat {
    switch self {
    case .collapsed: return 0.0
    case .half: return 0.35
    case .open: return 0.8
    }
  }
  
  var upBoundary: CGFloat {
    switch self {
    case .collapsed: return 0.0
    case .half: return 0.27
    case .open: return 0.65
    }
  }
  
  var dimAlpha: CGFloat {
    switch self {
    case .collapsed, .half: return 0.0
    case .open: return 0.45
    }
  }
  
  func nextPosition(for direction: DragDirection) -> DraggablePosition {
    switch (self, direction) {
    case (.collapsed, .up): return .half
    case (.collapsed, .down): return .collapsed
    case (.half, .up): return .open
    case (.half, .down): return .collapsed
    case (.open, .up): return .open
    case (.open, .down): return .half
    }
  }
  
  func originY(for maxHeight: CGFloat) -> CGFloat {
    return maxHeight - (maxHeight * heightMultiplier)
  }
}
