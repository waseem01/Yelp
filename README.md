# Project 2 - *Yelp Search*

**Yelp Search** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **35** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
   - [x] Table rows should be dynamic height according to the content height.
   - [x] Custom cells should have the proper Auto Layout constraints.
   - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [x] The filters table should be organized into sections as in the mock.
   - [x] You can use the default UISwitch for on/off states.
   - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [x] Search results page
   - [x] Infinite scroll for restaurant results.
   - [x] Implement map view of restaurant results.
- [x] Filter page
   - [ ] Implement a custom switch instead of the default UISwitch.
   - [x] Distance filter should expand as in the real Yelp app
   - [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [x] Implement the restaurant detail page.

The following **additional BONUS** features are implemented:

- [x] Bonus features
   - [x] NearMe search on list view & map view
   - [x] Flip to switch between Map & List View
   - [x] Tap on annotation pin shows business information
   - [x] Tap on annotation info accessory shows business detail & location
   - [x] Banner message on exhaustive search
   - [x] Custom styling for tableview cell
   - [x] Search on mapview updates map pins
   - [x] Misc UI Animations
   

- [ ] List anything else that you can get done to improve the app functionality!

## 3rd Party
* [x] AFNetworking
* [x] Unbox
* [x] KRProgressHUD
* [x] OAuthSwift

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Video Walkthrough](yelp.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes