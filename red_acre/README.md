# Red Acre DevOps Technical Challenge

### 0) Project basics, vision

Although, the task seems straighforward, there is always a cling for thoroughness.
In this case I do not have any linux computers at hand, so I need to solve this on my only weak windows machine.
So, there is a challenge though.

 - The first part, to dockerize the backend and frontend application is something like "finger-exercise".
 - The second part will be a bit more tricky, because I do not have a personal AWS account, and I was not prepared for paid for my own assessment, but leet it be. It should be fun.
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


