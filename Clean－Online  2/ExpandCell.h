#import <UIKit/UIKit.h>

@interface ExpandCell : UITableViewCell
@property (strong , nonatomic) UILabel* m_TileL;
-(void)setCellContentData:(NSString*)name;

@end
