const addIngredient = (event) => {
  const pushButton = document.querySelector('.add-ingredient-btn')
  pushButton.addEventListener('click', (event) => {
  console.log(event);
  });
}


export { addIngredient };



