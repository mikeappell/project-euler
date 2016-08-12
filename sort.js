function mergeSort(input) {
  if (input.length < 2) { return input; }
  let mid = Math.floor(input.length / 2);
  let left = input.slice(0, mid);
  let right = input.slice(mid);

  let merge = function(left, right) {
    let new_array = [];
    while (left.length > 0 && right.length > 0) {
      if (left[0] < right[0]) {
        new_array.push(left.shift());
      } else {
        new_array.push(right.shift());
      }
    }
    return new_array.concat(left).concat(right);
  }

  return merge(mergeSort(left), mergeSort(right));
}

function bubbleSort(input) {
  while (true) {
    let sorted = true
    for (let i = 0; i < input.length - 1; i++) {
      if (input[i] > input[i + 1]) {
        let temp = input[i]
        input[i] = input[i + 1]
        input[i + 1] = temp
        sorted = false;
      }
    }
    if (sorted) break
  }
  return input
}
