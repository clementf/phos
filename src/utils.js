export const toggleArrayElement = (array, element) => {
  const index = array.indexOf(element);
  if (index >= 0) delete array[index];
  else array.push(element);

  return array;
};

export const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
