const addIngredient = () => {
  const pushButton = document.getElementById('add-ingredient-btn');
  pushButton.addEventListener('click', (event) => {
    // au click, récupérer le nom de l'ingrédient
    const ingredientSelected = document.getElementById("recipe_measures_attributes_0_ingredient_id");
    const ingredientName = ingredientSelected.options[ingredientSelected.selectedIndex].text;
    const ingredientQuantity = document.getElementById("recipe_measures_attributes_0_quantity").value;
    const ingredientSelectedUnit = document.getElementById("recipe_measures_attributes_0_unit_id");
    const ingredientUnit = ingredientSelectedUnit.options[ingredientSelectedUnit.selectedIndex].text;
    console.log(ingredientUnit)
    // afficher la valeur de l'ingrédient dans une liste
    const list = document.getElementById('recipe-ingredients-list');
    const newIngredient = `<li>${ingredientQuantity} ${ingredientUnit} - ${ingredientName}</li>`
    list.insertAdjacentHTML("beforeend", newIngredient);
    // recommencer jusqu'à click "valider"

  });
};




export { addIngredient };


