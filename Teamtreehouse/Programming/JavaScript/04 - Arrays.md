# Javascript

## Arrays

### Creating Arrays

Basic ways to create arrays

```javascript
var x = ['some','extra','words','here'];
console.log(x.length);

var y = ['a string', ['a sub array', 2, 3, 4], true, 'treehouse', function(a,b){return a+b;}]
var z = [];

var a = new Array(50);
```

### Getting and Setting

Retrieve and set values at specific points

```javascript
var my_array = ["Hello",42,true,function(a){return a*2}];

// Getting values
var word = my_array[0];
var answer = my_array[1];
var doubler = my_array[3];

// Call function from the array
console.log(doubler(10));

// Setting values
my_array[1] = 144;
var new_answer = my_array[1];

my_array[my_array.length] = "A new string";
```
### Methods

Manipulate content of array

```javascript
var my_array = [2,3,4];
console.log(my_array.toString());

my_array.push(5);
console.log(my_array.toString());

var value = my_array.pop();
console.log(my_array.toString());
console.log(value.toString());

my_array.unshift(1);
console.log(my_array.toString());

var value2 =my_array.shift();
console.log(my_array.toString());
console.log(value2.toString());

var my_array2 = [10,44,32,100,0,44,3,4];
console.log(my_array2.toString());
my_array2.sort(function (a, b){
    // Sort ascending
    // return a - b;
    // Sort randomly
    // return Math.random() - 0.5;
});
console.log(my_array2.toString());

my_array2.reverse();

var x = [1,2,3];
var y = [4,5,6];
var z = x.concat(y);

var my_array3 = [0,1,2,3,4,5];
var result = my_array3.slice(1,4);
console.log(result);

var words = ["these","are","some","words"];
var result2 = words.join(" ");
```
**Splice**

Splice is one of the most powerful methods for arrays in javascript

```javascript
var my_array = [0,1,2,3,4,5,6];
console.log(my_array.toString());

//delete my_array[2];
my_array.splice(2,1)

my_array.splice(2,0, 'two')

console.log(my_array.toString());
```
