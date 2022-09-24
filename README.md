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
* Clone this repository and install erlang.
* This project has 3 implementations :
  1. Serialized Computation
  2. Distributed Implementation
  3. Client-Server-Actor-Model
  
1. **Serialized Computation**: 
   1. This implementation performs the bitcoin mining serially without any parallelism. 
   2. This directory has only one file **mining.erl**
   3. To run this code use the following commands:
      1. cd Serialized Computation
      2. erl
      3. c(mining).
      4. mining:start().
      5. Enter the number of zeroes desired.
      6. 4
      7. To stop the program, press **Ctrl + C**.
      
      Refer the ScreenShot below: 
      <img width="793" alt="Screenshot 2022-09-24 at 17 29 24" src="https://user-images.githubusercontent.com/54627841/192119396-74ad55fc-1eaa-457b-9698-55b2e734a7cc.png">

      
     
2. **Distributed Implementation** [static number of actors]: 
   1. This implementation performs bitcoin mining by mentioning a static number of actors and distributing range of strings to get the corresponding SHA.
   2. This directory has 2 files **client.erl** and **server.erl**
   3. To run this code use the following commands:
      1. cd Distributed Implementation
      2. erl
      3. c(server).
      4. c(client).
      5. server:main().
      6. Enter the number of zeroes desired.
      7. 4 
      8. To stop the program, press **Ctrl + C**.

      Refer the ScreenShot below: 
      <img width="794" alt="Screenshot 2022-09-24 at 17 34 33" src="https://user-images.githubusercontent.com/54627841/192119518-aa363248-0672-49f0-9e41-99ba5cf45a74.png">


3. **Actor Model Client Server Implementation** [Dynamic number of actors]:
   This implementation generates a dynamic number of actors chosen from a Gaussian distribution of a **10,000** numbers. The program starts with the executor of the program submitting the required number of zeros to be present in the address of the mined coin. Later, the selected number of actors are spawned by the server. These actors request a uniform distribution of numbers from the server to append to the GatorID string. This string is hashed using the SHA-256 algorithm and checked for the required amount of leading zeroes. If an actor finds a hash (address) that meets the requirement, it sends the address of the Bitcoin block to the server and continues its execution. This process of message transfer between the server and the corresponding actors is **completely asynchronous**. If an actor runs out of the numbers assigned to it by the server, then the same actor requests the server for a different range of numbers. Thus, this program **DOES NOT** terminate on its own. It needs to be stopped forcefully using a keyboard interrupt.<br><br>

   The required steps to execute the program are mentioned below.
   1. Change the directory to 'Client-Server-Actor-Model'. This directory has 2 files **client.erl** and **server.erl**
   2. To run this code use the following commands:
      1. cd Client-Server-Actor-Model
      2. erl
      3. c(server).
      4. c(client).
      5. Enter the number of zeroes as a parameter to the main function
      6. server:main(4).
      7. To stop the program, press **Ctrl + C**.

      Refer the ScreenShot below: 
      <img width="790" alt="Screenshot 2022-09-24 at 17 36 53" src="https://user-images.githubusercontent.com/54627841/192119589-3eaafbc6-73ac-48a9-ac95-6ab34fe46294.png">

  
### Conclusions and Results

* Size of the work unit that you determined results in the best performance for your implementation and an explanation of how you determined it. The size of the work unit refers to the number of sub-problems that a worker gets in a single request from the boss.

* The result of running your program for input 4
  <pre>3> server:main(4).
    ok
    Actor ID: <0.95.0> Output: "a.patil:2007383"  "0000a12895ccd9feefb8639c5b4e834380395f907c9f3d12927ee4c538b02f54"
    Actor ID: <0.98.0> Output: "a.patil:8011357"  "000004e29805e12006c1f82c290101ad17ff37347aa2b700efc08191d194a9da"
    Actor ID: <0.97.0> Output: "a.patil:6014388"  "00009495e7696c5a5ad48e407eeda57565e42b7a5967fcbe3391831d60266b8e"
    Actor ID: <0.95.0> Output: "a.patil:2037416"  "00005d75694934ffa3a44f36d60066f5cd1155554fd91584334312e8c90a23f9"
    Actor ID: <0.94.0> Output: "a.patil:46211"  "00009ec91fc74c0fdc949b50778ea79314cface6495d0fb158e02c712c5d31fc"
    Actor ID: <0.99.0> Output: "a.patil:10046835"  "0000a921c1efdbbf85402e186b2d91b70afeb055742708ff26114be1266a35dd"
    Actor ID: <0.99.0> Output: "a.patil:10052754"  "0000f45b00ab05f995d7c1d6d21b95034379029a2e9ac22611e25fa427d79bdc"
    Actor ID: <0.97.0> Output: "a.patil:6065694"  "0000e28568389a145d02a9ffd5eac9914f3b825516ab015994a4780289b73b72"
    Actor ID: <0.96.0> Output: "a.patil:4073180"  "0000dd779fe65ef3a2217f71c8c10cb4c443631199fa9b4276e31d676eb8fd64"
    Actor ID: <0.99.0> Output: "a.patil:10079524"  "000069a10eb3cad15b33eccc89b46033c9f2d64373782ef7a7b63dd1d778f259"
    Actor ID: <0.97.0> Output: "a.patil:6078994"  "000091cc9625b2b9f2bd2b18c3d5fe550dee09caffd6ae37c3dbcb9f53edeeeb"
    Actor ID: <0.99.0> Output: "a.patil:10092022"  "00009b7043678c40413f72e974ec242d90e88e3f432aa321c2e12a560511718c"
    Actor ID: <0.95.0> Output: "a.patil:2113496"  "000019f987deba44690b414d80e9b15ed348ea68bf6de2c5fcc14412c1618357"
    Actor ID: <0.95.0> Output: "a.patil:2124212"  "0000ca6a5d315addbd445f7228ae26be91b8dad5a414a234ce2b84fae05ae137"
    Actor ID: <0.98.0> Output: "a.patil:8133489"  "000048b5116735535c765473b8d6670388b74730f432ae049b0e3d458dd772d9"
    Actor ID: <0.98.0> Output: "a.patil:8134402"  "0000ffc94db2b447591b036ba065d052f5ed5bbc7b26541fd39cfc8c3a1719b0"
    Actor ID: <0.96.0> Output: "a.patil:4176024"  "0000dfe70aa3a49a31aa2dfee73d175b5e7ae1a4da7224b6e5bcf17522e4a624"
    Actor ID: <0.98.0> Output: "a.patil:8239919"  "00004071215c4a5bea9e7ff10999564ad24bdb098772e8ce7e86354bf1bd4cea"
    Actor ID: <0.94.0> Output: "a.patil:250848"  "0000d8754e9130379be1d94b5e1bcdbedd33443dec7b99ae3f2448eb6a090fb7"
    Actor ID: <0.94.0> Output: "a.patil:315024"  "0000cb7f023b784c2896f68740c5cd803ef68ec632976a3b0ecc330dc0256420"
    Actor ID: <0.97.0> Output: "a.patil:6339940"  "0000c340fef3fa30fa7e406339b72902e2ce9f49e92a990cc968717b669571c5"
    Actor ID: <0.98.0> Output: "a.patil:8344244"  "000072ee9f6bced14efce9c972e1836924aeb37dd34e6b40985394ca25fe7ba3"
    Actor ID: <0.97.0> Output: "a.patil:6362612"  "000084ee38577334950c542fe0427f7f481fa0a255b98a33aa21117578469aee"
    Actor ID: <0.97.0> Output: "a.patil:6378070"  "000052f746ba53f6500945ece25c9997ae3dc1600004f09951bcc67b58315d11"
    Actor ID: <0.98.0> Output: "a.patil:8380510"  "0000c09666e09c71c54dcfa0c0c82650d8bd53ba2786aa2d5ecfb8fc9a171aeb"
    Actor ID: <0.96.0> Output: "a.patil:4399275"  "0000bbb0845bd7da19b4654167cb34dc94226623307a11dbf373587289797435"
    Actor ID: <0.99.0> Output: "a.patil:10384535"  "0000c9ef2e524c665e59141dc96a7d03ff1e33a0fbaf2ab69032d58f06a21f6b"
    Actor ID: <0.95.0> Output: "a.patil:2422529"  "000034f3d4907e5069b3cf112f1ca50568517f6ef436f786641b3381e35ebae3"
    Actor ID: <0.94.0> Output: "a.patil:420397"  "00005d5b28db0138e3652697a88b53b348603d1821f995592e43fe03bdeb9686"
    Actor ID: <0.96.0> Output: "a.patil:4440468"  "0000e28eedb2c24f10994002d3159ac96574836620cbd49071269ad520c6c3ff"
    Actor ID: <0.97.0> Output: "a.patil:6433940"  "0000e77071d42385dddad1a13f4c45c972b9ae0886461400d299ad9e419a3578"
    Actor ID: <0.99.0> Output: "a.patil:10429404"  "000097691c7759bf5b403bfa8fc73709fb45053472b7bb78805dd96c1b061f7b"
    Actor ID: <0.96.0> Output: "a.patil:4455669"  "0000f423927506f1d9f7297c60525ed4ba13df7549953c5deb41fa4b3c7da7bd"
    Actor ID: <0.95.0> Output: "a.patil:2469313"  "0000f5e630151504af293138b4c0d5216a5742518b73d93b137be77369f08bd4"
    Actor ID: <0.95.0> Output: "a.patil:2479914"  "000089a34a0df63593aee0f58c661590fb230f3c395f34c1f3fd926a120e0108"
    Actor ID: <0.97.0> Output: "a.patil:6467315"  "00006c6d49cc1e40652a7b00d2abda40cc4c9031bdb1420b7b8c95059bb814fd"
    Actor ID: <0.94.0> Output: "a.patil:463840"  "0000345b334b3c1b81d35423ae05773ab80092e7d70931355e5f3cfed2a31d1d"
    Actor ID: <0.94.0> Output: "a.patil:481211"  "0000648a95b35f7e69c9c674b692167b0219dc283bc7eadaa2e5840c1ac88688"
    Actor ID: <0.94.0> Output: "a.patil:493076"  "000085f8d0519ceb3d0bbdb881ae8f9359e985a1de6844927a2699d0ffa8a452"
    Actor ID: <0.95.0> Output: "a.patil:2512867"  "0000fee2dc588d14a7d9f7143a3a01892f977958af70696c4a03ca5c0dd028ac"
    Actor ID: <0.97.0> Output: "a.patil:6503056"  "0000c9d6d84576df7b0d13218d10670431df27e4e66f41948ea97a541d3c9c9c"
    Actor ID: <0.94.0> Output: "a.patil:503689"  "0000ea14f22d85e4a9e5039c41d8622ef17a168d2f3032bf1ea6ff5f77142fe4"
    Actor ID: <0.96.0> Output: "a.patil:4546256"  "0000d5a90a4743ad61cf402f6fdbc960e4039cc222f1c21be6f003ff050acc6b"</pre>

* The running time for the above is reported by time for the above and report the time. 
  * We ran the hash miner for 5 leading zeroes and recorded the time for serialized and actor model implementation.
  Please refer to the following screenshots:
   * Time for Serial Implementation : 4ms
   <img width="712" alt="Screenshot 2022-09-24 at 18 42 11" src="https://user-images.githubusercontent.com/54627841/192121254-38633282-576a-4eff-847b-e5470f462b3b.png">
   

  * Time for Actor Model Implentation for 350 actors working asynchronously: ~1ms
  <img width="981" alt="Screenshot 2022-09-24 at 18 49 35" src="https://user-images.githubusercontent.com/54627841/192121259-ea1afc4c-ccfc-4f5f-b3b9-e17cba052f23.png">
  
* The ratio of CPU time to REAL TIME tells you how many cores were effectively used in the computation. 
  * CPU time [Multicore Actor Model]= ~1ms = 1ms
  * Real time [Single-Core Serialized Model] = 4ms
  * Absolute Ratio = CPU Time / Real Time = 1/4 = 0.25

* The coin with the most 0s you managed to find is 7.
![image](https://user-images.githubusercontent.com/41022671/192121563-6fb48de5-e805-44f9-9a5a-fb898834870d.png)

* The Multicore distributed asynchronous model was executed on 2 machines, where one machine acted as a server, while the other acted as a client.
