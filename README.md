###SCPullRefresh

A pull refresh for easily customize refresh animation.

####Feature
 * Easy to use
 * Easy to custommize your own refresh animation

####Third Parties
 * [DACircularProgressLayer](https://github.com/danielamitay/DACircularProgress)
 * [FrameAccessor](https://github.com/AlexDenisov/FrameAccessor)

####Usage
 * Copy to your project
 * Subclass SCPullRefreshViewController for your own VCs
 * Instance self.tableView
 * refresh or loadMore will be enabled if self.refreshBlock or self.loadMoreBlock is not nil.

#####notice:
 * Dont forget to call super in your VCs for scrollView delegate & life cycle methods.

####Customize animation
 * see demo in SCCircularRefreshView or SCBubbleRefreshView for customization

####DEMO
 * bubble effect
![Bubble](http://ww1.sinaimg.cn/large/84efdcc6gw1ejibyjkxy1g208w0fsh14.gif)
 * circular effect
![Circular](http://ww1.sinaimg.cn/large/84efdcc6gw1ejibywk6jxg208w0fstt1.gif)

####License

MIT
