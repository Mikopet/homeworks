# Red Acre DevOps Technical Challenge

### 0) Project basics, vision
Although, the task seems straighforward, there is always a cling for thoroughness.
In this case I do not have any linux computers at hand, so I need to solve this on my only weak windows machine.
So, there is a challenge though.

 - The first part, to dockerize the backend and frontend application is something like "finger-exercise".
 - The second part will be a bit more tricky, because I do not have a personal AWS account, and I was not prepared for paid for my own assessment, but let it be. It should be fun.
 - The third part definitely will be tricky, because running k8s at a local windows machine... well, I dont know what to expect. Maybe I will deploy an EKS for it, dont know yet.

To be honest, RedAcre made a mistake when sent me the task, because in the description on WeTransfer remained the name of the other applicant. (with today's deadline, omg)
This was very easy to find that repository. Not to use as a guideline, but maybe as a baseline for doing a better job.

But hell, that git history is a mess... as the solutions as well, but that is not my business to evaluate that. Move on!

### 1) Containerizing the applications
The task is, to use `Docker` and `docker-compose` to put the 2 application inside containers.
The frontend needs to be exposed. I choose `nginx-unit` for that.
Optional solution is to create a proxy container between them, and maybe for exposing the whole system, but I do not see the benefit yet. Decide later. :)

The company needs some technical documentation for the solution.

#### 1.1) Backend container
I start with the backend, it seems easier.
It had appeared before, that the `requirements.txt` is flawed. I dont know why, and is this the part of the challenge, but I corrected it in a very clear way.
Delete it completely, and rebuild from scratch. Starting with the newest `Flask`, and scream-testing what it needs.

I had some problems with this WSL madness, but I managed to run the container properly.

#### 1.2) Frontend container
I'm not familiar with node ecosystem either, but the application started and terminated with an Error. I did't know, what to say.
But it turned out, I was just too optimist, a downgrade on the node version helped.

#### 1.3) Proxy container and some thoughts
I owe an apology. I was too hard on Sujin, he seems a hardworking man, even if he lacks some orderliness.

In this case a separate proxy container is completely unnecessary. For local developent this `docker-compose` solution is more than enough (okay, it could use volumes if needed, but now that's not very important), in production environment I would use `nginx-unit` for these little runtimes as a proxy.
All other job should be done by the orchestration system.

Because I don't have much time, instead of implementing the `nginx-unit` approach I will move on to the next task.

### 2) Terraforming
It turned out, I had an AWS account just it was not activated. And the activtion process was stucked, so I needed to open a ticket to the Customer Support...

However, the plan is to write a correct terraform solution, and provision the services properly.
I want to run this workload in `ECS` with `ALB` configured. If I have time I will add `WAF`, maybe a Global Accelerator.
The frontend should run on `S3`+`CloudFront` maybe.
I chose `eu-west-1` as region, because usually that's the cheapest.

#### 2.1) Networking
Finally AWS managed to activate my account. Hence, I can continue.
I decided to go with the networking first, because that's the nest where the App-nestlings will grow up :-)

So what I need?
 - A `VPC`
 - An `IGW`
 - A `Route Table`
 - A private and a public `subnet`
 - `Security Groups`

I will go with the most simple solution there.

#### 2.2) Load Balancer for the backend
It's practically very straightforward:
 - `Security Group` to access `ECS`
 - The `ALB` and it's `listener`
 - `Target group`
 - An `output` for the public dns

#### 2.3) ECS for the backennd
Well, finally arrived here. There will be no magic:
 - A simple `ECS` cluster
 - With `task definition`
 - and a `container service`

It's working flawlessly on `fargate` with the default nginx container.
Let's deal with the container registry

#### 2.4) ECR for the backend
Well, it is very obvious to use ECR here.
After locally building the flask container, we just push to the AWS, and we can use that image!

