# CMG Engineering Audition
## TECHNICAL DOCUMENTATION

### Environment
Everything can be run by `docker-compose` and through `Rake`.

For example running the tests:
```bash
docker-compose run app rake spec
```

### Run the code
There are some code versions to run.

You can achieve it by giving a code version and a filename:
```bash
docker-compose run app rake run[v1,sample_data]
```

### Generate data
For generating some data execute the following:
```bash
docker-compose run app rake generate[200,400]
```
Where it generates log with 200 sensors with 400 records each.

### Run the benchmarks
To compare the running time of the different versions you need only just run the benchmark:
```bash
docker-compose run app rake benchmark
```
