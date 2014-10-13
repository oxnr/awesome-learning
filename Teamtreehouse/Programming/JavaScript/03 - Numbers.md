# Javascript

## Numbers

### Basics

Basic ways to create numbers

```javascript
//Whole numbers
var a = 11,
    b = -123;

var c = 1.5,
    d = 123.456789;

var e = 0.1
    f = 0.2;

var result = e * f;

var g = 1E6;

// Leading 0 causes it to be an octo-number
var h = 012;

// 0x converts it to a hexadecimal literal
var i = 0x10
```

### Parsing numbers from strings

Cast strings to ints

```javascript
var number = "197";
var j = parseInt(number);

var k = parseInt("010111",2);
var l = parseInt("There are 23 peope",10);

console.log(isNaN(l));

var m = parseFloat("123.456 is a strange number");
```

### Operators

Performing mathematical operations

```javascript
var o = j + k;
var p = 10 - 7.3;

var q = 3 * 4.2;
var r = 16 / 8;

var s = 15 % 10;

var t = (1 + 2) * 3 / 4;
```

### Comparison

Comparing numbers

```javascript
console.log(1<2);
// === will also make sure to check the type
console.log(1 === 1.5);
console.log(1 !== parseInt("3"));
```

### The Math Object

Useful constants and functions

```javascript
var u = Math.round(Math.random() * 10);
var v = Math.round(2.3);
var w = Math.floor(3.7);
var x = Math.ceil(6.2);

var y = Math.pow(2,5);
var z = Math.sqrt(4);
```
