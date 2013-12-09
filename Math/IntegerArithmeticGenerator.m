//
//  IntegerArithmeticGenerator.m
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-12-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "IntegerArithmeticGenerator.h"

#import "Question.h"

#import "Answer.h"

#import "RandomUtils.h"

#import "StringUtils.h"

@implementation IntegerArithmeticGenerator

+(NSArray *) generateQuestionsOne: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticOneOrSix:size andMax:10 andDiff:10 andProblemType:problemType];
}

+(NSArray *) generateQuestionsTwo: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticTwoOrSeven:size andMax:10 andDiff:10 andProblemType:problemType];
}

+(NSArray *) generateQuestionsThree: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticThreeOrEight:size andMax:10 andDiff:10 andProblemType:problemType];
}

+(NSArray *) generateQuestionsFour: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticFourFiveNineOrTen:size isMin:YES andMax:10 andProblemType:problemType];
}

+(NSArray *) generateQuestionsFive: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticFourFiveNineOrTen:size isMin:NO andMax:10 andProblemType:problemType];
}

+(NSArray *) generateQuestionsSix: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticOneOrSix:size andMax:100 andDiff:20 andProblemType:problemType];
}

+(NSArray *) generateQuestionsSeven: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticTwoOrSeven:size andMax:100 andDiff:10 andProblemType:problemType];
}

+(NSArray *) generateQuestionsEight: (int) size andProblemType: (enum ProblemType) problemType
{
    int max = problemType == Division || problemType == Multiplication ? 20 : 50;
    return [self generateIntArithmeticThreeOrEight:size andMax:max andDiff:10 andProblemType:problemType];
}

+(NSArray *) generateQuestionsNine: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticFourFiveNineOrTen:size isMin:YES andMax:100 andProblemType:problemType];
}

+(NSArray *) generateQuestionsTen: (int) size andProblemType: (enum ProblemType) problemType
{
    return [self generateIntArithmeticFourFiveNineOrTen:size isMin:NO andMax:100 andProblemType:problemType];
}

+(NSArray *) generateIntArithmeticOneOrSix: (int) size
                                    andMax: (int) max
                                   andDiff: (int) diff
                            andProblemType: (enum ProblemType) problemType
{
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    int min = problemType == Multiplication || problemType == Division ? 1 : 0;
    NSArray *matrix =
    [RandomUtils randomizeUniqueHorizontalIntMatrixWithY:size
                                                    andX:2 andMin:min andMax:max];
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = [[Question alloc] init];
        int first = [matrix[i][0] intValue];
        int second = [matrix[i][1] intValue];
        
        int answer = 0;
        BOOL CanGoNegative = NO;
        switch (problemType)
        {
            case Addition:
                answer = first + second;
                question.question = [[NSString alloc] initWithFormat:@"%d + %d", first, second];
                break;
            case Subtraction:
            {
                int rnd = arc4random() % 2;
                answer = rnd == 1 ? -first - second : first - second;
                NSString *format1 = @"-%d - %d";
                NSString *format2 = @"%d - %d";

                question.question = [[NSString alloc] initWithFormat: rnd == 1 ? format1 : format2, first, second];
                CanGoNegative = YES;
            }
                break;
            case Multiplication:
                answer = first * second;
                question.question = [[NSString alloc] initWithFormat:@"%d * %d", first, second];
                break;
            case Division:
                answer = second;
                int tmp = first * second;
                
                question.question = [[NSString alloc] initWithFormat:@"%d / %d", tmp, first];
                break;
            default:
                [NSException raise:@"Invalid ProblemType!"
                            format:@"ProblemType %d is invalid", problemType];
                break;
        }
        
        NSNumber *answerNumber = [[NSNumber alloc] initWithInt:answer];
        NSArray *answerNumbers = [self createIntegerAnswerNumbers:answerNumber andSize:4 andDiff:diff
                                                        andCentre:answer andCanGoNegative:CanGoNegative];
        NSArray *answers = [self createNumericalAnswers:answerNumber andNumbers:answerNumbers];
        
        question.answers = answers;
        [questions addObject:question];
    }
    
    return [questions copy];
}

+(NSArray *) generateIntArithmeticTwoOrSeven: (int) size
                                      andMax: (int) max
                                     andDiff: (int) diff
                              andProblemType: (enum ProblemType) problemType
{
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    int min = problemType == Multiplication || problemType == Division ? 1 : 0;
    NSArray *matrix = [RandomUtils randomizeUniqueHorizontalIntMatrixWithGrowingConstraintY:size andX:2 andMin:min andMax:max];
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = [[Question alloc] init];
        int first = [matrix[i][0] intValue];
        int second = [matrix[i][1] intValue];
        
        int answer = 0;
        BOOL CanGoNegative = NO;
        switch (problemType)
        {
            case Addition:
            {
                answer = second - first;
                NSString *format1 = @"%d + ? = %d";
                NSString *format2 = @"? + %d = %d";
                int rnd = arc4random() % 2;
                question.question = [[NSString alloc] initWithFormat: rnd == 1 ? format1 : format2, first, second];
            }
                break;
            case Subtraction:
            {
                int rnd = arc4random() % 2;
                answer = rnd == 1 ? second - first : second + first;
                NSString *format1 = [[NSString alloc] initWithFormat:@"%d - ? = %d", second, first];
                NSString *format2 = [[NSString alloc] initWithFormat:@"? - %d = %d", first, second];
                
                question.question = rnd == 1 ? format1 : format2;
                CanGoNegative = YES;
            }
                break;
            case Multiplication:
            {
                answer = second;
                
                NSString *format1 = @"%d * ? = %d";
                NSString *format2 = @"? * %d = %d";
                
                int rnd = arc4random() % 2;
                question.question = [[NSString alloc] initWithFormat: rnd == 1 ? format1 : format2, first, first * second];
            }
                break;
            case Division:
            {
                int rnd = arc4random() % 2;
                answer = rnd == 1 ? second : second * first;
                
                NSString *format1 = [[NSString alloc] initWithFormat:@"%d / ? = %d", second * first, first];
                NSString *format2 = [[NSString alloc] initWithFormat:@"? / %d = %d", first, second];
                
                question.question = rnd == 1 ? format1 : format2;
            }
                break;
            default:
                [NSException raise:@"Invalid ProblemType!"
                            format:@"ProblemType %d is invalid", problemType];
                break;
        }
        
        NSNumber *answerNumber = [[NSNumber alloc] initWithInt:answer];
        NSArray *answerNumbers = [self createIntegerAnswerNumbers:answerNumber andSize:4 andDiff:diff andCentre:answer
                                                 andCanGoNegative:CanGoNegative];
        NSArray *answers = [self createNumericalAnswers:answerNumber andNumbers:answerNumbers];
        
        question.answers = answers;
        [questions addObject:question];
    }
    
    return [questions copy];
}

+(NSArray *) generateIntArithmeticThreeOrEight: (int) size
                                        andMax: (int) max
                                       andDiff: (int) diff
                                andProblemType: (enum ProblemType) problemType
{
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    int min = problemType == Multiplication ? 1 : 0;
    NSArray *matrix = [RandomUtils randomizeUniqueHorizontalIntMatrixWithY:size andX:3 andMin:min andMax:max];
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = [[Question alloc] init];
        int first = [matrix[i][0] intValue];
        int second = [matrix[i][1] intValue];
        int third = [matrix[i][2] intValue];

        int answer = 0;
        BOOL CanGoNegative = NO;
        switch (problemType)
        {
            case Addition:
                answer = first + second + third;
                question.question = [[NSString alloc] initWithFormat:@"%d + %d + %d", first, second, third];
                break;
            case Subtraction:
            {
                int rnd = arc4random() % 2;
                NSString *format1 = [[NSString alloc] initWithFormat:@"-%d - %d - %d", first, second, third];
                NSString *format2 = [[NSString alloc] initWithFormat:@"%d - %d - %d", first, second, third];
                
                question.question = rnd == 1 ? format1 : format2;
                NSExpression *expression = [NSExpression expressionWithFormat:question.question];
                answer = [[expression expressionValueWithObject:nil context:nil] intValue];
                CanGoNegative = YES;
            }
                break;
            case Multiplication:
                answer = first * second * third;
                question.question = [[NSString alloc] initWithFormat:@"%d * %d * %d", first, second, third];
                break;
            case Division:
            {
                int rnd = arc4random() % 2;
                if (first == 0 || second == 0 || third == 0)
                {
                    first = arc4random() % max + 1;
                    second = arc4random() % max + 1;
                    third = arc4random() % max + 1;
                }
                
                answer = rnd == 1 ? third : first;
                NSString *format1 = [[NSString alloc] initWithFormat:@"%d / (%d / %d)", first * third, first * second, second];
                NSString *format2 = [[NSString alloc] initWithFormat:@"(%d /  %d) / %d", first * second * third, second, third];
                
                question.question = rnd == 1 ? format1 : format2;
            }
                break;
            default:
                [NSException raise:@"Invalid ProblemType!"
                            format:@"ProblemType %d is invalid", problemType];
                break;
        }
        
        NSNumber *answerNumber = [[NSNumber alloc] initWithInt:answer];
        NSArray *answerNumbers = [self createIntegerAnswerNumbers:answerNumber andSize:4 andDiff:diff andCentre:answer
                                                 andCanGoNegative:CanGoNegative];
        NSArray *answers = [self createNumericalAnswers:answerNumber andNumbers:answerNumbers];
        
        question.answers = answers;
        [questions addObject:question];
    }
    
    return [questions copy];
}

+(NSArray *) generateIntArithmeticFourFiveNineOrTen: (int) size
                                              isMin: (BOOL) isMin
                                             andMax: (int) max
                                     andProblemType: (enum ProblemType) problemType
{
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = [[Question alloc] init];
        NSArray *matrix = [RandomUtils randomizeUniqueHorizontalIntMatrixWithY:4 andX:2 andMin:0 andMax:max];
        
        NSString *smallest = [StringUtils getSmallestString];
        NSString *largest = [StringUtils getLargestString];
        
        question.question = isMin ? smallest : largest;
        
        NSArray *answers = [self createMinMaxAnswers:matrix isMin:isMin andProblemType:problemType];
        
        question.answers = answers;
        [questions addObject:question];
    }
    
    return [questions copy];
}

+(NSArray *) createMinMaxAnswers: (NSArray *) matrix isMin: (BOOL) isMin andProblemType: (enum ProblemType) problemType
{
    int minOrMax = isMin ? INT_MAX : INT_MIN;
    
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    for (int i = 0; i < [matrix count]; ++i)
    {
        if ([matrix[i] count] != 2)
        {
            [NSException raise:@"Invalid Matrix horizontal size!"
                        format:@"Horizontal size %d is invalid! Needs to be 2!", [matrix[i] count]];
        }
        
        Answer *answer = [[Answer alloc] init];
        answer.isImage = [[NSNumber alloc] initWithInt:0];
        
        switch (problemType)
        {
            case Addition:
                answer.text = [[NSString alloc] initWithFormat:@"%d + %d", [matrix[i][0] intValue], [matrix[i][1] intValue]];
                break;
            case Subtraction:
                answer.text = [[NSString alloc] initWithFormat:@"%d - %d", [matrix[i][0] intValue], [matrix[i][1] intValue]];
                break;
            case Multiplication:
                answer.text = [[NSString alloc] initWithFormat:@"%d * %d", [matrix[i][0] intValue], [matrix[i][1] intValue]];
                break;
            case Division:
                answer.text = [[NSString alloc] initWithFormat:@"%d / %d", [matrix[i][0] intValue] * [matrix[i][1] intValue],
                               [matrix[i][1] intValue]];
                break;
            default:
                [NSException raise:@"Invalid ProblemType!"
                            format:@"ProblemType %d is invalid", problemType];
                break;
        }
        
        NSExpression *expression = [NSExpression expressionWithFormat:answer.text];
        int value = [[expression expressionValueWithObject:nil context:nil] intValue];
        
        if (isMin)
        {
            minOrMax = value < minOrMax ? value : minOrMax;
        }
        else
        {
            minOrMax = value > minOrMax ? value : minOrMax;
        }

        [answers addObject:answer];
    }
    
    for (int i = 0; i < [answers count]; ++i)
    {
        Answer *answer = answers[i];
        NSExpression *expression = [NSExpression expressionWithFormat:answer.text];
        int value = [[expression expressionValueWithObject:nil context:nil] intValue];
        
        answer.isCorrect = [[NSNumber alloc] initWithInt:value == minOrMax ? 1 : 0];
    }
    
    [RandomUtils shuffleArray:answers];
    return [answers copy];
}

+(NSArray *) createIntegerAnswerNumbers: (NSNumber *) answerNumber
                                andSize: (int) size
                                andDiff: (int) diff
                              andCentre: (int) centre
                       andCanGoNegative: (BOOL) CanGoNegative
{
    NSArray *answersDigits =
    [[NSArray alloc] initWithObjects:answerNumber, nil];
    answersDigits =
    [RandomUtils randomizeUniqueIntArrayWithSize:size
                                  andStartValues:answersDigits andDifference:diff andCentre:centre andCanGoNegative:CanGoNegative];
    
    return answersDigits;
}

+(NSArray *) createNumericalAnswers: (NSNumber *) answerNumber andNumbers: (NSArray *) answersNumbers
{
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [answersNumbers count]; ++i)
    {
        Answer *answer = [[Answer alloc] init];
        answer.isImage = [[NSNumber alloc] initWithInt:0];
        answer.text = [[NSString alloc] initWithFormat:@"%@", answersNumbers[i]];
        answer.isCorrect = [[NSNumber alloc] initWithInt: [answerNumber isEqualToNumber:answersNumbers[i]] ? 1 : 0];
        
        [answers addObject:answer];
    }
    
    [RandomUtils shuffleArray:answers];
    
    return answers;
}

+(NSArray *) generateMixedOneQuestions: (enum ProblemType) problemType andDifficulty: (int) difficulty andSize: (int) size
{
    NSArray *shuffledArray = [self getShuffledQuestionsArray:size];
    
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < shuffledArray.count; ++i)
    {
        NSNumber *number = shuffledArray[i];
        NSArray *partialQuestions = [super generateQuestions:i andDifficulty:difficulty andSize:number.intValue];
        [questions addObjectsFromArray:partialQuestions];
    }
    
    [RandomUtils shuffleArray:questions];
    
    return [questions copy];
}

+(NSArray *) getShuffledQuestionsArray: (int) size
{
    int quarter = size / 4;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; ++i)
    {
        [array addObject:[[NSNumber alloc] initWithInt:quarter]];
    }
    
    int diff = size - quarter * 4;
    if (diff > 0) {
        for (int i = 0; i < 4 && diff > 0; ++i)
        {
            NSNumber *number = array[i];
            array[i] = [[NSNumber alloc] initWithInt:number.intValue + 1];
            --diff;
        }
    }
    
    [RandomUtils shuffleArray:array];
    return [array copy];
}

@end
