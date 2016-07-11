#import <UIKit/UIKit.h>
@protocol ExpandTableVCDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;



@end

#import <UIKit/UIKit.h>

@interface ExpandTableVC : UITableViewController
@property (strong , nonatomic) NSArray* m_ContentArr;

@property (assign , nonatomic) id<ExpandTableVCDelegate> delegate_ExpandTableVC;
@end
