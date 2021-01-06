const addIngredient = () => {
  const pushButton = document.getElementById('add-ingredient-btn');
  pushButton.addEventListener('click', (event) => {
    // au click, récupérer l'id de l'ingrédient
    const ingredientId = document.querySelectorAll('.ingredient_id');
    console.log(ingredientId);
    // afficher la valeur de l'ingrédient dans une liste
    // recommencer jusqu'à click "valider"

  });
}


export { addIngredient };


