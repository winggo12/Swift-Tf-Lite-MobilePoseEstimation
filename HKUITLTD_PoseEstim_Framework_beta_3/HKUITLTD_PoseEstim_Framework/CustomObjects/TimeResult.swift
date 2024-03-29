//
//  TimeResult.swift
//  HKUITLTD_PoseEstim_Framework
//
//  Created by hkuit155 on 24/6/2020.
//  Copyright © 2020 Hong Kong Univisual Intelligent Technology Limited. All rights reserved.
//

import Foundation
import UIKit
public struct Times {
  public var preprocessing: Double
  public var inference: Double
  public var postprocessing: Double
}

public struct Result {
  public var dots: [CGPoint]
  public var lines: [Line]
  public var score: Float
}
private let DummyDotsArray = [CGPoint](repeating:CGPoint(x:0,y:0),count:13) //CGPoint(x:0,y:0)
private let DummyLine = Line(from: CGPoint(x:0,y:0),to: CGPoint(x:0,y:0))
private let DummyLinesArray = [Line](repeating: DummyLine, count: 12)
private let DummyScore = Float(0.01)

public let DummyResult = Result(dots: DummyDotsArray, lines: DummyLinesArray, score: DummyScore)
public let DummyTime = Times(preprocessing: Double(0), inference: Double(0), postprocessing: Double(0))
