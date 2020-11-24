require "nokogiri"
require "open-uri"

# Fonction Précautions d'utilisation
def warning_sentences(name)
  case
    when name.include?("Absolue")
      return "Peut présenter un risque d'allergie", "Faites un test d’application de votre préparation finale ou du produit pur dilué à 1%, dans le pli du coude, au moins 48h avant utilisation", "Toxique pour les organismes aquatiques"
    when name.include?("Actif cosmétique")
      return "Ne pas avaler, ne pas inhaler, éviter le contact avec les yeux", "Respecter les dosages recommandés", "Faites un test d’application de votre préparation, dans le pli du coude, au moins 48h avant utilisation.", "Port de gants, de masque et de lunettes recommandé pour la manipulation"
    when name.include?("Agent")
      return "Ne pas avaler, ne pas inhaler, éviter le contact avec les yeux", "Port de gants, de masque et de lunettes recommandé pour la manipulation", "Pour les agents sous forme de cristaux, ne pas mélanger à des acides dans des contenants fermés"
    when name.include?("Argile")
      return "Ne pas inhaler, ne pas utiliser près d'une source de ventilation", "Ne pas réutiliser une argile ayant déjà été utilisée"
    when name.include?("Cire")
      return "Risque de brûlure lorsque la cire est fondue", "Ne pas avaler, éviter le contact avec les yeux", "Certaines cires florales peuvent présenter un risque d'allergie"
    when name.include?("Colorant capillaire")
      return "Rincer à l'eau claire en cas de contact avec les yeux", "Ne pas inhaler, ne pas utiliser près d'une source de ventilation", "Faites un test d’application de votre préparation finale ou du produit pur dilué à 1%, dans le pli du coude, au moins 48h avant utilisation"
    when name.include?("Colorant")
      return "Éviter le contact avec les yeux", "Ne pas appliquer pur sur la peau", "Protégez les surfaces et les vêtements lors de l'utilisation"
    when name.include?("Conservateur") || name.include?("Anti-oxydant")
      return "Ne pas avaler, ne pas inhaler, éviter le contact avec les yeux", "Ne pas appliquer pur sur la peau", "Faites un test d’application de votre préparation ou du produit pur dilué à 1%, dans le pli du coude, au moins 48h avant utilisation"
    when name.include?("Eau aromatique")
      return "Peut présenter un risque d'allergie"
    when name.include?("Ecodétergent")
      return "Ne pas avaler, ne pas inhaler, éviter le contact avec la peau", "Rincer à l'eau claire en cas de contact avec les yeux", "Port de gants, de masque et de lunettes recommandé pour la manipulation"
    when name.include?("Emulsifiant")
      return "Ne pas avaler, ne pas inhaler, éviter le contact avec les yeux"
    when name.include?("Extrait")
      return "Ne pas avaler", "Peut présenter un risque d'allergie", "Certains de ces produits peuvent être toxiques et sont déconseillés chez la femme enceinte ou allaitante. Se renseigner avant utilisation", "Conserver à l'abris de la lumière et de la chaleur", "Faites un test d’application de votre préparation ou du produit pur dilué à 1%, dans le pli du coude, au moins 48h avant utilisation"
    when name.include?("Fragrance")
      return "Ne pas avaler, éviter le contact avec les yeux", "Peut présenter un risque d'allergie", "Faites un test d’application de votre préparation ou du produit pur dilué à 1%, dans le pli du coude, au moins 48h avant utilisation", "Toxique pour les organismes aquatiques"
    when name.include?("Gomme")
      return "Ne pas inhaler, ne pas utiliser près d'une source de ventilation, éviter le contact avec les yeux", "Ne pas avaler sans diluer au préalable"
    when name.include?("Huile essentielle")
      return "Toujours utiliser avec précaution et modération", "La plupart des huiles essentielles ne doivent pas être utilisées chez la femme enceinte ou allaitante ni chez l'enfant de moins de 6 ans. Se renseigner avant toute utilisation", "Rincer à l'eau claire en cas de contact avec les yeux", "Ne pas utiliser pure sur la peau", "Peut présenter un risque d'allergie", "Faites un test d’application de votre préparation ou du produit pur dilué à 1%, dans le pli du coude, au moins 48h avant utilisation", "Certaines huiles essentielles peuvent être photosensibilisantes"
    when name.include?("Huile végétale")
      return "Peut présenter un risque d'allergie"
    when name.include?("Macérât huileux")
      return "Peut présenter un risque d'allergie", "Ne pas avaler", "Certains macérâts ne doivent pas être utilisés chez les jeunes enfants et les femmes enceintes. Se renseigner avant toute utilisation", "Certains macérâts peuvent être photosensibilisants"
    when name.include?("Nacre")
      return "Ne pas avaler, ne pas inhaler, éviter le contact avec les yeux", "Port de gants, de masque et de lunettes recommandé pour la manipulation"
    when name.include?("Pigment Végetal")
      return "Ne pas avaler pur", "Rincer à l'eau claire en cas de contact avec les yeux"
    when name.include?("Plante ayurvédique")
      return "Conserver dans un pot hermétique à l'abris de la lumière", "Faites un test d’application de votre préparation finale ou du produit pur dilué à 1%, dans le pli du coude, au moins 48h avant utilisation", "Port d'un masque et de lunettes recommandé", "Rincer à l'eau claire en cas de contact avec les yeux", "La consommation de certaines plantes est déconseillée chez la femme enceinte ou allaitante et chez l'enfant de moins de 6 ans. Se renseigner avant utilisation"
    when name.include?("Poudre support")
      return "Ne pas utiliser près d'une source de ventilation", "Port de gants, d'un masque et de lunettes recommandé"
    when name.include?("Sels")
      return "Éviter le contact avec les yeux"
    when name.include?("Tensioactif")
      return "Ne pas avaler, ne pas inhaler, ne pas jamais mettre en contact avec les yeux ni pur sur la peau (provoque des lésions graves)", "Port de gants, d'un masque et de lunettes obligatoire", "Ne pas surchauffer", "Toxique pour les organismes aquatiques"
    when name.include?("Vinaigre naturel")
      return "Ne pas appliquer pur", "Ne pas boire"
    end
end

def scrapping(url)
  doc = Nokogiri::HTML(open(url))
  products = doc.search(".product-title")
  products.each do |product|
    part1 = product.search("h3")
    part2 = product.search(".product-link")
    full_name = part1.text.strip + " " + part2.text.strip

    warning = ["Tenir hors de portée des enfants", "Toujours respecter les dosages recommandés"]
    warning.push(warning_sentences(full_name))

    if !full_name.include?("neutre") && !full_name.include?("base")
      ingredient = Ingredient.new(name: full_name, alert: warning.join(", "))
      ingredient.save!
      puts "#{ingredient.name} created ! Warning : #{ingredient.alert}"
    end
  end
end

scrapping("db/extraits_naturels.html")
scrapping("db/ingredients_cosmetiques.html")


# Création des catégories
Category.destroy_all

puts "Destroy categories"
cosmétiques = Category.create!(name: "Cosmétiques")
entretien_maison = Category.create!(name: "Entretien maison")
santé = Category.create!(name: "Santé et bien-être")
puts "Categories created"

# Création des units
Unit.destroy_all

puts "Destroy units"
g = Unit.create!(name: "g")
mg = Unit.create!(name: "mg")
kg = Unit.create!(name: "kg")
l = Unit.create!(name: "l")
ml = Unit.create!(name: "ml")
cl = Unit.create!(name: "cl")
dl = Unit.create!(name: "dl")
cac = Unit.create!(name: "cuill. à café")
cas = Unit.create!(name: "cuill. à soupe")
goutte = Unit.create!(name: "goutte")
puts "Units created"


