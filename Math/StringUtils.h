//
//  StringUtils.h
//  Math
//
//  Created by Johan Stenberg on 2013-12-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+(NSString *) getSmallestString;

+(NSString *) getLargestString;

+(NSArray *) getWorldNames;

+(NSArray *) getChallengeNames;

+(NSString *) getWorldsString;

+(NSString *) getLockedWorldStringTitle;

+(NSString *) getLockedWorldStringMessage;

+(NSString *) getOKString;

+(NSString *) getHighScoreLabel: (NSString *) name andScore: (NSNumber *) score;

+(NSString *) getLockedChallengeStringTitle;

+(NSString *) getLockedChallengeStringMessage;

+(NSString *) getWelcomeToLevel: (NSString *) levelName;

+(NSString *) getCurrentChallengeHighScore: (NSNumber *) score;

+(NSString *) getPlayString;

+(NSString *) getCompletedString: (NSString *) name;

+(NSString *) getCompletedChallengeOrWorldNewHighscoreString: (NSString *) name andScore: (NSNumber *) score;

+(NSString *) getNextString;

+(NSString *) getReplayString;

+(NSString *) getMenuString;

+(NSString *) getCompletedGameString: (NSString *) profileName;

+(NSString *) getCreateNewProfileTitle;

+(NSString *) getCreatenewProfileInputPlaceHolder;

+(NSString *) getDoneString;

+(NSString *) getTakenNameTitle;

+(NSString *) getTakenNameMessage;

+(NSString *) getNothingEnteredNewProfileNameTitle;

+(NSString *) getNothingEnteredNewProfileNameMessage;

+(NSString *) getMainMenuTitle;

+(NSString *) getOptionsString;

+(NSString *) getProfileString;

+(NSString *) getCurrentProfileString: (NSString *) name;

+(NSString *) getProfileForString: (NSString *) name;

+(NSString *) getCurrentWorldString: (NSString *) name;

+(NSString *) getCurrentChallengeString: (NSString *) name;

+(NSString *) getManageProfilesString;

+(NSString *) getResetProgressString;

+(NSString *) getNewProfileString;

+(NSString *) getTooManyProfilesTitle;

+(NSString *) getTooManyProfilesMessage;

+(NSString *) getYesString;

+(NSString *) getNoString;

+(NSString *) getRestProgressMessage: (NSString *) name;

+(NSString *) getNumberOfProfilesString: (int) profiles;

+(NSString *) getNameWithColonString;

+(NSString *) getCurrentWithColonString;

+(NSString *) getCantDeleteProfileStringTitle: (NSString *) name;

+(NSString *) getCantDeleteProfileStringMessage: (NSString *) name;

+(NSString *) getDeleteProfileTitle;

+(NSString *) getDeleteProfileMessage: (NSString *) name;

+(NSString *) getPausedString;

+(NSString *) getResumeString;

+(NSString *) getScoreLabel: (NSNumber *) score;

@end
