//
//  StringUtils.m
//  Math
//
//  Created by Johan Stenberg on 2013-12-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+(NSString *) getSmallestString
{
    return NSLocalizedString(@"Smallest?", @"A question stating which is number is smallest.");
}

+(NSString *) getLargestString
{
    return NSLocalizedString(@"Largest?", @"A question stating which is number is largest.");
}

+(NSArray *) getWorldNames
{
    NSString *levelOne = NSLocalizedString(@"Level one", @"Name for first level in each world.");
    NSString *levelTwo = NSLocalizedString(@"Level two", @"Name for second level in each world.");
    NSString *levelThree = NSLocalizedString(@"Level three", @"Name for third level in each world.");
    NSString *levelFour = NSLocalizedString(@"Level four", @"Name for fourth level in each world.");
    NSString *levelFive = NSLocalizedString(@"Level five", @"Name for fifth level in each world.");
    NSString *levelSix = NSLocalizedString(@"Level six", @"Name for sixth level in each world.");
    NSString *levelSeven = NSLocalizedString(@"Level seven", @"Name for seventh level in each world.");
    NSString *levelEight = NSLocalizedString(@"Level eight", @"Name for eighth level in each world.");
    NSString *levelNine = NSLocalizedString(@"Level nine", @"Name for ninth level in each world.");
    NSString *levelTen = NSLocalizedString(@"Level ten", @"Name for tenth level in each world.");
    
    NSArray *challengeNames = @[levelOne, levelTwo, levelThree, levelFour, levelFive, levelSix, levelSeven, levelEight, levelNine, levelTen];
    return challengeNames;
}

+(NSArray *) getChallengeNames
{
    NSString *addition = NSLocalizedString(@"Addition", @"Addition world name.");
    NSString *subtraction = NSLocalizedString(@"Subtraction", @"Subtraction world name.");
    NSString *multiplication = NSLocalizedString(@"Multiplication", @"Multiplication world name.");
    NSString *division = NSLocalizedString(@"Division", @"Division world name.");
    NSString *mixed = NSLocalizedString(@"Mixed", @"Mixed world name");
    
    NSArray *worldNames = @[addition, subtraction, multiplication, division, mixed];
    return worldNames;
}

+(NSString *) getWorldsString
{
    return NSLocalizedString(@"Worlds", @"Universe worlds title.");
}

+(NSString *) getLockedWorldStringTitle
{
    return NSLocalizedString(@"Locked World!", @"Locked world title.");
}

+(NSString *) getLockedWorldStringMessage
{
    return NSLocalizedString(@"To play this world complete the previous ones!", @"Locked world message.");
}

+(NSString *) getOKString
{
    return NSLocalizedString(@"OK", @"OK string for dialogs etcetera.");
}

+(NSString *) getHighScoreLabel: (NSString *) name andScore: (NSNumber *) score
{
    return [NSString stringWithFormat:NSLocalizedString(@"Highscore for \n%@ is %@", @"Highscore string with 2 arguments."), name, score];
}

+(NSString *) getLockedChallengeStringTitle
{
    return NSLocalizedString(@"Locked Level!", @"Locked level title.");
}

+(NSString *) getLockedChallengeStringMessage
{
    return NSLocalizedString(@"To play this level complete the previous ones!", @"Locked level message.");
}

+(NSString *) getWelcomeToLevel: (NSString *) levelName
{
    return [NSString stringWithFormat:NSLocalizedString(@"Welcome to \n%@", @"Level welcome title."), levelName];
}

+(NSString *) getCurrentChallengeHighScore: (NSNumber *) score
{
    return [NSString stringWithFormat:NSLocalizedString(@"Highscore for this\n level is %@", @"Highscore for current level."), score];
}

+(NSString *) getPlayString
{
    return NSLocalizedString(@"Play", @"Play button string.");
}

+(NSString *) getCompletedString: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"%@ Completed!", @"World or level completed."), name];
}

+(NSString *) getCompletedChallengeOrWorldNewHighscoreString: (NSString *) name andScore: (NSNumber *) score
{
    return [NSString stringWithFormat:NSLocalizedString(@"Congratulations! New highscore \n for %@ is %@!", @"World or level completed with new highscore."), name, score];
}

+(NSString *) getNextString
{
    return NSLocalizedString(@"Next", @"Next button label.");
}

+(NSString *) getReplayString
{
    return NSLocalizedString(@"Replay", @"Replay button label.");
}

+(NSString *) getMenuString
{
    return NSLocalizedString(@"Menu", @"Menu button label.");
}

+(NSString *) getCompletedGameString: (NSString *) profileName
{
    return [NSString stringWithFormat:NSLocalizedString(@"Congratulations %@!\nYou completed the game!", @"Completed game title with argument."), profileName];
}

+(NSString *) getCreateNewProfileTitle
{
    return NSLocalizedString(@"Create new profile", @"Create new profile scene title.");
}

+(NSString *) getCreatenewProfileInputPlaceHolder
{
    return NSLocalizedString(@"Enter name here!", @"Placeholder for the ui input in create profile scene.");
}

+(NSString *) getDoneString
{
    return NSLocalizedString(@"Done", @"Done button label.");
}

+(NSString *) getTakenNameTitle
{
    return NSLocalizedString(@"Taken name", @"Taken name dialog title.");
}

+(NSString *) getTakenNameMessage
{
    return NSLocalizedString(@"There already exists a profile with that name!", @"Taken name dialog message.");
}

+(NSString *) getNothingEnteredNewProfileNameTitle
{
    return NSLocalizedString(@"Please enter a name", @"Nothing entered new profile name dialog title.");
}

+(NSString *) getNothingEnteredNewProfileNameMessage
{
    return NSLocalizedString(@"To complete your profile you must enter a name!", @"Nothing entered new profile name dialog message.");
}

+(NSString *) getMainMenuTitle
{
    return NSLocalizedString(@"Blackboard Math", @"Main Menu title.");
}

+(NSString *) getOptionsString
{
    return NSLocalizedString(@"Options", @"Options button and title.");
}

+(NSString *) getProfileString
{
    return NSLocalizedString(@"Profile", @"Profile button and title.");
}

+(NSString *) getCurrentProfileString: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"Current profile: %@", @"Current profile label."), name];
}

+(NSString *) getProfileForString: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"Profile for: \n%@", @"Profile scene profile for string."), name];
}

+(NSString *) getCurrentWorldString: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"Current world: \n%@", @"Profile scene profile for string."), name];
}

+(NSString *) getCurrentChallengeString: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"Current level: \n%@", @"Profile scene profile for string."), name];
}

+(NSString *) getManageProfilesString
{
    return NSLocalizedString(@"Manage Profiles", @"Manage profile button label.");
}

+(NSString *) getResetProgressString
{
    return NSLocalizedString(@"Reset Progress", @"Reset progress button label.");
}

+(NSString *) getNewProfileString
{
    return NSLocalizedString(@"New Profile", @"New profile button label.");
}

+(NSString *) getTooManyProfilesTitle
{
    return NSLocalizedString(@"Max 5 Profiles", @"Too many profiles dialog title.");
}

+(NSString *) getTooManyProfilesMessage
{
    return NSLocalizedString(@"To delete a profile press \"Manage Profiles\"!", @"Too many profiles dialog title.");    
}

+(NSString *) getYesString
{
    return NSLocalizedString(@"Yes", @"Yes");
}

+(NSString *) getNoString
{
    return NSLocalizedString(@"No", @"No");
}

+(NSString *) getRestProgressMessage: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"Are you sure you want to reset the progress for %@?", @"Reset progress dialog message."), name];
}

+(NSString *) getNumberOfProfilesString: (int) profiles
{
    if (profiles == 1)
    {
        return [NSString stringWithFormat:NSLocalizedString(@"You have %d profile", @"Number of profiles string."), profiles];
    }
    else
    {
        return [NSString stringWithFormat:NSLocalizedString(@"You have %d profiles", @"Number of profiles string."), profiles];
    }
}

+(NSString *) getNameWithColonString
{
    return NSLocalizedString(@"Name:", @"Name with a colon after.");
}

+(NSString *) getCurrentWithColonString
{
    return NSLocalizedString(@"Current:", @"Current with a colon after.");
}

+(NSString *) getCantDeleteProfileStringTitle: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"Can't delete %@", @"Can't delete profile dialog title."), name];
}

+(NSString *) getCantDeleteProfileStringMessage: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"%@ is your current profile!" , @"Can't delete profile dialog message."), name];
}

+(NSString *) getDeleteProfileTitle
{
    return NSLocalizedString(@"Are you sure?", @"Delete profile dialog title.");
}

+(NSString *) getDeleteProfileMessage: (NSString *) name
{
   return [NSString stringWithFormat:NSLocalizedString(@"Are you sure you want to delete the profile %@?" , @"Delete profile dialog message."), name];
}

+(NSString *) getPausedString
{
    return NSLocalizedString(@"Paused", @"Paused title.");
}

+(NSString *) getResumeString
{
    return NSLocalizedString(@"Resume", @"Resumed title.");
}

+(NSString *) getScoreLabel: (NSNumber *) score
{
    return [NSString stringWithFormat:NSLocalizedString(@"Score: %@", @"Score label."), score];
}

+(NSString *) getHasCompletedGameString: (NSString *) name
{
    return [NSString stringWithFormat:NSLocalizedString(@"%@ has\ncompleted the game!", @"Has completed the game string in profile."), name];
}

@end