# Shapr3D backend engineer homework
###### started at: 2020.07.12 - 12:08
###### ended at: 2020.07.??

## 1. Project definitions

Because of the narrow deadline I decided to use some old technologies that I know better than newer ones. And not just because of that, but I did things like that before in this stack, and I'm sure that will be a working way.
To be successful in the job selection process, I will use metodologies like TDD, etc.
I will do an MVP, won't deal with easy-to-solve stuff like authentication, authorization, or any stuff what isn't core business logic.
Outside of the API itself, I will do an easy-to-handle demo site to test the function manually.

## 2. Tech Stack

 - Rails without everything outside components for an API
 - ~~Resque for asynch job running~~
 _(I see that not allowed here, but have not too much time. So I will begin with this, and write an alternative for that)_
 - Rspec for testing
 - Docker for running
 - Bootstrap for the demo page
 - some documentation tool for the API

The deployment part is depend on how much time I'm able to spend for this homework. Beside my main work sadly I don't have many.
So the plan is I will do some helm chart for installing the application to `Kubernetes`.
The plan B is to run it on `heroku`.

## 3. Timeline

I spearate the project to 3 different days. Let's say every day have **5** working hour.
1. **Day Architecture**
   - Dockerfile and compose
   - Rails install
   - CI/CD
   - API documentation
2. **Day Implementation**
   - API implementation
   - Demo site implementation
3. **Day Deployment (and extra steps)**
   - Own Async Job implemetation
   - Helm chart

## 4. Run

In local env just run:
```sh
$ docker-compose up --build
```
And browse for [localhost:3000](http://localhost:3000)

## 5. Deployment plan & Scaling

I did some proper CI/CD process with `GitHub Actions` and `Heroku`, so you can test the project here: [shapr-mikopet.herokuapp.com](https://shapr-mikopet.herokuapp.com)

The Plan B is simply this. With a `Procfile` we can define multiple processes. **1 for the API, 1 for the worker.**
There is a computing unit called dyno. We can set the amount of dynos whatever we want.
Heroku offers an autoscale option for a price, but we can write our own method for that.
For example: when the conversion job count is too high like double of worker number, we spawn a new dyno. or simply when there is a job, then we spawn a new worker. And if we have idle dynos, simply downscale that number.
That can be achieved with a simple CLI command, or by using an SDK.

The Plan A is to have a separate `Job` in k8s for the worker, what is spawned by the API.
So until we have resource in a kubernetes cluster, we can spawn unlimited worker pods.
But this is an operation task.

Thanks for reading :-)
