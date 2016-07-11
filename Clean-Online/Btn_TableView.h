
//
#import <UIKit/UIKit.h>
@protocol Btn_TableViewDelegate <NSObject>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


#import <UIKit/UIKit.h>
#import "ExpandTableVC.h"


@interface Btn_TableView : UIView<ExpandTableVCDelegate>

@property (strong , nonatomic) UIButton* m_btn;

@property (strong , nonatomic) ExpandTableVC* m_ExpandTableVC;

@property (assign , nonatomic) BOOL m_bHidden;

@property (strong , nonatomic) NSString* m_Btn_Name;

@property (strong , nonatomic) NSArray* m_TableViewData;

@property (assign , nonatomic) id<Btn_TableViewDelegate> delegate_Btn_TableView;



-(void)addViewData;



@end
