# CPU

<img src="../images/cpu.png"/>

# Control Unit
The expression for output signals:

* Clear = <span style="text-decoration: overline;">Reset_n</span> + Done + (<span style="text-decoration: overline;">Run</span>T<sub>0</sub>)
* IRin = RunT<sub>0</sub>
* DINout = I<sub>1</sub>T<sub>1</sub>
* Done = (I<sub>0</sub> + I<sub>1</sub>)T<sub>1</sub> + (I<sub>2</sub> + I<sub>3</sub>)T<sub>3</sub>
* Ain = (I<sub>2</sub> + I<sub>3</sub>)T<sub>1</sub>
* Gin = (I<sub>2</sub> + I<sub>3</sub>)T<sub>2</sub>
* Gout = (I<sub>2</sub> + I<sub>3</sub>)T<sub>3</sub>
* AddSub = I<sub>3</sub>T<sub>2</sub>
* R<span style="color:red">i</span><sub>in</sub> = (I<sub>0</sub> + I<sub>1</sub>)T<sub>1</sub>X<sub><span style="color:red">i</span></sub> + (I<sub>2</sub> + I<sub>3</sub>)T<sub>3</sub>X<sub><span style="color:red">i</span></sub> with 0 &le; <span style="color:red">i</span> &le; 7
* R<span style="color:red">i</span><sub>out</sub> = I<sub>0</sub>T<sub>1</sub>Y<sub><span style="color:red">i</span></sub> + (I<sub>2</sub>  + I<sub>3</sub>)(T<sub>1</sub>X<sub><span style="color:red">i</span></sub> + T<sub>2</sub>Y<sub><span style="color:red">i</span></sub>) with 0 &le; <span style="color:red">i</span> &le; 7


| Operation     | Function performed |
|:--------------|:------------------:|
| Move Rx, Ry   | Rx ⟵ [Ry]         |    
| Load Rx, Data | Rx ⟵ Data         |
| Add Rx, Ry    | Rx ⟵ [Rx] + [Ry]  |
| Sub Rx, Ry    | Rx ⟵ [Rx] - [Ry]  |

|    | T<sub>1</sub>  | T<sub>2</sub>  | T<sub>3</sub>  |
|---:|:---:|:---:|:---:|
|(Move): **I<sub>0</sub>**|Rin = X, Rout = Y, Done| | |
|(Load): **I<sub>1</sub>**|DINout, Rin = X, Done| | |
|(Add): **I<sub>2</sub>** |Rout = X, Ain | Rout = Y, Gin, AddSub = 0| Gout, Rin = X, Done|
|(Sub): **I<sub>3</sub>** |Rout = X, Ain | Rout = Y, Gin, AddSub = 1| Gout, Rin = X, Done|


# AddSub
The AddSub module uses the Carry Select Adder (CSlA) architecture.

![addsub](../images/addsub.png)

## FA

<img src="../images/fa.png" width="520" />

## C0_FA

<img src="../images/c0_fa.png" width="300" />

## C1_FA

<img src="../images/c1_fa.png" width="450" />

## NoCout_FA

<img src="../images/no_cout_fa.png" width="300" />

