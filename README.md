# ClimateCombat

#### What is the app?
Every day you open the app the weather of Malmö and Amsterdam will be compared and the city with the highest “weather grade” will get a point! The app will keep score to show you which city is in the lead.

#### Why did I want to make it?
Since I’m moving from Amsterdam to Malmö many people ask me how the weather compares. The dutch weather site weeronline gives a [grade](https://www.weeronline.nl/nieuws/weercijfer) to the weather every day, so I can use that to express in hard numbers where the weather is actually better.

#### Focus points
The main goals I wanted to reach with this app is first of to gather some data about how the weather in Malmö compares to the weather in Amsterdam in an easy way.
I wanted to write it using SwiftUI and Combine to take the chance to learn to work with these new frameworks. Learning to work with SwiftUI and Combine had priority for me over writing a fully worked out app, because of this the app is more of a proof of concept. In this light I made the following choices for the app:

- #### Daily updates

I initially had the plan to fetch the data from the weeronline website on a daily basis. In a production app I would have a server that would sent (possibly silent-) push notification with a data update. But that didn’t fit int he scope of this prototype. So I considered both using local notifications or a background fetch. But I didn’t want the app to be focussed around notifications that had to be granted. And a background fetch can’t give the option to fetch the data at a certain time. So I opted for the simplest solution of only fetching the data on the days the user opens the app. 

- #### Getting the data

If this app was meant for production I would use a server that calculates it’s own weather grade based on an open weatherAPI. Now I decided to simply scrape the data from the weeronling website. This method is very unreliable though, if the weeronline website changes at any point my app will stop working. But for a proof of concept it passes.

- #### Customisable cities

It would be cool for the user to be able to input whatever city they want to battle, and maybe even have more battles going on at the same time. But for now I focussed on just comparing Amsterdam and Malmö. I even decided to hardcode the names of the cities to make the code clearer. If I decide to expand the functionality I will have to rewrite it, but I decided not to optimise prematurely.


