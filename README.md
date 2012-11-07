Overview
========

This script scrapes the App Store and finds out whether an app is featured on either
the App Store homepage or in a specific category.

See the [blog post](http://www.futuretap.com/blog/revised-app-store-featured-entry-scraper/) for a longer description.


Usage
=====

    itFeatured.pl <numerical app ID> <category (Medical, Utilities etc.)> [iPhone | iPad]

If `iPhone` or `iPad` is not specified, it defaults to `iPhone`.

Example:
    
    iTunesFeatured.pl 284940039 Navigation


The script's output is Tab delimited to make it easy to import it into other systems.

Columns:

- Date
- Country Code (2 letter, uppercase)
- Matches on the root level of the App Store
- Matches on the category level of the App Store

If the app is not featured, nothing is printed out.

Note: The script is rather slow. It has to spider 9 web pages per country, so it takes a long time.
To improve this, it uses a parallel queue of 10 downloaders. If you run into issues, reduce the `$max_concurrent_requests` value of 10 in the script to something smaller.

If you use this script, I'd be glad to know. Just shoot me a tweet [@futuretap](http://twitter.com/futuretap).

Have fun!


<a href="https://flattr.com/thing/799297/futuretapInAppSettingsKit-on-GitHub" target="_blank">
<img src="http://api.flattr.com/button/flattr-badge-large.png" alt="Flattr this" title="Flattr this" border="0" /></a>



License
=======

Copyright 2010-2012 FutureTap. All rights reserved.

http://www.futuretap.com/blog/scraping-app-store-featured-entries/
http://www.futuretap.com/blog/revised-app-store-featured-entry-scraper/

This work is licensed under a Creative Commons Attribution-Share Alike 3.0 Unported License
http://creativecommons.org/licenses/by-sa/3.0/