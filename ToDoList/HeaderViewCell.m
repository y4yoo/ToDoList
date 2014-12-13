#import "HeaderViewCell.h"
#import "NSDate+Utilities.h"

@interface HeaderViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation HeaderViewCell

- (void)setupWithDate:(NSDate *)date
{
    [self.dateLabel setText:[NSDate headerViewFormatDate:date]];
}

@end
