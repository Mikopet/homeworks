# Interview Task for BVtech

This is a small application that is allowing a customer to create events and markets for those events given a list of sports. It is done using Ruby on Rails, with traditional rails server-side rendering pages

The app contains:
* An index view of all the Events in the system
* A detailed view of an Event with all its markets
* An independent form where the user can create / update an event

The form for a single event is done in only one page where the customer can select the sport from a dropdown list and then fill the data for the event and the markets associated to it.
> Note: one sport can have multiple events and one event can have multiple markets.

Requirements:
- [ ] Full test coverage
- [x] Commit as I go along
- [ ] From some countries, the endpoint is not accessible. Implement a workaround.

###### TL;DR
Quick run the app:
```bash
$ docker-compose up
```
Run the tests:
```bash
$ docker-compose run web rspec
```

# Solution step-by-step

### 0) Accessing the API endpoint

From browser I can access the URL with a VPN service. From CLI the first try was with curl and with `X-Forwarded-For` set.
Sadly the situation is not that easy here.
So with a little lookaround I found a proxy with a fair approach: `https://web-proxy.io/proxy/#{URI}`
A little wrapper around it should do it for now.

