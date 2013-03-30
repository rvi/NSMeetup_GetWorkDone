//
//  RVViewController.h
//  getWorkDone
//
//  Created by Rémy on 30/03/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVViewController : UIViewController <RDAPIRequestDelegate,RDPlayerDelegate>

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *songDurationlabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/**************************************************************************************************/
#pragma mark - Actions

- (IBAction)playButtonTapped:(id)sender;

- (IBAction)nextButtonTapped:(id)sender;

@end
