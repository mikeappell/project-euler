function isPrime(num) {  // Determines positive prime numbers
  if (num <= 1) return false;
  for (let i = 2; i <= Math.floor(Math.sqrt(num)); i++) {
    if (num % i === 0) return false;
  }
  return true;
}

function numberOfDivisors(x) {
    let limit = x;
    let numberOfDivisors = 0;

    if (x == 1) return 1;

    for (let i = 1; i < limit; ++i) {
        if (x % i == 0) {
            limit = x / i;
            if (limit != i) {
                numberOfDivisors++;
            }
            numberOfDivisors++;
        }
    }

    return numberOfDivisors;
}

function stringToNDimArray(input_string, separator, breakpoint) {
  let splitString = input_string.split(separator)
  let nDimString = []
  for (let i = 0; i < splitString.length; i += breakpoint) {
    nDimString.push(splitString.slice(i, i + breakpoint))
  }
  return nDimString
}

function problem1() {
  let multiples = [];
  for (let i = 1; i < 1000; i++) {
    if (i % 3 === 0 || i % 5 === 0) multiples.push(i);
  }
  return multiples.reduce((prev, curr) => prev + curr) 
}

function problem2() {
  fibs = [1, 2];
  evens = [2];
  while (fibs.slice(-1)[0] < 4000000) {
    let fib = fibs.slice(-1)[0] + fibs.slice(-2)[0];
    fibs.push(fib);
    if (fib % 2 === 0) evens.push(fib);
  }
  return evens.reduce((prev, curr) => prev + curr);
}

function problem3() {
  let factorize = 600851475143;
  let largestPrimeFactor = 1;
  for (let i = 2; i <= factorize; i++) {
    if (isPrime(i) && factorize % i === 0) {
      factorize /= i;
      largestPrimeFactor = i;
    }
  }
  return largestPrimeFactor
}

function problem4() {
  let largestPalindrome = 0;
  let increment = 0;
  for (let i = 100; i < 1000; i++) {
    for (let j = 100 + increment; j < 1000; j++) {
      let num = i * j;
      let numString = num.toString();
      if (numString === numString.split("").reverse().join("") && num > largestPalindrome) largestPalindrome = num;
    }
    increment++;
  }
  return largestPalindrome;
}

function problem5() {
  let multiple = (2 * 3 * 5 * 7 * 11 * 13 * 17 * 19);
  for (let i = 1; ; i++ ) {
    for (let j = 1; j <= 20; j++ ) {
      if ((i * multiple) % j !== 0) break;
      if (j === 20) return (i * multiple);
    }
  }
}

function problem6() {
  let numbers = [];
  for (let i = 1; i <= 100; i++ ) {
    numbers.push(i);
  }
  let sum_of_squares = numbers.reduce((prev, curr) => prev += Math.pow(curr, 2));
  let square_of_sums = Math.pow(numbers.reduce((prev, curr) => prev += curr), 2);
  return square_of_sums - sum_of_squares;
}

function problem7() {
  let i = 0;
  for (let j = 2; ; j++) {
    if (isPrime(j)) {
      i++;
      if (i === 10001) return j;
    }
  }
}

function problem8() {
  adjacentString = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";

  let largest = 0;
  for (i = 0; i < 987; i++) {
    let currentValue = 1;
    for (j = 0; j < 13; j++) {
      currentValue *= parseInt(adjacentString[i + j]);
    }
    if (currentValue > largest) largest = currentValue;
  }
  return largest;
}

function problem9() {
  for (let a = 1; a < 998; a++) {
    for (let b = 1; b < 998; b++) {
      let c = 1000 - a - b;
      if (((a*a) + (b*b)) === (c*c)) return `With a = ${a}, b = ${b} and c = ${c}, product is ${a*b*c}.`;
    }
  }
}

function problem10() {
  let sum = 0;
  for (let i = 2; i < 2000000; i++) {
    if (isPrime(i)) sum += i;
  }
  return sum;
}

function problem11() {
  let myString = "08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08 \
  49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00 \
  81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65 \
  52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91 \
  22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80 \
  24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50 \
  32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70 \
  67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21 \
  24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72 \
  21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95 \
  78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92 \
  16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57 \
  86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58 \
  19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40 \
  04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66 \
  88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69 \
  04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36 \
  20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16 \
  20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54 \
  01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48"

  let input_array = stringToNDimArray(myString, " ", 20)

  let greatest_product = 0

  // Horizontal
  for (let i = 0; i < input_array.length; i++) {
    for (let j = 3; j < input_array[i].length; j++) {
      let current_product = input_array[i][j-3] * input_array[i][j-2] * input_array[i][j-1] * input_array[i][j]
      if (current_product > greatest_product) {
        greatest_product = current_product
      }
    }
  }
  //Vertical
  for (let i = 3; i < input_array.length; i++) {
    for (let j = 0; j < input_array[i].length; j++) {
      let current_product = input_array[i-3][j] * input_array[i-2][j] * input_array[i-1][j] * input_array[i][j]
      if (current_product > greatest_product) {
        greatest_product = current_product
      }
    }
  }
  //Diagonal - Left to Right
  for (let i = 3; i < input_array.length; i++) {
    for (let j = 3; j < input_array[i].length; j++) {
      let current_product = input_array[i][j] * input_array[i-1][j-1] * input_array[i-2][j-2] * input_array[i-3][j-3]
      if (current_product > greatest_product) {
        greatest_product = current_product
      }
    }
  }
  //Diagonal - Right to Left
  for (let i = 3; i < input_array.length; i++) {
    for (let j = 0; j < input_array[i].length; j++) {
      let current_product = input_array[i][j] * input_array[i-1][j+1] * input_array[i-2][j+2] * input_array[i-3][j+3]
      if (current_product > greatest_product) {
        greatest_product = current_product
      }
    }
  }

  return greatest_product
}

function problem12() {
  let start = new Date().getTime()
  let divisorCount = 1
  let triangleCount = 2
  let triangleNumber = 1
  while (divisorCount < 500) {
    triangleNumber += triangleCount
    divisorCount = numberOfDivisors(triangleNumber)
    triangleCount++
  }
  console.log(`Took ${(new Date().getTime() - start) / (60*60)} seconds.`)
  return triangleNumber
}




