//
//  VirabhadrasanaD.swift
//  HKUITLTD_PoseEstim_Framework
//
//  Created by hkuit155 on 1/1/2021.
//  Copyright © 2021 Hong Kong Univisual Intelligent Technology Limited. All rights reserved.
//

import Foundation
import os
class VirabhadrasanaD {

    private let utilities: FeedbackUtilities = FeedbackUtilities()

    /** output */
    private var comment: Array<String>? = nil
    private var score: Double? = nil
    private var detailedscore: Array<Double>? = nil

    /** input */
    private var result: Result? = nil
    private var resultArray: Array<Array<Double>>? = nil

    /** constant */
    private var leg_ratio: Double = 0.9
    private var shoulder_ratio: Double = 0.1

    /** score of body parts */
    private var shoulder_score: Double = 0.0
    private var arm_score: Double = 0.0
    private var leg_score: Double = 0.0
    private var waist_score: Double = 0.0
    private var left_shoulder_score: Double = 0.0
    private var right_shoulder_score: Double = 0.0
    private var left_waist_score: Double = 0.0
    private var right_waist_score: Double = 0.0
    private var left_leg_score: Double = 0.0
    private var right_leg_score: Double = 0.0
    /** constructor */
    
    init(result: Result) {
        self.result = result
        self.resultArray = result.classToArray()
        calculateScore()
        makeComment()
    }

    /** getter */
    func getScore()-> Double{ return score! }
    func getComment()-> Array<String>{return comment!}
    func getResult()-> Result{ return result!}
    func getDetailedScore()-> Array<Double>{return detailedscore!}
    
    /** private method */
    private func makeComment(){
        comment = Array<String>()
        comment!.append("$waist_score, The Posture of the Waist " + utilities.comment(waist_score))
        comment!.append("$shoulder_score, The Posture of the Arms " + utilities.comment(shoulder_score))

    }

    private func calculateScore(){
        
        if ( utilities.left_leg_angle(resultArray!) > utilities.right_leg_angle(resultArray!) )
        {
            left_leg_score = utilities.left_leg(resultArray!, 180.0, 20.0, true)
            right_leg_score = utilities.right_leg(resultArray!, 90.0, 20.0, true)
            
        }
        else
        {
            left_leg_score = utilities.left_leg(resultArray!, 90.0, 20.0, true)
            right_leg_score = utilities.right_leg(resultArray!, 180.0, 20.0, true)
        }
        
        leg_score = 0.5*(right_leg_score + left_leg_score)
        
        left_shoulder_score = utilities.left_shoulder(resultArray!, 180.0, 20.0, true)
        right_shoulder_score = utilities.right_shoulder(resultArray!, 180.0, 20.0, true)
        shoulder_score = 0.5*(left_shoulder_score + right_shoulder_score)
        
        score = leg_ratio*leg_score + shoulder_ratio*shoulder_score
        detailedscore = [leg_score, shoulder_score]
        
    }

}
