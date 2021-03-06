# CMG Engineering Audition
The technical documentation is on a [different page][1].

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
I decided to go with this first. This is because I don't know how much time I will had in the next week: so the business value first, and after that I can refactor or something.

---

I had different exciting errors during implement the working MVP. Like the sample dataset was invalid, or the math libs for deviation were different.
After all, I did some dirty work with the codebase, but the tests are good I think.
Now the next task is to refactor it a bit to have a better code reading experience.

---

So after some refactor and decoupling things, I decided to consider it done for an MVP.
I did some [TECHNICAL DOCUMENTATION][1] for using the code.
And the generator to test with larger files. At this point thermometer knows negative numbers too

Go to the version 2. Maybe it will be better, faster, prettier.

### 4) Version #1.1: Modified OOP approach
The first thing I wanted to change, is the loading of the data.
But I realized, the `v1` can work with enumerator too (if I refactored it a bit),
so in the runner this is called `v1.1`.

I created the benchmark frame too, so I have numbers: its faster, but not much.
But I'm sure it eats less memory, which is a benefit too.

### 5) Conclusion
Sadly I'm out of time. I wanted to create a functional approach, who have minimal boilerplate with objects,
and only reads, and stops if something is out of order, and give a verdict.
But to be honest, this sounds good but have no really too much benefit.
It can maybe work in the OOP story too. With more refactoring...

I wanted to create a `Rust` version of this too because of fun, but really have no time for that.

### 6) The Extra
I think the log format will be better, if there will be the all of necessary informations in one line.
Like time, sensor name, sensor type, the value. And the reference values stored somewhere else.
```bash
2007-04-05T22:04:00 | humidity | hum-2 | 44.4
2007-04-05T22:04:01 | humidity | hum-1 | 44.2
2007-04-05T22:04:01 | monoxide | mon-1 | 4
```
Even in the filename, but somewhere else. Thats an important metainformation, but not a log.
At least if the environmental values does not varies. In this case something like that needed:
```bash
2007-04-05T22:04:00 | reference | { thermometer: 45.0, humidity: 67.8, monoxide: 3 }
```

I did a lot of regex, but it can be solved by simple splits too, if I know what the exact form of a line can only come!
So maybe if the log stores only JSON objects, it can be parsed without any problem (or regexp, or magic).
Just `readline and JSON.parse`.

And the merging. I know its one room one context, but different sensors.
Different tools needs separate logs, and like that we can read them paralell.
And the log format simplified again.

So by the way, if we log the values only (time seems unnecessary now) and we know, that sensor is for what type:
then we can read only by parsing values line by line, and if some values is out of boundary, then simply stop the process,
and we can label that sensor with `discard`. Otherwise run as long as we have resource for that.

If we need aggregated value from the data, like the deviation one, sure we need to read them all.
But have a chance to make some anomaly detection too, to exclude bad measures.

#### Final thoughts
That was fun to attend in this task. I hope you like my product even if my design mistakes was questionable.

Not my proudest work, but I hope you will see my knowledge with the solution I gave and you will give me a good judgement about that :-)

I added Mira as project collaborator, but please provide me more names if needed!

[1]: ./blob/master/TECHNICAL-DOCUMENTATION.md
