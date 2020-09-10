//.h///
- (void)blockSartTest:(void (^)(int))passBlock andError:(void (^)(int))errorBlock;
//.m///
- (void)blockSartTest:(void (^)(int))passBlock andError:(void (^)(int))errorBlock
{

    if(passBlock && errorBlock)
    {
        //11
        int buildNum1 = 200;
        passBlock(buildNum1); // 执行传入的 (int)block{}
    }
    else
    {
        int buildNum2 = 404;

        errorBlock(buildNum2);
    }
}
//VC///
[test1 blockSartTest:^(int passNum){ //对照define，为blockSartTest函数传入入参为int的block
    NSLog(@"block测试通过,build:%d",passNum);
} andError:^(int errorNum){
    errorNum = 404;
    NSLog(@"blocks测试不通过!!!build:%d",errorNum);
}];

/*
 block 传值，最好使用局部变量 static，访问方式为指针传递，在调用 block 前都可更改传入的值
 */
