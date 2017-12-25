//
//  ViewController.m
//  DigitalScale
//
//  Created by Mansi Barodia on 12/24/17.
//  Copyright © 2017 Mansi Barodia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *weightLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setUpContainer];
    
    self.weightLabel.font = [UIFont fontWithName:@"Helvetica" size:24];
    self.weightLabel.text = @"Place weights on spoon";
    self.weightLabel.textColor = [UIColor whiteColor];
    self.weightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.weightLabel];
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    mainWindow.gestureRecognizers = 0;
}

- (BOOL)checkForForceTouchAvailability
{
    if ([self.view respondsToSelector:@selector(traitCollection)] &&
        [self.view.traitCollection respondsToSelector:@selector(forceTouchCapability)] &&
        self.view.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        return YES;
    }
    return NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self checkForForceTouchAvailability])
    {
        UITouch *touch = [[touches allObjects] firstObject];
        CGFloat maximumForce = touch.maximumPossibleForce;
        
        if (touch.force >= maximumForce)
        {
            CGFloat weightOz = 385 / 28.375;
            _weightLabel.text = [NSString stringWithFormat:@"385+ grams / %.02f oz", weightOz];
        }
        else
        {
            CGFloat weightGrams = ((touch.force/maximumForce) * 385);
            CGFloat weightOz = (weightGrams / 28.375);
            _weightLabel.text = [NSString stringWithFormat:@"%.02f grams / %.02f oz", weightGrams, weightOz];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _weightLabel.text = @"0 gram";
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)setUpContainer
{
    CGRect frame = _imageView.frame;
    frame.origin.x = ([[UIScreen mainScreen] bounds].size.width - frame.size.width) / 2;
    frame.origin.y = ([[UIScreen mainScreen] bounds].size.height - frame.size.height) / 2;
    _imageView.frame = frame;
    
    UIImage *image = [UIImage imageNamed:@"centerIconImage"];
    [_imageView setImage:image];
    [_imageView setHidden: NO];
    [self.view addSubview:_imageView];
    [self.view bringSubviewToFront:_imageView];
}

@end
