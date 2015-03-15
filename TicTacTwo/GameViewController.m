//
//  GameViewController.m
//  TicTacTwo
//
//  Created by Cameron Flowers on 3/14/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (strong, nonatomic) IBOutlet UILabel *labelZero;
@property (strong, nonatomic) IBOutlet UILabel *labelOne;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) IBOutlet UILabel *labelFour;
@property (strong, nonatomic) IBOutlet UILabel *labelFive;
@property (strong, nonatomic) IBOutlet UILabel *labelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UILabel *labelEight;
@property (strong, nonatomic) IBOutlet UILabel *draggerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property CGPoint pointTapped;
@property CGPoint draggerPoint;
@property CGPoint originalPoint;
@property NSNumber *clickedPoint;
@property NSArray *labelsArray;
@property NSMutableSet *corners;
@property NSMutableSet *middles;
@property NSMutableSet *availableCells;
@property NSTimer *timer;
@property int timeTick;

@property bool humanPlayer;
@property bool winner;
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.timeTick = 10;
    [self setTimer];
    [self countDown];
    self.whichPlayerLabel.text = @"it's X's turn"; // starts off with x's turn
    self.labelsArray = [NSArray arrayWithObjects:(UILabel *)self.labelZero, self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, nil];
    self.availableCells =[[NSMutableSet alloc] initWithObjects:(NSString *)
                          @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", nil];
    self.corners = [[NSMutableSet alloc] initWithObjects:(NSString *)
                                                        @"0", @"2", @"6", @"8", nil];
    self.middles = [[NSMutableSet alloc] initWithObjects:(NSString *)
                                                        @"1", @"3", @"4", @"5", @"7", nil];
    self.draggerPoint = self.draggerLabel.center;
    self.humanPlayer = true;
}

-(IBAction)tapRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"You Touched Me!");
    self.pointTapped = [gestureRecognizer locationInView:self.view];
    NSUInteger index = [self findLabelUsingPoint:self.pointTapped];

    NSString *setIndex = [NSString stringWithFormat:@"%lu", index];

    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if( index != -1)
        {
            self.timeTick = 10;
            for (UILabel *foundLabel in self.labelsArray)
            { //creates a temp object to search array
                if ([[self.labelsArray objectAtIndex:index] isEqual:foundLabel])
                {
                    //NSLog(@"Labor Label Labor Label");
                    //NSLog(@"%i",self.playerTurn);
                    if (self.humanPlayer) {
                    if([foundLabel.text isEqualToString:@""])
                    {
                        //Human Logic
                            [self removeSetObjects:setIndex];
                            [self removeCornerObjects:setIndex];
                            [self removeMiddleObjects:setIndex];
                            foundLabel.text = @"X";
                            foundLabel.textColor = [UIColor blueColor];
                            if([self checkWinner:@"X"])
                            {
                            [self gameOver:@"X Wins!"];
                            }
                    }
                    }

//                          //Implement AI Logic
//                            foundLabel.text = @"O";
//                            foundLabel.textColor = [UIColor redColor];
//                            [self checkWinner:@"O"];
            /*
             bool picked = NO;
             do while (picked = NO){
                //find random number between 0 and available set.count
                if number is in corners pick it
             else if numbers is in middles pick it
             
             */
                    }

                }

            }
        }
    }



-(IBAction)panRecognizer:(UIGestureRecognizer *)panRecognizer
{
    if(panRecognizer.state == UIGestureRecognizerStateEnded) //if we stop "doing gesture"
    {
        self.timeTick = 10;
        CGPoint panPoint = [panRecognizer locationInView:self.view];
        self.draggerLabel.center = panPoint;
        NSUInteger index = [self findLabelUsingPoint:self.draggerLabel.center];
        NSString *setIndex = [NSString stringWithFormat:@"%lu",index];

        if (index != -1)
        {
            for (UILabel *foundLabel in self.labelsArray)
            {
                //creates a temp object to search array
                if ([[self.labelsArray objectAtIndex:index] isEqual:foundLabel])
                {
                    NSLog(@"Labor Label Labor Label");
//                    NSLog(@"%i",self.playerTurn);
                    if([foundLabel.text isEqualToString:@""])
                    {
                        //We can insert
//                        if (self.playerTurn == 0)

                            self.draggerLabel.text = @"X";
                            self.draggerLabel.center = foundLabel.center;
                            //it is X's Turn
                            foundLabel.text = @"X";
                            foundLabel.textColor = [UIColor blueColor];

                            //need to remove object

                            [UIView animateWithDuration:1.0 animations:^{
                                self.draggerLabel.center = self.draggerPoint;
                            }];
//
//                            [self.playerOneLog addObject:(NSString*) setIndex];
//                            NSLog(@"x set has %lu elements",[self.playerOneLog count]);
//                            if (![self checkWinner:self.playerOneLog])
                            {
//                                self.playerTurn = 1;
                                self.draggerLabel.text = @"O";
                                self.whichPlayerLabel.text = @"It's O's Turn";
                            }


                                NSString *winnerMessage = @"Temp String Just Chillin";
                                [self gameOver:winnerMessage];

                            
                        }


                    }
                }
            }
        }
    }


-(NSUInteger)findLabelUsingPoint:(CGPoint)point
{
        NSLog(@"We know to look");
        for (UILabel *foundLabel in self.labelsArray) {
            if(CGRectContainsPoint(foundLabel.frame, point)){
                NSLog(@"%@",foundLabel.text);
                return [self.labelsArray indexOfObject:foundLabel];
            }
        }
        
        return -1;
        
    }

-(void)gameOver:(NSString *)winnerMessage
{
    {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over"
                                                   message:winnerMessage
                                                  delegate:self
                                         cancelButtonTitle:@"Dismiss"
                                         otherButtonTitles:@"New Game!", nil];
                                                    [alert show];
    }
}

-(BOOL)checkWinner:(NSString*)a
{
    if([self.labelZero.text isEqualToString:self.labelOne.text] &&
       [self.labelOne.text isEqualToString:self.labelTwo.text] &&
       [self.labelZero.text isEqualToString:a])
    {
        return true;
    }
    if([self.labelThree.text isEqualToString:self.labelFour.text] &&
       [self.labelFour.text isEqualToString:self.labelFive.text] &&
       [self.labelThree.text isEqualToString:a])
    {
        return true;
    }
    if([self.labelSix.text isEqualToString:self.labelSeven.text] &&
       [self.labelSeven.text isEqualToString:self.labelEight.text] &&
       [self.labelSix.text isEqualToString:a])
    {
        return true;
    }
    if([self.labelZero.text isEqualToString:self.labelThree.text] &&
       [self.labelThree.text isEqualToString:self.labelSix.text] &&
       [self.labelThree.text isEqualToString:a])
    {
        return true;
    }
    if([self.labelOne.text isEqualToString:self.labelFour.text] &&
       [self.labelFour.text isEqualToString:self.labelSeven.text] &&
       [self.labelOne.text isEqualToString:a])
    {
        return true;
    }
    if([self.labelTwo.text isEqualToString:self.labelFive.text] &&
       [self.labelFive.text isEqualToString:self.labelEight.text] &&
       [self.labelFive.text isEqualToString:a])
    {
        return true;
    }
    if([self.labelZero.text isEqualToString:self.labelFour.text] &&
       [self.labelFour.text isEqualToString:self.labelEight.text] &&
       [self.labelFour.text isEqualToString:a])
    {
        return true;
    }
    if([self.labelSix.text isEqualToString:self.labelFour.text] &&
       [self.labelFour.text isEqualToString:self.labelTwo.text] &&
       [self.labelFour.text isEqualToString:a])
    {
        return true;
    }
    else
    {
        return false;
    }
}

//{
//     NSString *test;
//    return test;
//}


-(void)catsGame
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GOOD GAME"
                                                   message:@"It was a tie!"
                                                  delegate:self
                                         cancelButtonTitle:@"Dismiss"
                                         otherButtonTitles:@"New Game!", nil];
                                                    [alert show];
}

#pragma mark - Navigation

- (IBAction)unWindFromResults:(UIStoryboardSegue *)segue
{
}

- (void)removeSetObjects:(NSString *)object
{
    NSMutableSet *tempset = [NSMutableSet setWithSet:self.availableCells];
    [tempset removeObject:object];
    self.availableCells = tempset;
    NSLog(@"AvailableCells set has %lu elements",[self.availableCells count]);
}
- (void)removeCornerObjects:(NSString *)object
{
    NSMutableSet *tempset = [NSMutableSet setWithSet:self.corners];
    [tempset removeObject:object];
    self.corners = tempset;
    NSLog(@"Corners set has %lu elements",[self.corners count]);
}
- (void)removeMiddleObjects:(NSString *)object
{
    NSMutableSet *tempset = [NSMutableSet setWithSet:self.middles];
    [tempset removeObject:object];
    self.middles = tempset;
    NSLog(@"Middles set has %lu elements",[self.middles count]);
}


-(void)setTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(countDown)
                                                userInfo:nil
                                                 repeats:YES];
}



-(void)countDown
{

    self.timerLabel.text = [NSString stringWithFormat:@"%i",self.timeTick];
    self.timeTick--;

    if (self.timeTick == 0)
    {
        self.timeTick = 10;
    }
}


@end
