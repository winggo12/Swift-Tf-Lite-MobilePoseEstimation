//
//  UtthitaParsvakonasana.swift
//  HKUITLTD_PoseEstim_Framework
//
//  Created by iosuser111 on 20/8/2020.
//  Copyright © 2020 Hong Kong Univisual Intelligent Technology Limited. All rights reserved.
//

import Foundation


class UtthitaParsvakonasana {
    
    private let utilities: FeedbackUtilities = FeedbackUtilities()

    private let TAG = "GivePoseFeedback"

    /** output */
    private var comment: Array<String>? = nil
    private var score: Double? = nil

    /** input */
    private var result: Result? = nil
    private var resultArray: Array<Array<Double>>? = nil

    /** constant */
    private let leg_ratio = 0.5
    private let arm_ratio = 0.1
    private let waist_ratio = 0.4

    /** score of body parts */
    private var waist_score: Double = 0.0
    private var leg_score: Double = 0.0
    private var arm_score: Double = 0.0
    private var right_angle_leg_score: Double = 0.0
    private var shoulder_score: Double = 0.0
    private var right_angle_leg: Int = -1

    /** constructor */
    init(result: Result){
        self.result = result
        resultArray = result.classToArray()
        calculateScore()
        makeComment()
    }

    /** getter */
    func getScore()-> Double { return self.score! }
    func getComment()-> Array<String> { return self.comment! }
    func getResult()-> Result { return self.result! }

    /** private method */
    private func calculateScore()->Double{

        right_angle_leg = self.find_right_angle_leg()
        if(right_angle_leg == -1){
            print(TAG + ":" + "Cannot detriment the posture direction.")
            score = 0.0
            return score!
        }else if(right_angle_leg == 6){
            right_angle_leg_score = utilities.left_leg(resultArray!, 90.0, 20.0, false)
            leg_score = utilities.right_leg(resultArray!, 180.0, 20.0, false)
            arm_score = utilities.right_arm(resultArray!, 180.0, 20.0, false)
            shoulder_score = utilities.right_shoulder(resultArray!, 180.0, 20.0, false)
            waist_score =  utilities.right_waist(resultArray!, 180.0, 20.0, false)
            score = arm_ratio / 2 * (leg_score + shoulder_score) + waist_ratio * waist_score + leg_ratio / 2 * (right_angle_leg_score + leg_score)
        }else{
            right_angle_leg_score = utilities.right_leg(resultArray!, 90.0, 20.0, false)
            leg_score = utilities.left_leg(resultArray!, 180.0, 20.0, false)
            arm_score = utilities.left_arm(resultArray!, 180.0, 20.0, false)
            shoulder_score = utilities.left_shoulder(resultArray!, 180.0, 20.0, false)
            waist_score =  utilities.left_waist(resultArray!, 180.0, 20.0, false)

        }
        score = arm_ratio / 2 * (leg_score + shoulder_score) + waist_ratio * waist_score + leg_ratio / 2 * (right_angle_leg_score + leg_score)
        return score!
    }

    private func makeComment()->Array<String>{
        comment = Array<String>()

        if(right_angle_leg == -1){
            comment!.append("")
        }else{
            var str: String
            var str1: String
            if(right_angle_leg == 6){
                str = "right"
                str1 = "left"
            }else{
                str = "left"
                str1 = "right"
            }

            comment!.append("The Straightness of the Arms " + utilities.comment(arm_score))
            comment!.append("The Straightness from shoulder to knee " + utilities.comment(waist_score))
            comment!.append("The Straightness of the " + str + " leg " + utilities.comment(leg_score))
            comment!.append("The Curvature of the " + str1 + " leg " + utilities.comment(right_angle_leg_score))
        }

        return comment!
    }

    private func find_right_angle_leg()-> Int{
        let left_hip = resultArray![7]
        let right_wrist = resultArray![6]

        let right_hip = resultArray![8]
        let left_wrist = resultArray![5]

        if(right_wrist[0] < left_hip[0]){
            return 6
        }
        if(left_wrist[0] > right_hip[0]){
            return 5
        }else{
            return -1
        }
    }

}
