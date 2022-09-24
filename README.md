# **Distributed Operating Systems - Project 1** 

## Bitcoin Mining using Actor Model

### **Group Members-**
* Anurag Patil
* Pratik Kamble

### Problem Definition
* Bitcoins are the most popular crypto-currency in common use. 
* At their heart, bitcoins use the hardness of cryptographic hashing to ensure a limited “supply” of coins.
* In particular, the key component in a bit-coin is an input that, when “hashed” produces an output smaller than a target value.
* In practice, the comparison values have leading  0’s, thus the bitcoin is required to have a given number of leading 0’s 
* The goal of this first project is to use Erlang and the Actor Model to build a good solution to this problem that runs well on multi-core machines.

#### Requirements
* Input: The input provided will be, the required number of 0’s of the bitcoin.
* Output: Print, on independent entry lines, the input string, and the correspondingSHA256 hash separated by a TAB, for each of the bitcoins you find. Obviously, your SHA256 hash must have the required number of leading 0s.  An extra requirement, to ensure every group finds different coins, is to have the input string prefixed by the gator link ID of one of the team members.

### Steps to run the code
* Download erlang
* 

### Conclusions

* Size of the work unit that you determined results in the best performance for your implementation and an explanation of how you determined it. The size of the work unit refers to the number of sub-problems that a worker gets in a single request from the boss.
* The result of running your program for input 4
* The running time for the above is reported by time for the above and report the time.  
* The ratio of CPU time to REAL TIME tells you how many cores were effectively used in the computation.  If you are close to 1 you have almost no parallelism (points will be subtracted).
* The coin with the most 0s you managed to find.
* The largest number of working machines you were able to run your code with.
