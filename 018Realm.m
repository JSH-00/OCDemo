#import <Realm/Realm.h>

#pragma mark - 创建对象
// 方式一: 接受一个数组对象
Student *stu1 = [[Student alloc]initWithValue:@[@1, @"jun"]];

//方式二: 接受一个字典对象
Student *stu2 = [[Student alloc]initWithValue:@{@"num": @2, @"name":@"titan"}];

//方式三: 属性赋值
Student *stu3 = [[Student alloc]init];
stu3.num = 3;
stu3.name = @"titanjun";

#pragma mark - 写入对象

//方式一: 提交事务处理
//获取Realm对象
RLMRealm *realm = [RLMRealm defaultRealm];
//开始写入事务
[realm beginWriteTransaction];
//添加模型对象
[realm addObject:stu1];
//提交写入事务
[realm commitWriteTransaction];


//方式二: 在事务中调用addObject:方法
RLMRealm *realm = [RLMRealm defaultRealm];
[realm transactionWithBlock:^{
    [realm addObject:webSite1];
    [realm addObject:webSite2];
}];


//方式三: 在事物中创建新的对象并添加
[realm transactionWithBlock:^{
    //添加模型
    [Student createInRealm:realm withValue:@{@"num": @3, @"name":@"coder"}];
}];

#pragma mark - 查询对象

//1. 获取所有数据
RLMResults *resArr = [Student allObjects];
NSLog(@"%@", resArr);

//2. 添加一条数据
RLMRealm *realm = [RLMRealm defaultRealm];
Student *stu = [[Student alloc]initWithValue:@[@10, @"coder"]];
[realm transactionWithBlock:^{
    [realm addObject:stu];
}];

//3. 一旦检索执行之后, RLMResults 将随时保持更新
NSLog(@"%@", resArr);


#pragma mark - 更新操作

//获取Realm对象
RLMRealm *realm = [RLMRealm defaultRealm];
Student *stu4 = [[Student alloc]initWithValue:@{@"num": @4, @"name":@"titan4"}];
//添加数据
// 这个模型stu, 已经被realm 所管理, 而且, 已经和磁盘上的对象, 进行的地址映射
[realm transactionWithBlock:^{
    //添加模型
    [realm addObject:stu4];
}];

// 这里修改的模型, 要是被realm所管理的模型
[realm transactionWithBlock:^{
    stu4.name = @"coder4";
}];

#pragma mark - 更新指定位置：查询-获取-更新
//条件查询
RLMResults *results = [Student objectsWhere:@"num = 4"];
Student *stu = results.firstObject;

//更新指定属性的数据
[realm transactionWithBlock:^{
    stu.name = @"titanking";
}];
