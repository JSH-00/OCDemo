// 在get方法里创建对象
- (UIImageView *)imageView
{
    if(!_imageView)
    {
        UIImage *image = [UIImage imageNamed:@"sv.png"];
        _imageView = [[UIImageView alloc]initWithImage:image];
    }
    return _imageView;
}
