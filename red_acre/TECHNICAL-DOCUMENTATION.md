# Red Acre DevOps Challenge
## TECHNICAL DOCUMENTATION

### Task #1: Spinning up local environment
To start the Flask and React app, you just need to run:
```bash
docker-compose up --build
```

And then you can check the results at: http://localhost:3000

### Task #2: Deploy to the Cloud
To set up the cloud infrastructure, you need to set up your credentials first:
```bash
aws configure
```

After this you need to setup the infrastructure. You can do it easily by:
```bash
terraform -chdir=terraform/ apply
```

Check the changes thoroughly, write `yes` and press `ENTER`

The last thing we need to do, is deploy the applications:
```bash
./deploy.sh
```

If it asks for confirmation, do the same, check and send `yes`.

At the end of the process you will see the public endpoints.

---

If you wanna destroy the infrastructure, just run:
```bash
terraform -chdir=terraform destroy
```

