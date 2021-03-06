# Interview Task for BVtech

This is a small application that is allowing a customer to create events and markets for those events given a list of sports. It is done using Ruby on Rails, with traditional rails server-side rendering pages

The app contains:
* An index view of all the Events in the system
* A detailed view of an Event with all its markets
* An independent form where the user can create / update an event

The form for a single event is done in only one page where the customer can select the sport from a dropdown list and then fill the data for the event and the markets associated to it.
> Note: one sport can have multiple events and one event can have multiple markets.

Requirements:
- [x] Full test coverage
- [x] Commit as I go along
- [x] From some countries, the endpoint is not accessible. Implement a workaround.

###### TL;DR
Quick run the app:
```bash
$ docker-compose up
```
Run the tests:
```bash
$ docker-compose run web rspec
```

Demo app can be found at: https://bvtech-demo.herokuapp.com/

# Solution step-by-step

### -1) Accessing the API endpoint ~ 20 min

From browser I can access the URL with a VPN service. From CLI the first try was with curl and with `X-Forwarded-For` set.
Sadly the situation is not that easy here.
So with a little lookaround I found a proxy with a fair approach: `https://web-proxy.io/proxy/#{URI}`
A little wrapper around it should do it for now.

### 0) Planning ~ 60-80 min

So we want an app where the customer can add events for different sports and associate markets for them.
For that we are in need to query the sports from the BV API and synchronize them to the database.

The events are quite imaginable, but I needed to lookup what a market exactly is.
It is quite easy so far. The next task is to create a form where one can update and create an event.

I do not want to create authentication and authorization and admin and so on. A simple CRUD should do it.

---

The plan is:
1. create the wrapper for the proxy call
2. sync this received data to the db (rake task)
3. create form for markets
4. create the form for events
5. create the view of event index
6. create the view for the event details
7. refact & cleanup

I will use `bootstrap` and maybe a `toastr`. Keep it very simple.

### 1) The Proxy Wrapper ~ 2-3 hours

We need a HTTP client. We could have used the built-in solution, but for now a smarter one called `Faraday` will be used.

More solutions are here, to extend the proxywrapper to use whatever we want:
https://www.ruby-toolbox.com/categories/http_clients

( there is a `proxy_fetcher` gem too. It seems buggy... :/ )

To be honest, this PoC took much more time what it deserves...
...and that only proxy service stopped working properly...

Whatever, I will fix it later if I will have the mood. Now mocking this part...

### 2) The Sync Task ~ 5-8 hours

It seemed very easy for first sight: a rake task, what initializes the proxy and call the BV url.
Saves it somewhere in the `tmp/`, sync it to the database, cleaning up.
Only the sync logic is a bit tricky because the mutability of data like this can cause bugs.

In reality we don't need the tmp, just do things on the fly. And yes, the task is easy... but the tests were heavy for them...
It's not optimal, but works great.

The proxy service is still dead, so I needed to mock it locally :/

### 3-4) Market & Events forms ~ 2 hours

I decided to go with `thoughtbot/administrate`. There is no point in creating a CRUD logic again from scratch.
Instead of dealing with that I can focus to proper backend business logic.
Maybe some devops thingy.

### *) CI/CD ~ 1-2 hours

Just a bonus task. CI configuration for autotesting and CD for autodeploying the app to Heroku: https://bvtech-demo.herokuapp.com/

