# CMG Engineering Audition

### 0) Project basics, vision
When I was about to solve the task, I did figure out how I'm able to pass my thoughts. The idea is this README with a bit blog style. I want to go forward section by section.

So I'm planning two separate solution for the task. One **procedural/functional approach** and the **requested OOP approach**.

Outside of the given example I want to generate larger ones, and try to make a better format for logging too; so at the end I'm able to benchmark both of the solutions to decide which is better with different amount of data sets.

Want to go by TDD and comment the code unnecessarily extensively, to pass my thoughts about some parts. I will use Git so you can see the progress of my work; and after the final adjustments I just have to share the repository.

### 1) Planning
So first day, first ideas. I need some environment, some test data, tests, a prototype or PoC.
I will rethink this whole lineup for tomorrow (this section is the task for today) but lets write something down.
Need a Dockerfile(not necessary), a docker-compose file with one service yet which is a latest ruby and a volume mount. 
Need data, but for the beginning the dataset in the PDF seems enough.

Maybe I will start with the functional code: in IRB I can write the whole functional stuff easily.
The idea about that is, read the file line by line and evaluate one record at once. It looks memory efficient, and fast.
Not the best thing in the universe is testing imperative code, but there all we need is pure functions, and like that, this methods are testable.
So I will write the code function-by-function with tests ahead.
The problem there what we maybe face to is the state in the iteration. But thats an implementation issue.
Okay, we will have a working version. Need more data, so will implement some data-generator.
Test the program with lets say 100k lines.

The second solution is with OOP style. The constructor gets the data (by description) in a string. That sounds not very well, but can work.
For first version we just implement some line reader logic, with different implementation for every sensor type. Connected in an "interface". (Ruby dont have such thing, but there is some dirty solution).
It will work but I don't think it will fly very well.

So refactor this OOP thingy to a more sustainable version. Lets call itt version 3.
I think it's better to get some Enumerable in the constructor or just the link to the data itself.
But this is implementation issue too.

So after all three working versions, need to create metrics for them, like execute time, and data amount.

With the most efficient solution I will make a new log format and bind back to the benchmark to see, it has any improvement in the metrics or ain't.

### 2) Prerequisites
I did some environment with docker and docker-compose. Latest ruby:alpine is perfect for us.
Does not need exact versions yet. This project is ephemeral.
And I did a Rakefile, this will be the center of the repository.
It will run, generate, test, benchmark, and so on if neded.

### 3) Version #1: The requested OOP approach
I decided to go with this first. This is because I don't know how many time I will had in the next week: so the business value first, and after that I can refactor or something.
