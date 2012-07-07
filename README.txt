This script scrapes the App Store and finds out whether an app is featured on either
the App Store homepage or in a specific category.

See http://www.futuretap.com/blog/scraping-app-store-featured-entries/ for a longer description.


Usage:

# itFeatured.pl <numerical app ID> <category (Medical, Utilities etc.)> [iPhone | iPad]

If "iPhone" or "iPad" is not specified, it defaults to iPhone.

Example:
iTunesFeatured.pl 284940039 Navigation


The script's output is Tab delimited to make it easy to import it into other systems.

Columns:
- Date
- Country Code (2 letter, uppercase)
- Matches on the root level of the App Store
- Matches on the category level of the App Store

If the app is not featured, nothing is printed out.

Note: The script is SLOOOOWWW. It has to spider 9 web pages per country, so it takes a long time.

If you use this script, I'd be glad to know. Just shoot me a tweet @futuretap or a mail at
info@futuretap.com.

Thanks, have fun!

- Ortwin

=====

Copyright 2010 FutureTap. All rights reserved.
http://www.futuretap.com/blog/scraping-app-store-featured-entries/

This work is licensed under a Creative Commons Attribution-Share Alike 3.0 Unported License
http://creativecommons.org/licenses/by-sa/3.0/

=====

Changes: 2012-07-07 @monkeydom
Greatly improved speed by having a queue of 10 downloaders instead of just one at a time. If you run into issues, reduce the $max_concurrent_requests value of 10 to something smaller.