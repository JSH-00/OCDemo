#import "GestureTableViewCell.h"
static NSString * cellID = @"TcellID";

# pragma mark 注册 GestureTableViewCell
[gestureTable registerClass:[GestureTableViewCell class] forCellReuseIdentifier:@"TcellID"];

# pragma mark 根据注册的 cellID 重用已注册的 cell
GestureTableViewCell *cell = [self.gestureTable dequeueReusableCellWithIdentifier:cellID];

# pragma mark 若 cell 未定义，则重用已注册的TcellID
if (nil == cell) {
    cell = [[GestureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
