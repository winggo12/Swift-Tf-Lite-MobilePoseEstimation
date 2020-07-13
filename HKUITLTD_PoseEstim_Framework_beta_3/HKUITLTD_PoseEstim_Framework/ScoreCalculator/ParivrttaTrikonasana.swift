//
//  ParivrttaTrikonasana.swift
//  PoseEstim
//
//  Created by iosuser111 on 9/6/2020.
//  Copyright © 2020 tensorflow. All rights reserved.
//

import Foundation

func paritrik_straight_waist(kps:Array<Array<Double>>) -> Double {

    let left_shoulder = kps[2]
    let left_hip = kps[8]
    let left_knee = kps[10]
    let angle = get_angle(center_coord: left_hip, coord1: left_shoulder, coord2: left_knee)
    
    if angle > 170{                    return 100  }

    if angle >= 160 && angle < 180 {    return 90   }

    if angle >= 140 && angle < 160 {    return 80   }

    if angle >= 120 && angle < 140 {    return 70   }
    else{                               return 60   }
}

func paritrik_straight_left_leg(kps:Array<Array<Double>>) -> Double {

    let left_knee = kps[9]
    let left_hip = kps[7]
    let left_ankle = kps[11]
    let angle = get_angle(center_coord: left_knee, coord1: left_ankle, coord2: left_hip)
    
    if angle > 170{                    return 100  }

    if angle >= 160 && angle < 180 {    return 90   }

    if angle >= 140 && angle < 160 {    return 80   }

    if angle >= 120 && angle < 140 {    return 70   }
    else{                               return 60   }
}

func paritrik_straight_right_leg(kps:Array<Array<Double>>) -> Double {

    let right_knee = kps[10]
    let right_hip = kps[8]
    let right_ankle = kps[12]
    let angle = get_angle(center_coord: right_knee, coord1: right_ankle, coord2: right_hip)
    
    if angle > 170{                    return 100  }

    if angle >= 160 && angle < 180 {    return 90   }

    if angle >= 140 && angle < 160 {    return 80   }

    if angle >= 120 && angle < 140 {    return 70   }
    else{                               return 60   }
}

func paritrik_straight_right_arm(kps:Array<Array<Double>>) -> Double {

    let r_elbow = kps[4]
    let r_shoulder = kps[2]
    let r_wrist = kps[6]
    let angle = get_angle(center_coord: r_elbow, coord1: r_shoulder, coord2: r_wrist)
    
    if angle > 170{                    return 100  }

    if angle >= 160 && angle < 180 {    return 90   }

    if angle >= 140 && angle < 160 {    return 80   }

    if angle >= 120 && angle < 140 {    return 70   }
    else{                               return 60   }
}
func paritrik_straight_left_arm(kps:Array<Array<Double>>) -> Double {

    let l_elbow = kps[3]
    let l_shoulder = kps[1]
    let l_wrist = kps[5]
    let angle = get_angle(center_coord: l_elbow, coord1: l_shoulder, coord2: l_wrist)
    
    if angle > 170{                    return 100  }

    if angle >= 160 && angle < 180 {    return 90   }

    if angle >= 140 && angle < 160 {    return 80   }

    if angle >= 120 && angle < 140 {    return 70   }
    else{                               return 60   }
}

func get_parivrtta_trikonasana_score(kps:Array<Array<Double>>) -> Double{
    
    let leg_ratio = 0.4
    let waist_ratio = 0.4
    let arm_ratio = 0.2
    
    let left_leg_score = paritrik_straight_left_leg(kps:kps)
    let right_leg_score = paritrik_straight_right_leg(kps: kps)
    
    let left_arm_score = paritrik_straight_left_arm(kps:kps)
    let right_arm_score = paritrik_straight_right_arm(kps: kps)
    
    let leg_score = leg_ratio * Double(left_leg_score > right_leg_score ? left_leg_score : right_leg_score)
    let arm_score = arm_ratio * Double(left_arm_score > right_arm_score ? left_arm_score : right_arm_score)
    let dis_score = waist_ratio * Double(paritrik_straight_waist(kps:kps))

    return arm_score + leg_score + dis_score
}
