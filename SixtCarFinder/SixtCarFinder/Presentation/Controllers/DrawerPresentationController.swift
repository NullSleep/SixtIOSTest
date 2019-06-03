//
//  DrawerPresentationController.swift
//  SixtCarFinder
//
//  Created by Carlos Arenas on 5/30/19.
//  Copyright © 2019 CA. All rights reserved.
//

import Foundation
import UIKit

final class DrawerPresentationController: UIPresentationController {
  
  // MARK: Private
  private var dimmingView = UIView()
  private var draggablePosition: DraggablePosition = .collapsed
  
  private let springTiming = UISpringTimingParameters(dampingRatio: .springDampingRatio, initialVelocity: CGVector(dx: 0, dy: .springInitialVelocityY))
  private var animator: UIViewPropertyAnimator?
  
  private var dragDirection: DragDirection = .up
  private let maxFrame = CGRect(x: 0, y: 0, width: UIWindow.root.bounds.width, height: UIWindow.root.bounds.height + UIWindow.key.safeAreaInsets.bottom)
  private var panOnPresented = UIGestureRecognizer()
  
  private lazy var touchForwardingView: TouchForwardingView? = {
    guard let containerView = containerView else { return nil }
    return TouchForwardingView(frame: containerView.bounds)
  }()
  
  override var frameOfPresentedViewInContainerView: CGRect {
    let presentedOrigin = CGPoint(x: 0, y: draggablePosition.originY(for: maxFrame.height))
    let presentedSize = CGSize(width: maxFrame.width, height: maxFrame.height + 40)
    let presentedFrame = CGRect(origin: presentedOrigin, size: presentedSize)
    return presentedFrame
  }
  
  // MARK: - UIPresentationController
  override func presentationTransitionWillBegin() {
    guard let containerView = containerView else { return }
    
    touchForwardingView!.passthroughViews = [presentingViewController.view]
    containerView.insertSubview(touchForwardingView!, at: 0)
    
    containerView.insertSubview(dimmingView, at: 1)
    dimmingView.alpha = 0
    dimmingView.backgroundColor = .black
    dimmingView.frame = containerView.frame
  }
  
  override func presentationTransitionDidEnd(_ completed: Bool) {
    animator = UIViewPropertyAnimator(duration: .animationDuration, timingParameters: self.springTiming)
    animator?.isInterruptible = true
    panOnPresented = UIPanGestureRecognizer(target: self, action: #selector(userDidPan(panRecognizer:)))
    presentedView?.addGestureRecognizer(panOnPresented)
    
    if let carListVC = presentedViewController as? CarListViewController {
      carListVC.headerView.addGestureRecognizer(panOnPresented)
    }
  }
  
  override func containerViewWillLayoutSubviews() {
    presentedView?.frame = frameOfPresentedViewInContainerView
  }
  
  // MARK: - Private functions
  @objc private func userDidPan(panRecognizer: UIPanGestureRecognizer) {
    let translationPoint = panRecognizer.translation(in: presentedView)
    let currentOriginY = draggablePosition.originY(for: maxFrame.height)
    let newOffset = currentOriginY + translationPoint.y
    
    dragDirection = newOffset > currentOriginY ? .down : .up
    
    let nextOriginY = draggablePosition.nextPosition(for: dragDirection).originY(for: maxFrame.height)
    let area = dragDirection == .up ? frameOfPresentedViewInContainerView.origin.y - maxFrame.origin.y : -(frameOfPresentedViewInContainerView.origin.y - nextOriginY)
    
    let canDragInProposedDirection = dragDirection == .up && draggablePosition == .open ? false : true
    
    if newOffset >= 0 && canDragInProposedDirection {
      switch panRecognizer.state {
      case .changed, .began:
        presentedView?.frame.origin.y = newOffset
        if newOffset != area && draggablePosition == .open || draggablePosition.nextPosition(for: dragDirection) == .open {
          let onePercent = area / 100
          let percentage = (area-newOffset) / onePercent / 100
          dimmingView.alpha = percentage * DraggablePosition.open.dimAlpha
        }
        
      case .ended:
        animate(newOffset)
      default:
        break
      }
    } else {
      if panRecognizer.state == .ended {
        animate(newOffset) // The user has scrolled to the top, so animate when their interaction ends
      }
    }
  }
  
  private func animate(_ dragOffset: CGFloat) {
    let distanceFromBottom = maxFrame.height - dragOffset
    
    switch dragDirection {
    case .up:
      if (distanceFromBottom > maxFrame.height * DraggablePosition.open.upBoundary) {
        animate(to: .open)
      } else if (distanceFromBottom > maxFrame.height * DraggablePosition.half.upBoundary) {
        animate(to: .half)
      } else {
        animate(to: .collapsed)
      }
    case .down:
      if (distanceFromBottom > maxFrame.height * DraggablePosition.open.downBoundary) {
        animate(to: .open)
      } else if (distanceFromBottom > maxFrame.height * DraggablePosition.half.downBoundary) {
        animate(to: .half)
      } else {
        animate(to: .collapsed)
      }
    }
  }
  
  private func animate(to position: DraggablePosition) {
    guard let animator = animator else { return }
    
    animator.addAnimations {
      self.presentedView?.frame.origin.y = position.originY(for: self.maxFrame.height)
      self.dimmingView.alpha = position.dimAlpha
    }
    
    animator.addCompletion { (animatingPosition) in
      if animatingPosition == .end {
        self.draggablePosition = position
      }
    }
    
    animator.startAnimation()
  }
}

// MARK: Public
extension DrawerPresentationController {
  func animateToOpen() {
    animate(to: .open)
  }
}

