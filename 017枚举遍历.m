// obj == array objectAtIndex[i]
// i == idx
// *stop = 
[array enumerateObjectsUsingBlock:^(DownloadModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [self downloadFromURL:[array objectAtIndex:idx].download];
}];

for (int i = 0; i < array.count; i++)
{
    [self downloadFromURL:[array objectAtIndex:i].download];
}
