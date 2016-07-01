function isPrime(num) {
  if (num === 1) return false;
  for (let i = 2; i < num; i ++) {
    if (num % i === 0) return false;
  }
  return true;
}

(function problem1() {
  let multiples = [];
  for ( let i = 1; i < 1000; i++ ) {
    if (i % 3 === 0 || i % 5 === 0) multiples.push(i);
  }
  return multiples.reduce((prev, curr) => prev + curr) 
})()

(function problem2() {
  fibs = [1, 2];
  evens = [2];
  while (fibs.slice(-1)[0] < 4000000) {
    let fib = fibs.slice(-1)[0] + fibs.slice(-2)[0];
    fibs.push(fib);
    if (fib % 2 === 0) evens.push(fib);
  }
  return evens.reduce((prev, curr) => prev + curr);
})()

(function problem3() {
  let factorize = 600851475143;
  let largestPrimeFactor = 1;
  for (let i = 2; i <= factorize; i++) {
    if (isPrime(i) && factorize % i === 0) {
      factorize /= i;
      largestPrimeFactor = i;
    }
  }
  return largestPrimeFactor
})()

(function problem4() {
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
})()

(function problem5() {
  let multiple = (2 * 3 * 5 * 7 * 11 * 13 * 17 * 19);
  for (let i = 1; ; i++ ) {
    for (let j = 1; j <= 20; j++ ) {
      if ((i * multiple) % j !== 0) break;
      if (j === 20) return (i * multiple);
    }
  }
})()

(function problem6() {
  let numbers = [];
  for (let i = 1; i <= 100; i++ ) {
    numbers.push(i);
  }
  let sum_of_squares = numbers.reduce((prev, curr) => prev += Math.pow(curr, 2));
  let square_of_sums = Math.pow(numbers.reduce((prev, curr) => prev += curr), 2);
  return square_of_sums - sum_of_squares;
})()

(function problem7() {
  let i = 0;
  for (let j = 2; ; j++) {
    if (isPrime(j)) {
      i++;
      if (i === 10001) return j;
    }
  }
})()

(function problem8() {
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
})()

(function problem9() {
  for (let a = 1; a < 998; a++) {
    for (let b = 1; b < 998; b++) {
      let c = 1000 - a - b;
      if (((a*a) + (b*b)) === (c*c)) return `With a = ${a}, b = ${b} and c = ${c}, product is ${a*b*c}.`;
    }
  }
})()

function problem10() {
  let sum = 0;
  for (let i = 2; i < 2000000; i++) {
    if (isPrime(i)) sum += i;
  }
  return sum;
}