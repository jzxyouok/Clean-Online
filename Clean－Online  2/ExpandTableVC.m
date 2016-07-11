
#import "ExpandTableVC.h"
#import "ExpandCell.h"


@interface ExpandTableVC ()

@end

@implementation ExpandTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.m_ContentArr = [NSArray array];
    

	 self.view.backgroundColor = [UIColor colorWithRed:167.0f / 255.0f green:255.0f/ 255.0f blue:253.0f/ 255.0f alpha:0.3f];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.m_ContentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[ExpandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //[cell setCellContentData:[self.m_ContentArr objectAtIndex:indexPath.row]];
	cell.textLabel.text = [self.m_ContentArr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
	cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor greenColor];
	
    return cell;
}





#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate_ExpandTableVC respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_delegate_ExpandTableVC tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end

