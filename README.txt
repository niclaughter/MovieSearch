# MOVIE SEARCH

So I definitely had a little fun with this one. Of course my naming conventions got a little goofy, so in practice I definitely would have named things less facetiously. My kid was up all night with food poisoning, so I got a bit loopy towards the beginning. 😜

If I had more time, the first thing I would implement is better Voice Over support. Right now the post notifications are a little wonky, and when the app launches, it announces the "new results" before the nav bar heading, so those would be my priorities.

Next, I would have focused on fixing the bug where tapping on the top of the screen scrolls up, but also extenda the navigation bar further than normal, blocking the search bar when tapped. I also would have implemented a detail view that displayed more detailed information on the movies when tapped. 

I also would have created a delegate to instruct the parent View Controller to call the `animate` function after the initial fetch. Currently it gives the appearance, but it could be much better.

Lastly, my testing is incredibly simplistic. If I had more time, I would have implemented network stubbing and allowed for more dynamic test scenarios instead of the one-off tests I did write. I also would have added tests around my extensions, etc.

Thanks for taking the time to look at my code challenge! If you have any questions about it, just reach out to me @nictheawesome.